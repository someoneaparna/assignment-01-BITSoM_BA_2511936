## ETL Decisions

### Decision 1 — Standardized mixed date formats
Problem: `retail_transactions.csv` stores dates in multiple formats, including `YYYY-MM-DD`, `DD/MM/YYYY`, and `DD-MM-YYYY`, which would break consistent time-based aggregation.
Resolution: I converted every transaction date into ISO format (`YYYY-MM-DD`) before loading and then generated a surrogate `date_key` in `YYYYMMDD` form for the warehouse.

### Decision 2 — Normalized category labels
Problem: The raw `category` column mixes values such as `Electronics`, `electronics`, `Grocery`, and `Groceries`, so the same business category would fragment across reports.
Resolution: I mapped category values to a single canonical vocabulary: `Electronics`, `Groceries`, and `Clothing`. This ensures clean groupings in analytical queries.

### Decision 3 — Repaired missing store cities
Problem: Some rows have `NULL` in `store_city` even though the city is implied by the `store_name` (for example, `Mumbai Central` clearly belongs to Mumbai).
Resolution: I filled missing cities by applying a deterministic lookup from `store_name` to the correct city before loading dimension data, so `dim_store` stays complete and reporting joins do not lose facts.
