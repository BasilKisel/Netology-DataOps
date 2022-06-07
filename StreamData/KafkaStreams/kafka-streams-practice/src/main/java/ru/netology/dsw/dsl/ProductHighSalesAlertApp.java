package ru.netology.dsw.dsl;

import io.confluent.kafka.schemaregistry.client.CachedSchemaRegistryClient;
import io.confluent.kafka.schemaregistry.client.SchemaRegistryClient;
import io.confluent.kafka.serializers.KafkaAvroSerializerConfig;
import io.confluent.kafka.streams.serdes.avro.GenericAvroSerde;
import org.apache.avro.LogicalTypes;
import org.apache.avro.Schema;
import org.apache.avro.SchemaBuilder;
import org.apache.avro.generic.GenericData;
import org.apache.avro.generic.GenericRecord;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.*;
import org.apache.kafka.streams.errors.StreamsUncaughtExceptionHandler;
import org.apache.kafka.streams.kstream.*;

import java.time.Duration;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;

/**
 * **Задание: **Написать приложение, которое будет отправлять сообщение-алерт, если сумма денег заработанных по этому продукту (для каждой покупки сумма - это purchase.quantity * product.price) за последнюю минуту больше 3 000.
 * Для генерации данных использовать файлы purchase.avsc и product.avsc из репозитория github.com...s-practice"
 */
public class ProductHighSalesAlertApp {

    public static final String PURCHASE_TOPIC_NAME = "purchases";

    public static final String PRODUCT_TOPIC_NAME = "products";

    public static final Duration CHECK_PERIOD = Duration.ofMinutes(1);

    public static final double REVENUE_THRESHOLD = 3_000d;

    public static final String PRODUCT_HIGH_SALES_ALERT_TOPIC_NAME = "high_sales_alert";

    public static final String DLQ_TOPIC_NAME = "product_high_sales_alert_errors";

    public static void main(String... args) throws InterruptedException {
        String schemaRegistryUrl = "http://localhost:8090";
        CachedSchemaRegistryClient schemaClient = new CachedSchemaRegistryClient(schemaRegistryUrl, 16);
        Map<String, String> serdeProps = Map.of(
                KafkaAvroSerializerConfig.AUTO_REGISTER_SCHEMAS, "true",
                KafkaAvroSerializerConfig.SCHEMA_REGISTRY_URL_CONFIG, schemaRegistryUrl
        );

        Topology topology = buildTopology(schemaClient, serdeProps);
        System.out.println(topology.describe());

        KafkaStreams kStreams = new KafkaStreams(topology, getKStreamsConfig());
        CountDownLatch latch = new CountDownLatch(1);
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                kStreams.close();
                latch.countDown();
            }
        });
        kStreams.setUncaughtExceptionHandler(new StreamsUncaughtExceptionHandler() {
            @Override
            public StreamThreadExceptionResponse handle(Throwable exception) {
                exception.printStackTrace();
                return StreamThreadExceptionResponse.SHUTDOWN_APPLICATION;
            }
        });

        try {
            kStreams.start();
            latch.await();
        } catch (Exception ex) {
            ex.printStackTrace();
            System.exit(1);
        }
        System.exit(0);
    }

    public static Properties getKStreamsConfig() {
        Properties prop = new Properties();
        prop.put(StreamsConfig.APPLICATION_ID_CONFIG, "ProductHighSalesAlert");
        prop.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        return prop;
    }

    public static Topology buildTopology(SchemaRegistryClient client, Map<String, String> serdeConfig) {
        GenericAvroSerde avroSerde = new GenericAvroSerde(client);
        avroSerde.configure(serdeConfig, false); // Avro for values only

        StreamsBuilder builder = new StreamsBuilder();

        // Data sources
        KStream<String, GenericRecord> purchases = builder.stream(
                PURCHASE_TOPIC_NAME,
                Consumed
                        .with(new Serdes.StringSerde(), avroSerde)
                        .withOffsetResetPolicy(Topology.AutoOffsetReset.LATEST)
        );
        // globalTable since purchases aren't co-partitioned with products
        GlobalKTable<String, GenericRecord> products = builder.globalTable(
                PRODUCT_TOPIC_NAME,
                Consumed.with(new Serdes.StringSerde(), avroSerde)
        );

        KStream<String, DetailedPurchase> detailedPurchases = purchases.join(products,
                (purchase_id, purchase_body) -> purchase_body.get("productid").toString(),
                ProductHighSalesAlertApp::buildDetailedPurchase
        );

        // correct matching
        detailedPurchases
                .filter((product_id, details) -> details.success)
                .mapValues(det_rec -> det_rec.details)
                .groupBy((key, val) -> val.get("productid").toString(), Grouped.with(new Serdes.StringSerde(), avroSerde))
                .windowedBy(TimeWindows.of(CHECK_PERIOD).advanceBy(CHECK_PERIOD))
                .aggregate(() -> PurchasesAggregate.createZeroRecord(),
                        (key, val, aggRec) -> PurchasesAggregate.reduce(aggRec, (Long) val.get("amount"), (Double) val.get("revenue")),
                        Materialized.with(new Serdes.StringSerde(), avroSerde))
                .filter((product_id, aggRec) -> REVENUE_THRESHOLD < (Double) aggRec.get("revenue"))
                .mapValues((product_id, alerted_agg) -> {
                    alerted_agg.put("window_start", product_id.window().start());
                    return alerted_agg;
                }).toStream()
                .map((product_id, aggr) -> KeyValue.pair(product_id.key(), aggr))
                .to(PRODUCT_HIGH_SALES_ALERT_TOPIC_NAME, Produced.with(new Serdes.StringSerde(), avroSerde));
        ;

        // exceptions
        detailedPurchases
                .filter((product_id, details) -> !details.success)
                .mapValues(wrongDetails -> wrongDetails.errorMessage)
                .to(DLQ_TOPIC_NAME);

        return builder.build();
    }

    private static DetailedPurchase buildDetailedPurchase(GenericRecord purchase, GenericRecord product) {
        try {
            Schema purchaseDetailSchema = SchemaBuilder.record("AggregatedPurchases").fields()
                    .requiredLong("amount")
                    .requiredDouble("revenue") // probably for alert save money in Double is fine
                    .requiredLong("productid")
                    .endRecord();
            GenericRecord details = new GenericData.Record(purchaseDetailSchema);
            details.put("amount", purchase.get("quantity"));
            details.put("revenue", (Double) product.get("price") * (Long) purchase.get("quantity"));
            details.put("productid", product.get("id"));
            return new DetailedPurchase(true, details, null);
        } catch (Exception ex) {
            String errorTxt =
                    "purchase: {" + (purchase == null ? "" : purchase.toString())
                            + "},\nproduct: {" + (product == null ? "" : product.toString())
                            + "},\nexception: " + ex.toString();
            return new DetailedPurchase(false, purchase, errorTxt);
        }
    }

    private static record DetailedPurchase(boolean success, GenericRecord details, String errorMessage) {
    }

    private static class PurchasesAggregate {

        private static final Schema AGG_SCHEMA = SchemaBuilder.record("AggregatedPurchases").fields()
                .requiredLong("total_amount")
                .requiredLong("purchases_count")
                .requiredDouble("revenue") // probably for alert save money in Double is fine
                .name("window_start").type(LogicalTypes.timestampMillis().addToSchema(Schema.create(Schema.Type.LONG))).noDefault()
                .endRecord();

        public static GenericRecord createZeroRecord() {
            GenericRecord init_rec = new GenericData.Record(AGG_SCHEMA);
            init_rec.put("total_amount", 0L);
            init_rec.put("purchases_count", 0L);
            init_rec.put("revenue", 0d);
            init_rec.put("window_start", 0L);
            return init_rec;
        }

        public static GenericRecord reduce(GenericRecord aggRec, Long amount, Double revenue) {
            aggRec.put("total_amount", amount + (Long) aggRec.get("total_amount"));
            aggRec.put("purchases_count", 1L + (Long) aggRec.get("purchases_count"));
            aggRec.put("revenue", revenue + (Double) aggRec.get("revenue"));
            return aggRec;
        }
    }
}
