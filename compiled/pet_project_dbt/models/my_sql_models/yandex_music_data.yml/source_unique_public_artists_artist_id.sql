
    
    

select
    artist_id as unique_field,
    count(*) as n_records

from "yandex_music_pet_project"."public"."artists"
where artist_id is not null
group by artist_id
having count(*) > 1


