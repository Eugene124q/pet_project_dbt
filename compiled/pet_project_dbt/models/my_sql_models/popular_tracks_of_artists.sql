select artist_id,
       a.name,
       al.album_id,
       al.title as album_title,
       popular_track_id,
       pt.title,
       replace(pt.cover_uri, '%%'::text, '400x400'::text) AS cover_uri
from "yandex_music_pet_project"."public"."popular_tracks" as pt
  left join "yandex_music_pet_project"."public"."artists" as a using (artist_id)
  left join "yandex_music_pet_project"."public"."albums" as al using (artist_id)