# Banking Data Model — dbt + PostgreSQL

A dbt Core project demonstrating dimensional modeling and incremental
transformation patterns for banking data on PostgreSQL, orchestrated via
Apache Airflow DAGs (`dbt run` / `dbt test`).

## Data Model

- **account** — customer accounts
- **card** — payment cards linked to accounts
- **transaction** — card transactions

## Architecture

- **Staging** — data cleaning and standardization (views)
- **Marts** — Kimball-style dimensional models:
  - `dim_account` — active customer accounts
  - `fct_transactions` — transaction fact table, joined across
    accounts and cards, with derived transaction categorization

## Notable Implementation Details

- **Incremental loading**: `fct_transactions` uses dbt's `incremental`
  materialization with `unique_key='transaction_id'`. On subsequent runs,
  only transactions newer than the current max `txn_date` are processed —
  avoiding a full table rebuild on every run.
- **Derived business logic**: transactions are automatically categorized
  as `REFUND` (negative amount) or `STANDARD` directly in the model.
- **Dimensional joins**: the fact table joins staging models for
  transactions, cards, and accounts to produce an analytics-ready,
  denormalized view.

## Tech Stack

- dbt Core 1.11
- PostgreSQL
- Apache Airflow 2.9 (orchestrates `dbt run` / `dbt test` via DAGs)
- Python 3.11

## Related Project

For the GCP/BigQuery variant of this pipeline — including Cloud Storage
staging, partitioning/clustering, and 27 automated data quality tests —
see [banking_bq](https://github.com/GeorgiYanevEGS/banking_bq).
