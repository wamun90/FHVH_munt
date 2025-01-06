WITH CTE AS (
SELECT 
    CASE 
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 0 AND 5 THEN 'Late Night'
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 18 AND 23 THEN 'Evening'
    END AS time_of_day,
    AVG(trip_time / 60.0) AS avg_duration_minutes, -- Converts trip_time from seconds to minutes
    AVG(trip_miles) AS avg_distance_miles
FROM dbo.base_trip_data
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 0 AND 5 THEN 'Late Night'
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 18 AND 23 THEN 'Evening'
    END)

SELECT * FROM cte;

