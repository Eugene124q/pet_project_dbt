SELECT pt.artist_id,
    a.name,
    replace(av.cover_uri, '%%'::text, '400x400'::text) AS cover_uri,
    array_agg(DISTINCT pt.title) AS title
   FROM {{ source("public", "popular_tracks") }} as pt
     LEFT JOIN {{ source("public", "artists") }} as a USING (artist_id)
     LEFT JOIN {{ ref("artists_view") }} as av USING (artist_id)
  GROUP BY pt.artist_id, a.name, av.cover_uri