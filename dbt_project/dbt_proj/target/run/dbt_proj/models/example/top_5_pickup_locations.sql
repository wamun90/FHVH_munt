
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."top_5_pickup_locations__dbt_tmp__dbt_tmp_vw" as WITH CTE AS (
SELECT TOP 5
    PULocationID AS pickup_location_id,
    COUNT(FHV_Trip_ID) AS total_trips
FROM dbo.base_trip_data
GROUP BY PULocationID
ORDER BY total_trips DESC)

SELECT * FROM CTE;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."top_5_pickup_locations__dbt_tmp" FROM "dbt_project"."dbo"."top_5_pickup_locations__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.top_5_pickup_locations__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_top_5_pickup_locations__dbt_tmp_cci'
        AND object_id=object_id('dbo_top_5_pickup_locations__dbt_tmp')
    )
    DROP index "dbo"."top_5_pickup_locations__dbt_tmp".dbo_top_5_pickup_locations__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_top_5_pickup_locations__dbt_tmp_cci
    ON "dbo"."top_5_pickup_locations__dbt_tmp"

   


  