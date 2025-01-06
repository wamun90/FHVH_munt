
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."base_trip_data__dbt_tmp__dbt_tmp_vw" as WITH cleaned_data AS (
SELECT
    newid() as FHV_Trip_ID,
    hvfhs_license_num,
    dispatching_base_num,
    originating_base_num,
    CONVERT(datetime, request_datetime) AS request_datetime,
    CONVERT(datetime, on_scene_datetime) AS on_scene_datetime,
    CONVERT(datetime, pickup_datetime) AS pickup_datetime,
    CONVERT(datetime, dropoff_datetime) AS dropoff_datetime,
    PULocationID,
    DOLocationID,
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
FROM [dbo].[FHV_Trip_Records]
WHERE 
    -- Exclude rows with missing or invalid trip data
    trip_miles IS NOT NULL AND trip_time IS NOT NULL
    AND base_passenger_fare IS NOT NULL
    -- Remove rows with zero values for key metrics
    AND trip_miles > 0 AND trip_time > 0
    -- Keep rows with valid PULocationID and DOLocationID
    AND PULocationID IS NOT NULL AND DOLocationID IS NOT NULL
)

SELECT * FROM cleaned_data;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."base_trip_data__dbt_tmp" FROM "dbt_project"."dbo"."base_trip_data__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.base_trip_data__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_base_trip_data__dbt_tmp_cci'
        AND object_id=object_id('dbo_base_trip_data__dbt_tmp')
    )
    DROP index "dbo"."base_trip_data__dbt_tmp".dbo_base_trip_data__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_base_trip_data__dbt_tmp_cci
    ON "dbo"."base_trip_data__dbt_tmp"

   


  