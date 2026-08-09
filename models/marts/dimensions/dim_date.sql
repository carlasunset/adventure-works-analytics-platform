with date_spine as (

    select explode(
        sequence(
            cast('2011-01-01' as date),
            cast('2014-12-31' as date),
            interval 1 day
        )
    ) as date

),

final as (

    select
        cast(date_format(date, 'yyyyMMdd') as int) as date_key,
        date,
        year(date) as year,
        quarter(date) as quarter,
        month(date) as month_number,
        date_format(date, 'MMMM') as month_name,
        date_format(date, 'yyyy-MM') as year_month,
        day(date) as day_of_month

    from date_spine

)

select *
from final