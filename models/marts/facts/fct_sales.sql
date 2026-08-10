with sales_items as (

    select *
    from {{ ref('int_sales__order_items_enriched') }}

),

products as (

    select
        product_key,
        product_id
    from {{ ref('dim_product') }}

),

customers as (

    select
        customer_key,
        customer_id
    from {{ ref('dim_customer') }}

),

dates as (

    select
        date_key,
        date
    from {{ ref('dim_date') }}

),

addresses as (

    select
        address_key,
        address_id
    from {{ ref('dim_address') }}

),

credit_cards as (

    select
        credit_card_key,
        credit_card_id
    from {{ ref('dim_credit_card') }}

),

sales_with_dimension_keys as (

    select
        {{ dbt_utils.generate_surrogate_key([
            'sales.sales_order_detail_id'
        ]) }} as sales_order_item_key,

        sales.sales_order_detail_id,
        sales.sales_order_id,

        products.product_key,
        customers.customer_key,
        dates.date_key,
        credit_cards.credit_card_key,
        addresses.address_key,

        sales.status,

        sales.order_quantity,
        sales.unit_price,
        sales.unit_price_discount,
        sales.gross_amount,
        sales.discount_amount,
        sales.net_amount

    from sales_items as sales

    left join products
        on sales.product_id = products.product_id

    left join customers
        on sales.customer_id = customers.customer_id

    left join dates
        on sales.order_date = dates.date

    left join addresses
        on sales.ship_to_address_id = addresses.address_id

    left join credit_cards
        on sales.credit_card_id <=> credit_cards.credit_card_id

)

select *
from sales_with_dimension_keys