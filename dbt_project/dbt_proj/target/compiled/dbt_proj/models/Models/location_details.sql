WITH LocationDetails AS (
    -- Combine Pickup and Dropoff locations
    SELECT 
        PULocationID AS location_id,
        'Pickup' AS location_type
    FROM base_trip_data  -- Replace 'raw_data' with your table name

    UNION

    SELECT 
        DOLocationID AS location_id,
        'Dropoff' AS location_type
    FROM base_trip_data
)
-- Select distinct location details
SELECT DISTINCT 
    location_id, 
    location_type
FROM LocationDetails;