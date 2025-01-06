
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."avg_duration_distance__dbt_tmp__dbt_tmp_vw" as WITH CTE AS (
SELECT 
    CASE 
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 0 AND 5 THEN ''Late Night''
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 6 AND 11 THEN ''Morning''
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 12 AND 17 THEN ''Afternoon''
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 18 AND 23 THEN ''Evening''
    END AS time_of_day,
    AVG(trip_time / 60.0) AS avg_duration_minutes, -- Converts trip_time from seconds to minutes
    AVG(trip_miles) AS avg_distance_miles
FROM dbo.base_trip_data
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 0 AND 5 THEN ''Late Night''
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 6 AND 11 THEN ''Morning''
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 12 AND 17 THEN ''Afternoon''
        WHEN DATEPART(HOUR, pickup_datetime) BETWEEN 18 AND 23 THEN ''Evening''
    END)

SELECT * FROM cte;;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."avg_duration_distance__dbt_tmp" FROM "dbt_project"."dbo"."avg_duration_distance__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.avg_duration_distance__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_avg_duration_distance__dbt_tmp_cci'
        AND object_id=object_id('dbo_avg_duration_distance__dbt_tmp')
    )
    DROP index "dbo"."avg_duration_distance__dbt_tmp".dbo_avg_duration_distance__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_avg_duration_distance__dbt_tmp_cci
    ON "dbo"."avg_duration_distance__dbt_tmp"

   


  