with source as (
    select * from {{ source('source', 'transaction') }}
),

renamed as (
    select
        transaction_id,
        card_id,
        amount,
        currency,
        txn_date,
        txn_type,
        merchant,
        status,
        current_timestamp as dbt_loaded_at
    from source
)

select * from renamed