with gross_sales_2011 as (

    select
        round(sum(gross_amount), 2) as actual_gross_sales
    from {{ ref('fct_sales') }}
    where date_key between 20110101 and 20111231

),

validation as (

    select *
    from gross_sales_2011
    where actual_gross_sales <> 12646112.16

)

select *
from validation