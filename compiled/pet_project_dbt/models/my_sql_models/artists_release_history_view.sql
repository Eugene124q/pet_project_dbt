with generated_dates as 
 (
   SELECT generate_series((( SELECT min(release_date) AS min
                              FROM "yandex_music_pet_project"."yandex_music_dbt"."ratings_of_albums_view" as roav))::timestamp without time zone, CURRENT_DATE - '1 day'::interval, '1 day'::interval)::date AS date
 )
 select gd.date,
        CASE
            WHEN gd.date = roav.release_date THEN roav.release_date
            ELSE NULL::date
        END AS release_date,
        roav.artist_id,
        roav.name,
        roav.album_id,
        roav.title,
        roav.likes_count,
        roav.genres
   FROM generated_dates as gd
     LEFT JOIN "yandex_music_pet_project"."yandex_music_dbt"."ratings_of_albums_view" as roav ON gd.date = roav.release_date
  ORDER BY gd.date asc