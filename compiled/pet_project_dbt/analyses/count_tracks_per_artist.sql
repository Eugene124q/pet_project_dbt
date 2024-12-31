WITH all_of_need AS (
         SELECT t.artist_id,
            a.name,
            t.track_id,
            t.title
           FROM "yandex_music_pet_project"."public"."tracks" as t
             LEFT JOIN "yandex_music_pet_project"."public"."artists" as a USING (artist_id)
        )
 SELECT all_of_need.artist_id,
    all_of_need.name,
    count(DISTINCT all_of_need.track_id) AS count
   FROM all_of_need
  GROUP BY all_of_need.artist_id, all_of_need.name
  ORDER BY (count(DISTINCT all_of_need.track_id)) DESC