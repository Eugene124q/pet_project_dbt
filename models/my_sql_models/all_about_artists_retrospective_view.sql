SELECT amv.artist_id,
    amv.likes_count,
    amv.ratings_month,
    amv.ratings_week,
    amv.ratings_day,
    amv.date,
    av.name,
    av.genres,
    av.countries,
    av.init_date,
    replace(av.cover_uri, '%%'::text, '400x400'::text) AS cover_uri,
    av.counts_tracks,
    av.counts_direct_albums,
    av.description_text
   FROM {{ ref("artists_metrics_view") }} as amv
     LEFT JOIN {{ ref("artists_view") }} as av USING (artist_id)