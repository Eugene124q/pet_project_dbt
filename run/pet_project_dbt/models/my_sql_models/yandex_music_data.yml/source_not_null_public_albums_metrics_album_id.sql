select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select album_id
from "yandex_music_pet_project"."public"."albums_metrics"
where album_id is null



      
    ) dbt_internal_test