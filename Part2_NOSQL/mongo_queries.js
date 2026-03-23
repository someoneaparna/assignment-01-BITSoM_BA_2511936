const fs = require("fs");

const sampleProducts = JSON.parse(
  fs.readFileSync("./sample_documents.json", "utf8")
);

const products = db.getCollection("products");

// OP1: insertMany() — insert all 3 documents from sample_documents.json
products.insertMany(sampleProducts);

// OP2: find() — retrieve all Electronics products with price > 20000
products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
products.find({
  category: "Groceries",
  expiry_date: { $lt: "2025-01-01" }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
products.updateOne(
  { _id: "ELEC1001" },
  { $set: { discount_percent: 12 } }
);

// OP5: createIndex() — create an index on category field and explain why
products.createIndex({ category: 1 });
// This index improves category-based filtering because MongoDB can avoid a full collection scan
// for queries such as Electronics-only or Groceries-only product lookups.
