with stg_account as (
    select * from {{ ref('stg_account') }}
)

select
    acc_id,
    acc_number,
    customer_name,
    account_type,
    opened_date,
    status,
    dbt_loaded_at
from stg_account
where status = 'ACTIVE'   -- само активни сметки за анализа