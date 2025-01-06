use dbt_project

CREATE TABLE FHV_Trip_Records (
    hvfhs_license_num NVARCHAR(50), -- Assuming a string value
    dispatching_base_num NVARCHAR(50), -- Assuming a string value
    originating_base_num NVARCHAR(50), -- Assuming a string value
    request_datetime DATETIME, -- Assuming datetime format
    on_scene_datetime DATETIME, -- Assuming datetime format
    pickup_datetime DATETIME, -- Assuming datetime format
    dropoff_datetime DATETIME, -- Assuming datetime format
    PULocationID FLOAT, -- Assuming a floating-point number
    DOLocationID FLOAT, -- Assuming a floating-point number
    trip_miles FLOAT, -- Assuming a floating-point number
    trip_time FLOAT, -- Assuming a floating-point number
    base_passenger_fare FLOAT, -- Assuming a floating-point number
    tolls FLOAT, -- Assuming a floating-point number
    bcf FLOAT, -- Assuming a floating-point number
    sales_tax FLOAT, -- Assuming a floating-point number
    congestion_surcharge FLOAT, -- Assuming a floating-point number
    airport_fee FLOAT, -- Assuming a floating-point number
    tips FLOAT, -- Assuming a floating-point number
    driver_pay FLOAT, -- Assuming a floating-point number
    shared_request_flag NVARCHAR(1), -- Assuming a single character string (Y/N)
    shared_match_flag NVARCHAR(1), -- Assuming a single character string (Y/N)
    access_a_ride_flag NVARCHAR(1), -- Assuming a single character string (Y/N)
    wav_request_flag NVARCHAR(1), -- Assuming a single character string (Y/N)
    wav_match_flag NVARCHAR(1) -- Assuming a single character string (Y/N)
);

CREATE INDEX idx_pickup_datetime ON FHV_Trip_Records (pickup_datetime);

