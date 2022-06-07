package ru.netology.dsw;

import org.apache.avro.Schema;
import org.apache.avro.SchemaBuilder;
import org.apache.avro.generic.GenericData;
import org.apache.avro.generic.GenericRecord;

public class TestUtils {
    public static Schema createPurchaseSchema() {
        return SchemaBuilder.record("Purchase").fields()
                .requiredLong("id")
                .requiredLong("quantity")
                .requiredLong("productid")
                .endRecord();
    }

    public static Schema createProductSchema() {
        return SchemaBuilder.record("Product").fields()
                .requiredLong("id")
                .requiredString("name")
                .requiredString("description")
                .requiredDouble("price")
                .endRecord();
    }

    private static final Schema purchaseOriginalSchema = TestUtils.createPurchaseSchema();

    public static GenericRecord createPurchase(long id, long quantity, long productid) {
        GenericRecord purchase = new GenericData.Record(purchaseOriginalSchema);
        purchase.put("id", id);
        purchase.put("quantity", quantity);
        purchase.put("productid", productid);
        return purchase;
    }

    private static final Schema productOriginalSchema = TestUtils.createProductSchema();

    public static GenericRecord createProduct(long id, String name, String description, double price) {
        GenericRecord product = new GenericData.Record(productOriginalSchema);
        product.put("id", id);
        product.put("name", name);
        product.put("description", description);
        product.put("price", price);
        return product;
    }
}
