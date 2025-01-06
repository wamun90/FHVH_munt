with cte as (
SELECT 
	CAST(request_datetime AS DATE) AS request_date,
    DATEPART(HOUR, request_datetime) AS request_hour,
    CAST(pickup_datetime AS DATE) AS pickup_date,
    DATEPART(HOUR, pickup_datetime) AS pickup_hour,
    CAST(dropoff_datetime AS DATE) AS dropoff_date,
    DATEPART(HOUR, dropoff_datetime) AS dropoff_hour
FROM base_trip_data)

select * from cte