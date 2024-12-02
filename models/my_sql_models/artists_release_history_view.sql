SELECT artist_id,
       name,
       countries,
       album_id,
       title,
       genres,
       release_date,
       label_id,
       label_name
   FROM {{ ref("ratings_of_albums_view") }} 