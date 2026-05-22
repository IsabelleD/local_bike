# Local Bike — dbt Core Project

Analytics engineering project for **Local Bike**, a US bicycle retailer with stores in
Santa Cruz (CA), Baldwin (NY), and Rowlett (TX).

Built with dbt Core + BigQuery.

## Project structure

```
models/
├── staging/bike/       # Views — clean & rename raw source columns
├── intermediate/bike/  # Views — business logic, enriched dimensions
└── marts/              # Tables — final models consumed by BI tools
```

## Mart models

| Model | Description |
|---|---|
| `fct_sales` | Detailed sales fact table (one row per order line item) |
| `dim_products` | Product dimension with category, brand, and stock |
| `dim_stores` | Store dimension with staff headcount |
| `mrt_sales_daily_report` | Daily revenue aggregation per store |

## Key business metrics

- **Revenue** = `list_price × quantity × (1 − discount)`
- **Order statuses**: pending → processing → completed / rejected
- **Stores**: Santa Cruz CA · Baldwin NY · Rowlett TX

## Setup

1. Install dbt with BigQuery adapter: `pip install dbt-bigquery`
2. Authenticate: `gcloud auth application-default login`
3. Copy `profiles.yml` to `~/.dbt/profiles.yml` and update your GCP project ID
4. Run: `dbt deps && dbt build`

## BigQuery configuration

- **Project**: `session2-493405`
- **Source dataset**: `bike`
- **Output dataset (marts)**: `bike_marts`
- **Location**: EU

## Tests

- Uniqueness and not-null tests on all primary keys
- `accepted_values` on `order_status_label`
- `relationships` test: `fct_sales.store_id` → `dim_stores.store_id`
- Custom test: `test_positive_price` — ensures no zero or negative prices in order items
