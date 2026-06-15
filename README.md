Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

# Banking Data Model — dbt + PostgreSQL

A dbt project demonstrating ETL transformation patterns 
for banking data using PostgreSQL.

## Data Model
- **account** — Customer accounts
- **card** — Payment cards linked to accounts  
- **transaction** — Card transactions

## Layers
- **Staging** — Data cleaning and standardization
- **Marts** — Business logic and reporting layer

## Tech Stack
- dbt Core 1.11
- PostgreSQL
- Python 3.11
