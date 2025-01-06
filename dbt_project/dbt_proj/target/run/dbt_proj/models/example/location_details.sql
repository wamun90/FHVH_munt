
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."location_details__dbt_tmp__dbt_tmp_vw" as WITH LocationDetails AS (
    SELECT 
    FHV_Trip_ID,  
    PULocationID AS pickup_location_id,
    DOLocationID AS dropoff_location_id
FROM dbo.base_trip_data
)
-- Select distinct location details
SELECT *
FROM LocationDetails;;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."location_details__dbt_tmp" FROM "dbt_project"."dbo"."location_details__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.location_details__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_location_details__dbt_tmp_cci'
        AND object_id=object_id('dbo_location_details__dbt_tmp')
    )
    DROP index "dbo"."location_details__dbt_tmp".dbo_location_details__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_location_details__dbt_tmp_cci
    ON "dbo"."location_details__dbt_tmp"

   


  