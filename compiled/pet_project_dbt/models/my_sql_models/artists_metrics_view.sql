WITH ranked_artists AS (
         SELECT artists_metrics.artist_id,
            first_value(artists_metrics.likes_count) OVER (PARTITION BY artists_metrics.artist_id, (date(artists_metrics.dt)) ORDER BY artists_metrics.dt DESC) AS likes_count,
            first_value(artists_metrics.ratings_month) OVER (PARTITION BY artists_metrics.artist_id, (date(artists_metrics.dt)) ORDER BY artists_metrics.dt DESC) AS ratings_month,
            first_value(artists_metrics.ratings_week) OVER (PARTITION BY artists_metrics.artist_id, (date(artists_metrics.dt)) ORDER BY artists_metrics.dt DESC) AS ratings_week,
            first_value(artists_metrics.ratings_day) OVER (PARTITION BY artists_metrics.artist_id, (date(artists_metrics.dt)) ORDER BY artists_metrics.dt DESC) AS ratings_day,
            date(artists_metrics.dt) AS date
           FROM "yandex_music_pet_project"."public"."artists_metrics" 
        )
 SELECT DISTINCT ranked_artists.artist_id,
    ranked_artists.likes_count,
    ranked_artists.ratings_month,
    ranked_artists.ratings_week,
    ranked_artists.ratings_day,
    ranked_artists.date
   FROM ranked_artists
  ORDER BY ranked_artists.date