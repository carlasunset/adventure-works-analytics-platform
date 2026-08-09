with products as (

    select * from {{ ref('stg_production__products') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
        product_id,
        product_name
    from products

)

select *
from final