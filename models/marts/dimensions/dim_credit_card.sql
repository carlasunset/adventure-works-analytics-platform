with credit_cards as (

    select
        credit_card_id,
        card_type

    from {{ ref('stg_sales__credit_cards') }}

),

credit_cards_with_keys as (

    select
        {{ dbt_utils.generate_surrogate_key(['credit_card_id']) }} as credit_card_key,
        credit_card_id,
        card_type

    from credit_cards

),

no_credit_card as (

    select
        {{ dbt_utils.generate_surrogate_key(["'__NO_CREDIT_CARD__'"]) }} as credit_card_key,
        cast(null as bigint) as credit_card_id,
        'No Credit Card' as card_type

),

final as (

    select * from credit_cards_with_keys

    union all

    select * from no_credit_card

)

select *
from final