select album_id
from "yandex_music_pet_project"."yandex_music_dbt"."top_5_albums_per_artist_view"
where album_id not in (select distinct album_id
					   from "yandex_music_pet_project"."public"."albums")