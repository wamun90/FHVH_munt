
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."temporal_data__dbt_tmp__dbt_tmp_vw" as with cte as (
SELECT 
    FHV_Trip_ID,  
    CONVERT(DATE, request_datetime) AS request_date,
    DATEPART(HOUR, request_datetime) AS request_hour,
    CONVERT(DATE, pickup_datetime) AS pickup_date,
    DATEPART(HOUR, pickup_datetime) AS pickup_hour,
    CONVERT(DATE, dropoff_datetime) AS dropoff_date,
    DATEPART(HOUR, dropoff_datetime) AS dropoff_hour
FROM dbo.base_trip_data)

select * from cte;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."temporal_data__dbt_tmp" FROM "dbt_project"."dbo"."temporal_data__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.temporal_data__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_temporal_data__dbt_tmp_cci'
        AND object_id=object_id('dbo_temporal_data__dbt_tmp')
    )
    DROP index "dbo"."temporal_data__dbt_tmp".dbo_temporal_data__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_temporal_data__dbt_tmp_cci
    ON "dbo"."temporal_data__dbt_tmp"

   


  