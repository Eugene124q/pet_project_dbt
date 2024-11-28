WITH ranked_albums AS (
         SELECT albums_metrics.album_id,
            first_value(albums_metrics.likes_count) OVER (PARTITION BY albums_metrics.album_id, (date(albums_metrics.dt)) ORDER BY albums_metrics.dt DESC) AS likes_count,
            date(albums_metrics.dt) AS date
           FROM {{ source("public", "albums_metrics") }} -- для предсталвения созданного на основе другого представления использовать макрос ref
        )
 SELECT DISTINCT ranked_albums.album_id,
    ranked_albums.likes_count,
    ranked_albums.date
   FROM ranked_albums
  ORDER BY ranked_albums.date