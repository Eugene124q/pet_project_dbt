select artist_id,
       a.name,
       popular_track_id,
       title,
       replace(popular_tracks.cover_uri, '%%'::text, '400x400'::text) AS cover_uri
from {{ source("public", "popular_tracks") }}
  left join {{ source("public", "artists") }} as a using (artist_id)       