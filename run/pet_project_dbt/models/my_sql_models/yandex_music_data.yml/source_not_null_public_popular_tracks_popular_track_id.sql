select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select popular_track_id
from "yandex_music_pet_project"."public"."popular_tracks"
where popular_track_id is null



      
    ) dbt_internal_test