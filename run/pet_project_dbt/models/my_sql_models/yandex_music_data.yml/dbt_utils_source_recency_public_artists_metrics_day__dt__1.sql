select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      






with recency as (

    select 

      
      
        max(dt) as most_recent

    from "yandex_music_pet_project"."public"."artists_metrics"

    

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


      
    ) dbt_internal_test