package ru.netology.dsw.dsl;

import io.confluent.kafka.schemaregistry.avro.AvroSchema;
import io.confluent.kafka.schemaregistry.avro.AvroSchemaProvider;
import io.confluent.kafka.schemaregistry.client.CachedSchemaRegistryClient;
import io.confluent.kafka.schemaregistry.client.MockSchemaRegistryClient;
import io.confluent.kafka.schemaregistry.client.SchemaRegistryClient;
import io.confluent.kafka.schemaregistry.client.rest.entities.SchemaReference;
import io.confluent.kafka.serializers.KafkaAvroDeserializer;
import io.confluent.kafka.serializers.KafkaAvroSerializer;
import io.confluent.kafka.serializers.KafkaAvroSerializerConfig;
import org.apache.avro.generic.GenericData;
import org.apache.avro.generic.GenericRecord;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.apache.kafka.common.serialization.StringSerializer;
import org.apache.kafka.streams.TestInputTopic;
import org.apache.kafka.streams.TestOutputTopic;
import org.apache.kafka.streams.TopologyTestDriver;
import org.apache.kafka.streams.state.KeyValueIterator;
import org.apache.kafka.streams.state.KeyValueStore;
import org.apache.kafka.streams.state.SessionStore;
import org.hamcrest.MatcherAssert;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import ru.netology.dsw.TestUtils;

import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class ProductHighSalesAlertAppTest {

    private TopologyTestDriver topologyDriver;

    private TestInputTopic<String, Object> purchasesTopic;

    private TestInputTopic<String, Object> productsTopic;

    private TestOutputTopic<String, Object> resultTopic;

    private TestOutputTopic<String, Object> dlqTopic;

    @BeforeEach
    public void setUp() {
        MockSchemaRegistryClient schemaClient = new MockSchemaRegistryClient();
        schemaClient.parseSchema(AvroSchema.TYPE, TestUtils.createProductSchema().toString(), List.of());
        schemaClient.parseSchema(AvroSchema.TYPE, TestUtils.createPurchaseSchema().toString(), List.of());

        Map<String, String> serdeProps = Map.of(
                KafkaAvroSerializerConfig.AUTO_REGISTER_SCHEMAS, "true",
                KafkaAvroSerializerConfig.SCHEMA_REGISTRY_URL_CONFIG, "http://localhost:8090"
        );

        topologyDriver = new TopologyTestDriver(ProductHighSalesAlertApp.buildTopology(schemaClient, serdeProps), ProductHighSalesAlertApp.getKStreamsConfig());

        StringSerializer keySer = new StringSerializer();
        KafkaAvroSerializer valSer = new KafkaAvroSerializer(schemaClient, serdeProps);
        purchasesTopic = topologyDriver.createInputTopic(ProductHighSalesAlertApp.PURCHASE_TOPIC_NAME, keySer, valSer);
        productsTopic = topologyDriver.createInputTopic(ProductHighSalesAlertApp.PRODUCT_TOPIC_NAME, keySer, valSer);

        StringDeserializer keyDes = new StringDeserializer();
        KafkaAvroDeserializer valDes = new KafkaAvroDeserializer(schemaClient, serdeProps);
        resultTopic = topologyDriver.createOutputTopic(ProductHighSalesAlertApp.PRODUCT_HIGH_SALES_ALERT_TOPIC_NAME, keyDes, valDes);
        dlqTopic = topologyDriver.createOutputTopic(ProductHighSalesAlertApp.DLQ_TOPIC_NAME, keyDes, valDes);
    }

    @AfterEach
    public void tearDown() {
        topologyDriver.close();
    }

    @Test
    public void shouldCatchOneBigPurchase() {
        Instant enoughTimeAgo = Instant.now().minusMillis(ProductHighSalesAlertApp.CHECK_PERIOD.multipliedBy(2).toMillis());

        GenericRecord trgProduct = TestUtils.createProduct(1L, "Mercury", "The closes planet to the sun.", ProductHighSalesAlertApp.REVENUE_THRESHOLD + 1d);
        productsTopic.pipeInput("1", trgProduct, enoughTimeAgo);

        GenericRecord noiseProduct = TestUtils.createProduct(2L, "grain", "Grains of sand.", 1e-6);
        productsTopic.pipeInput("2", noiseProduct, enoughTimeAgo);

        // noise
        purchasesTopic.pipeInput("noise1", TestUtils.createPurchase(-1L, 1L, 2L), enoughTimeAgo.plusSeconds(1));
        purchasesTopic.pipeInput("noise2", TestUtils.createPurchase(-2L, 100L, 2L), enoughTimeAgo.plusSeconds(2));
        // target
        purchasesTopic.pipeInput("trg3", TestUtils.createPurchase(3L, 1L, 1L), enoughTimeAgo.plusSeconds(3));
        // noise
        purchasesTopic.pipeInput("noise4", TestUtils.createPurchase(-4L, 100L, 2L), enoughTimeAgo.plusSeconds(4));
        purchasesTopic.pipeInput("noise5", TestUtils.createPurchase(-5L, 1000L, 2L), enoughTimeAgo.plusSeconds(4));

        assertTrue(dlqTopic.isEmpty());
        assertFalse(resultTopic.isEmpty());
    }

    @Test
    public void shouldCatchManySmallPurchase() {
        Instant enoughTimeAgo = Instant.now().minusMillis(ProductHighSalesAlertApp.CHECK_PERIOD.multipliedBy(2).toMillis());

        double trgPrice = ProductHighSalesAlertApp.REVENUE_THRESHOLD / 1000d;
        GenericRecord trgProduct = TestUtils.createProduct(1L, "candy", "A nice chocolate candy bar.", trgPrice);
        productsTopic.pipeInput("1", trgProduct, enoughTimeAgo);

        GenericRecord noiseProduct = TestUtils.createProduct(2L, "grain", "Grains of sand.", 1e-6);
        productsTopic.pipeInput("2", noiseProduct, enoughTimeAgo);

        // noise
        purchasesTopic.pipeInput("noise1", TestUtils.createPurchase(-1L, 1L, 2L), enoughTimeAgo.plusSeconds(1));
        purchasesTopic.pipeInput("noise2", TestUtils.createPurchase(-2L, 100L, 2L), enoughTimeAgo.plusSeconds(2));
        // target
        for (long cnt = 0L; ((double) cnt) * trgPrice <= ProductHighSalesAlertApp.REVENUE_THRESHOLD + Double.MIN_VALUE; cnt++) {
            purchasesTopic.pipeInput(
                    Long.toString(cnt),
                    TestUtils.createPurchase(cnt, 1L, 1L),
                    enoughTimeAgo.plusMillis(cnt % ProductHighSalesAlertApp.CHECK_PERIOD.toMillis()));
        }
        // noise
        purchasesTopic.pipeInput("noise4", TestUtils.createPurchase(-4L, 100L, 2L), enoughTimeAgo.plusSeconds(4));
        purchasesTopic.pipeInput("noise5", TestUtils.createPurchase(-5L, 1000L, 2L), enoughTimeAgo.plusSeconds(4));

        assertTrue(dlqTopic.isEmpty());
        assertFalse(resultTopic.isEmpty());
    }
}
