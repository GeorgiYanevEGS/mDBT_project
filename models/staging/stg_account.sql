with source as (
    select * from {{ source('source', 'account') }}
),

renamed as (
    select
        account_id AS acc_id ,
        account_no AS acc_number,
        customer_name,
        account_type,
        opened_date,
        status,
        -- добавяме audit колона
        current_timestamp as dbt_loaded_at
    from source
)

select * from renamed