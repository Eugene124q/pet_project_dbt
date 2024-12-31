






with recency as (

    select 

      
      
        max(dt) as most_recent

    from "yandex_music_pet_project"."public"."albums_metrics"

    

)

select

    
    most_recent,
    cast(

    now() + ((interval '1 day') * (-1))

 as timestamp) as threshold

from recency
where most_recent < cast(

    now() + ((interval '1 day') * (-1))

 as timestamp)

