select album_id
from {{ ref("top_5_albums_per_artist_view") }}
where album_id not in (select distinct album_id
					   from {{ source("public", "albums") }})