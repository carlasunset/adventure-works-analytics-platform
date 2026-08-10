with sales_order_items as (

    select *
    from {{ ref('stg_sales__sales_order_items') }}

),

sales_orders as (

    select *
    from {{ ref('stg_sales__sales_orders') }}

),

typed_order_items as (

    select
        *,
        cast(unit_price as decimal(18,4)) as unit_price_decimal,
        cast(unit_price_discount as decimal(8,4)) as unit_price_discount_decimal
    from sales_order_items

),

order_items_enriched as (

    select
        items.sales_order_detail_id,
        items.sales_order_id,
        items.product_id,

        orders.order_date,
        orders.status,
        orders.customer_id,
        orders.territory_id,
        orders.bill_to_address_id,
        orders.ship_to_address_id,
        orders.credit_card_id,

        items.order_quantity,
        items.unit_price_decimal as unit_price,
        items.unit_price_discount_decimal as unit_price_discount,

        cast(items.order_quantity * items.unit_price_decimal as decimal(18,4)) as gross_amount,

        cast(items.order_quantity * items.unit_price_decimal * items.unit_price_discount_decimal as decimal(18,4)) as discount_amount,

        cast(items.order_quantity * items.unit_price_decimal * (1 - items.unit_price_discount_decimal) as decimal(18,4)) as net_amount,

        orders.subtotal,
        orders.tax_amount,
        orders.freight_amount,
        orders.total_due,

        items.item_modified_at,
        orders.order_modified_at

    from typed_order_items as items

    left join sales_orders as orders
        on items.sales_order_id = orders.sales_order_id

)

select *
from order_items_enriched