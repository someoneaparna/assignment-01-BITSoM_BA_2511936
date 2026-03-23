## Anomaly Analysis

### Insert Anomaly
Because the flat file stores product, customer, order, and sales representative data in the same row, a new product cannot be inserted unless an order also exists. For example, row 13 is the only row carrying `product_id = P008`, `product_name = Webcam`, `category = Electronics`, and `unit_price = 2100`. If the business wants to add a new product such as `P009`, there is no place to store only product attributes. The row design forces values for unrelated columns such as `order_id`, `customer_id`, `sales_rep_id`, and `order_date`, even when no order has been placed yet.

### Update Anomaly
The same sales representative data is repeated across many rows, so a single real-world change has to be updated in multiple places. `sales_rep_id = SR01` appears with two different `office_address` values: row 3 has `Mumbai HQ, Nariman Point, Mumbai - 400021`, while row 39 has `Mumbai HQ, Nariman Pt, Mumbai - 400021`. The representative is the same person (`Deepak Joshi`), but the duplicated address text has drifted. This is a classic update anomaly caused by redundant descriptive attributes.

### Delete Anomaly
Deleting one operational row can remove master data that should still exist. Row 13 is the only row for product `P008` (`Webcam`). If order `ORD1185` were deleted because it was entered by mistake or archived, the company would also lose the only stored record of the webcam product itself, including its category and unit price. That means the flat file mixes transaction history with product master data in a way that creates delete anomalies.

## Normalization Justification

Keeping everything in one table looks simpler only at first glance. In this dataset, the flat structure repeats customer details, product details, and sales representative details in every order line, which increases both storage duplication and the chance of inconsistent data. The clearest example is `sales_rep_id = SR01`: most rows use `Mumbai HQ, Nariman Point, Mumbai - 400021`, but some rows use `Mumbai HQ, Nariman Pt, Mumbai - 400021`. That inconsistency exists only because the representative attributes are copied repeatedly instead of being maintained once in a dedicated table.

The same issue appears with product data. Product `P001` (Laptop) appears in many rows with the same category and unit price. If the laptop price changes, updating a single row would make the dataset internally inconsistent unless every related row is also updated. Likewise, deleting row 13 would remove the only record for product `P008` (Webcam), even though product information should survive the deletion of an order line.

Normalization to 3NF solves these problems by separating entities into `customers`, `products`, `sales_representatives`, `orders`, and `order_items`. Each fact is stored once, and transactional rows hold foreign keys instead of repeated descriptive text. This reduces anomalies, improves data quality, and makes future changes safer. For reporting, normalized tables can still be joined when needed, but the underlying data becomes far easier to govern and trust.
