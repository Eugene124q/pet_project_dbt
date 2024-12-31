SELECT ratings_of_albums_view.name,
    count(DISTINCT ratings_of_albums_view.album_id) AS count
   FROM "yandex_music_pet_project"."yandex_music_dbt"."ratings_of_albums_view"
  GROUP BY ratings_of_albums_view.name
  ORDER BY (count(DISTINCT ratings_of_albums_view.album_id)) DESC