# Local Bike

Analytics engineering project for **Local Bike**, a US bicycle retailer with stores in Santa Cruz (CA), Baldwin (NY), and Rowlett (TX).

Built with dbt cloud + BigQuery.

## Project structure

```
macros/
models/
├── staging/bike/       # Views — clean & rename raw source columns
├── intermediate/bike/  # Views — business logic, enriched dimensions
└── marts/              # Tables — final models consumed by BI tools
tests/
```

## Mart models

mrt_sales_daily_report : Daily revenue aggregation per store 
mrt_dim_products : Products dimension with stock and price
mrt_detailled_sales : 1 line by item order with all detailled information

## Key business metrics

- **Revenue** = `list_price × quantity × (1 − discount)`
- **Order statuses**: pending → processing → completed or rejected
- **Stores**: Santa Cruz CA · Baldwin NY · Rowlett TX

## BigQuery configuration

- **Project**: `session2-493405`
- **Source dataset**: `bike`
- **Output dataset (marts)**: `prod_bike`
- **Location**: US

## Tests

- Uniqueness and not-null tests on all primary keys
- `accepted_values` on `order_status_label`
- Custom test: `revenue_is_positive` — ensures no zero or negative revenue for order
               `list_proce_is_positive` — ensures no zero or negative prices in order items
