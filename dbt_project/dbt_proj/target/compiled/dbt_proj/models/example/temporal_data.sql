with cte as (
SELECT 
    FHV_Trip_ID,  
    CONVERT(DATE, request_datetime) AS request_date,
    DATEPART(HOUR, request_datetime) AS request_hour,
    CONVERT(DATE, pickup_datetime) AS pickup_date,
    DATEPART(HOUR, pickup_datetime) AS pickup_hour,
    CONVERT(DATE, dropoff_datetime) AS dropoff_date,
    DATEPART(HOUR, dropoff_datetime) AS dropoff_hour
FROM dbo.base_trip_data)

select * from cte