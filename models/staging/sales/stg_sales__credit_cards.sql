with source as (
    
    select * 
    from {{ source('adventure_works', 'sales_creditcard') }}

),

renamed as (

    select
        creditcardid as credit_card_id,
        cardtype as card_type,
        expmonth as expiration_month,
        expyear as expiration_year,
        cast(date_format(modifieddate, "yyyy-MM-dd") as date) as modified_at
    from source

)

select *
from renamed