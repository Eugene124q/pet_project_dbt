select artist_id,
       a.name,
       al.album_id,
       al.title as album_title,
       popular_track_id,
       pt.title,
       replace(pt.cover_uri, '%%'::text, '400x400'::text) AS cover_uri
from {{ source("public", "popular_tracks") }} as pt
  left join {{ source("public", "artists") }} as a using (artist_id)
  left join {{ source("public", "albums") }} as al using (artist_id)       