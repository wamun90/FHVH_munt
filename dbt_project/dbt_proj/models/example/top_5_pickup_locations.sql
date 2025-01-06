WITH CTE AS (
SELECT TOP 5
    PULocationID AS pickup_location_id,
    COUNT(FHV_Trip_ID) AS total_trips
FROM dbo.base_trip_data
GROUP BY PULocationID
ORDER BY total_trips DESC)

SELECT * FROM CTE