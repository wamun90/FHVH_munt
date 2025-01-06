
WITH CTE AS (
SELECT
    FORMAT(pickup_datetime, 'yyyy-MM-dd') AS trip_month,
    COUNT(FHV_Trip_ID) AS total_trips
FROM dbo.base_trip_data
GROUP BY  FORMAT(pickup_datetime, 'yyyy-MM-dd'))

SELECT * FROM CTE