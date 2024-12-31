SELECT amv.album_id,
    max(amv.likes_count) AS likes_count,
    max(amv.date) AS date,
    al.artist_id,
    al.title,
    al.track_count,
    al.cover_uri,
    regexp_replace(al.genre, 'genre$'::text, ''::text) AS genres,
    al.release_date::date AS release_date,
    al.label_id,
    al.label_name,
    ar.name,
    av.countries
   FROM "yandex_music_pet_project"."yandex_music_dbt"."albums_metrics_view" as amv
     LEFT JOIN "yandex_music_pet_project"."public"."albums" as al USING (album_id)
     LEFT JOIN "yandex_music_pet_project"."public"."artists" as ar USING (artist_id)
     LEFT JOIN "yandex_music_pet_project"."yandex_music_dbt"."artists_view" as av USING (artist_id)
  GROUP BY amv.album_id, al.artist_id, al.title, al.track_count, al.cover_uri, (regexp_replace(al.genre, 'genre$'::text, ''::text)), (al.release_date::date), al.label_id, al.label_name, ar.name, av.countries