with customers as (

    select * from {{ ref('stg_sales__customers') }}

),

people as (

    select
        business_entity_id,
        person_type,
        full_name
    from {{ ref('stg_person__people') }}

),

stores as (

    select
        business_entity_id,
        store_name
    from {{ ref('stg_sales__stores') }}

),

customers_enriched as (

    select
        c.customer_id,
        c.person_id,
        p.person_type,
        p.full_name,
        c.store_id,
        s.store_name,
        c.territory_id,
        c.modified_at
    from customers as c

    left join people as p
        on c.person_id = p.business_entity_id

    left join stores as s
        on c.store_id = s.business_entity_id

)

select *
from customers_enriched