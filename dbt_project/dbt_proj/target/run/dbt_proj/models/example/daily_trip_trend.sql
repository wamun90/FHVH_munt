
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."daily_trip_trend__dbt_tmp__dbt_tmp_vw" as WITH CTE AS (
SELECT
    FORMAT(pickup_datetime, ''yyyy-MM-dd'') AS trip_month,
    COUNT(FHV_Trip_ID) AS total_trips
FROM dbo.base_trip_data
GROUP BY  FORMAT(pickup_datetime, ''yyyy-MM-dd''))

SELECT * FROM CTE;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."daily_trip_trend__dbt_tmp" FROM "dbt_project"."dbo"."daily_trip_trend__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.daily_trip_trend__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_daily_trip_trend__dbt_tmp_cci'
        AND object_id=object_id('dbo_daily_trip_trend__dbt_tmp')
    )
    DROP index "dbo"."daily_trip_trend__dbt_tmp".dbo_daily_trip_trend__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_daily_trip_trend__dbt_tmp_cci
    ON "dbo"."daily_trip_trend__dbt_tmp"

   


  