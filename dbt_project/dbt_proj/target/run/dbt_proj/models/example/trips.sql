
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."trips__dbt_tmp__dbt_tmp_vw" as With cte as (SELECT 
    FHV_Trip_ID
    hvfhs_license_num,
    dispatching_base_num,
    originating_base_num,
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
FROM dbo.base_trip_data)

select * from cte;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."trips__dbt_tmp" FROM "dbt_project"."dbo"."trips__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.trips__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_trips__dbt_tmp_cci'
        AND object_id=object_id('dbo_trips__dbt_tmp')
    )
    DROP index "dbo"."trips__dbt_tmp".dbo_trips__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_trips__dbt_tmp_cci
    ON "dbo"."trips__dbt_tmp"

   


  