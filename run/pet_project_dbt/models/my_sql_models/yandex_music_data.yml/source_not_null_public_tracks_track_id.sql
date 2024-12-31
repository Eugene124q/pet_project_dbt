select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select track_id
from "yandex_music_pet_project"."public"."tracks"
where track_id is null



      
    ) dbt_internal_test