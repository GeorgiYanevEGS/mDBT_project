{{
    config(
        materialized='incremental',
        unique_key='transaction_id'
    )
}}

with stg_transaction as (
    select * from {{ ref('stg_transaction') }}
),
stg_card as (
    select * from {{ ref('stg_card') }}
)
,
stg_account as (
    select * from {{ ref('stg_account') }}
)
select
    t.transaction_id,
    t.card_id,
    c.acc_id,
    a.acc_number,
    c.card_number,
    t.amount,
    t.currency,
    t.txn_date,
    t.txn_type,
    t.merchant,
    t.status,
    case 
        when t.amount < 0 then 'REFUND'
        else 'STANDARD'
    end as transaction_category
from stg_transaction t
left join stg_card c on t.card_id = c.card_id
left join stg_account a on c.acc_id = a.acc_id

{% if is_incremental() %}
    -- само новите транзакции (с по-късна дата от последната в таблицата)
    where t.txn_date > (select max(txn_date) from {{ this }})
{% endif %}