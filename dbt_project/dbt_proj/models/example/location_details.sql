WITH LocationDetails AS (
    SELECT 
    FHV_Trip_ID,  
    PULocationID AS pickup_location_id,
    DOLocationID AS dropoff_location_id
FROM dbo.base_trip_data
)
-- Select distinct location details
SELECT *
FROM LocationDetails;
