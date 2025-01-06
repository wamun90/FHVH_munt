With cte as (SELECT 
    FHV_Trip_ID
    hvfhs_license_num,
    dispatching_base_num,
    originating_base_num,
    trip_miles,
    trip_time,
    base_passenger_fare,
    tolls,
    bcf,
    sales_tax,
    congestion_surcharge,
    airport_fee,
    tips,
    driver_pay
FROM dbo.base_trip_data)

select * from cte