
  
    USE [dbt_project];
    USE [dbt_project];
    
    

    

    
    USE [dbt_project];
    EXEC('
        create view "dbo"."my_first_dbt_model__dbt_tmp__dbt_tmp_vw" as /*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_data as (

    select 1 as id
    union all
    select null as id

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null;
    ')

EXEC('
            SELECT * INTO "dbt_project"."dbo"."my_first_dbt_model__dbt_tmp" FROM "dbt_project"."dbo"."my_first_dbt_model__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbo.my_first_dbt_model__dbt_tmp__dbt_tmp_vw')



    
    use [dbt_project];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbo_my_first_dbt_model__dbt_tmp_cci'
        AND object_id=object_id('dbo_my_first_dbt_model__dbt_tmp')
    )
    DROP index "dbo"."my_first_dbt_model__dbt_tmp".dbo_my_first_dbt_model__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbo_my_first_dbt_model__dbt_tmp_cci
    ON "dbo"."my_first_dbt_model__dbt_tmp"

   


  