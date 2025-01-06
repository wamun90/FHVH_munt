With cte as (SELECT
    ROW_NUMBER() OVER (ORDER BY pickup_datetime) AS trip_id, 
    hvfhs_license_num,
    dispatching_base_num,
    originating_base_num,
    pickup_datetime,
    dropoff_datetime,
    trip_miles,
    trip_time,
    base_passenger_fare,
    tolls,
    congestion_surcharge,
    tips
FROM base_trip_data)

select * from cte