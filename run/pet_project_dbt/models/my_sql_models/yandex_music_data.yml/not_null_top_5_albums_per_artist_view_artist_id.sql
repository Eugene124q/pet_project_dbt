select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select artist_id
from "yandex_music_pet_project"."yandex_music_dbt"."top_5_albums_per_artist_view"
where artist_id is null



      
    ) dbt_internal_test