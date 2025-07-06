with stg_daily_flight as (
    select * 
    from {{ ref("stg_pactravel__flight_bookings") }}
),

final_daily_flight as(
    select 
        departure_date as date_id,
        airline_id,
        aircraft_id,
        airport_dst,
        airport_src,
        count(distinct customer_id)
    from stg_daily_flight
    group by 1,2,3,4,5)

select     
    *,
    {{ dbt_date.now() }} as created_at,
    {{ dbt_date.now() }} as updated_at
from final_daily_flight