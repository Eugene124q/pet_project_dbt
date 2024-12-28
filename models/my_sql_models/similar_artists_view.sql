WITH all_of_need AS (
         SELECT similar_artists.artist_id,
            similar_artists.similar_artist_id,
            similar_artists.name as similar_artist_name,
            replace(TRIM(BOTH '{}'::text FROM similar_artists.genres), ''''::text, ''::text) AS genres,
            similar_artists.cover_uri,
            similar_artists.counts_tracks,
            similar_artists.counts_direct_albums
           FROM {{source("public", "similar_artists") }}
        ), similar_artists_with_name AS (
         SELECT aon.artist_id,
            a.name,
            aon.similar_artist_id,
            aon.similar_artist_name,
            unnest(string_to_array(aon.genres, ','::text)) AS genres,
            aon.cover_uri,
            aon.counts_tracks,
            aon.counts_direct_albums
           FROM all_of_need aon
             LEFT JOIN {{ source("public", "artists") }} as a USING (artist_id)
        )
 SELECT similar_artists_with_name.artist_id,
    similar_artists_with_name.name,
    similar_artists_with_name.similar_artist_id,
    similar_artists_with_name.similar_artist_name,
    regexp_replace(similar_artists_with_name.genres, 'genre$'::text, ''::text) AS genres,
    replace(similar_artists_with_name.cover_uri, '%%'::text, '400x400'::text) AS cover_uri,
    similar_artists_with_name.counts_tracks,
    similar_artists_with_name.counts_direct_albums
   FROM similar_artists_with_name