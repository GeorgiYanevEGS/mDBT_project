with source as (
    select * from {{ source('source', 'card') }}
),

renamed as (
    select
        card_id,
        account_id AS acc_id,
        card_no AS card_number,
        card_type,
        expiry_date,
        status,
        current_timestamp as dbt_loaded_at
    from source
)

select * from renamed