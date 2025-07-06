with stg_daily_flight as (
    select * 
    from {{ ref("stg_pactravel__hotel_bookings") }}
),

final_daily_hotel as(
    select 
        check_in_date as date_id,
        hotel_id,
        count(distinct customer_id)
    from stg_daily_flight
    group by 1,2)

select     
    *,
    {{ dbt_date.now() }} as created_at,
    {{ dbt_date.now() }} as updated_at
from final_daily_hotel