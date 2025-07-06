with stg_hotel_bookings as (
    select * 
    from {{ ref("stg_pactravel__hotel_bookings") }}
),

stg_flight_departure as (
    select * from (
    select *, RANK() OVER (PARTITION BY trip_id ORDER BY departure_date) as ranking 
    from {{ ref("stg_pactravel__flight_bookings") }})a
    where ranking=1
),

stg_flight_return as (
    select * from (
    select *, RANK() OVER (PARTITION BY trip_id ORDER BY departure_date) as ranking 
    from {{ ref("stg_pactravel__flight_bookings") }})a
    where ranking>1
)

select 
    {{ dbt_utils.generate_surrogate_key ( ["fd.trip_id"] ) }} as sk_trip_id,
    fd.trip_id as nk_trip_id,
    fd.customer_id,
    fd.flight_number as flight_number_departure,
    fd.airline_id as departure_airline_id,
    fd.aircraft_id as departure_aircraft_id,
    fd.airport_src as departure_origin_airport_id,
    fd.airport_dst as departure_destination_airport_id,
    fr.departure_date as return_date,
    fr.flight_number as flight_number_return,
    fr.airline_id as return_airline_id,
    fr.aircraft_id as return_aircraft_id,
    fr.airport_src as return_origin_airport_id,
    fr.airport_dst as return_destination_airport_id,
    fr.departure_date as return_date,
    hb.hotel_id,
    hb.check_in_date,
    hb.check_out_date,
    fd.price+fr.price+hb.price as total_price,
    {{ dbt_date.now() }} as created_at,
    {{ dbt_date.now() }} as updated_at
from stg_flight_departure fd
left join stg_flight_return fr
    on fd.trip_id=fr.trip_id
left join stg_hotel_bookings hb
    on hb.trip_id=fd.trip_id