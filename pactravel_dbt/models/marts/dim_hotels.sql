with stg_dim_hotels as (
    select
        hotel_id as nk_hotel_id,
        hotel_name,
        hotel_city,        
        hotel_country,
        hotel_score
    from {{ ref("stg_pacflight__hotels") }}
),

final_dim_hotels as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_hotel_id"] ) }} as sk_hotel_id,
        *,
        {{ dbt_date.now() }} as created_at,
        {{ dbt_date.now() }} as updated_at
    from stg_dim_hotels
)

select * from final_dim_hotels