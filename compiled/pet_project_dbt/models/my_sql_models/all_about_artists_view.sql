SELECT amv.artist_id,
    max(amv.likes_count) AS likes_count,
    max(amv.ratings_month) AS ratings_month,
    max(amv.ratings_week) AS ratings_week,
    max(amv.ratings_day) AS ratings_day,
    max(amv.date) AS date,
    av.name,
    av.genres,
    av.countries,
    av.init_date,
    replace(av.cover_uri, '%%'::text, '400x400'::text) AS cover_uri,
    av.counts_tracks,
    av.counts_direct_albums,
    av.description_text
   FROM "yandex_music_pet_project"."yandex_music_dbt"."artists_metrics_view" as amv
     LEFT JOIN "yandex_music_pet_project"."yandex_music_dbt"."artists_view" as av USING (artist_id)
  GROUP BY amv.artist_id, av.name, av.genres, av.countries, av.init_date, av.cover_uri, av.counts_tracks, av.counts_direct_albums, av.description_text
  ORDER BY (max(amv.date)) DESC