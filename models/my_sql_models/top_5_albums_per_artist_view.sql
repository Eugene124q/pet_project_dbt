WITH latestlikes AS (
         SELECT roav.album_id,
            roav.title,
            roav.likes_count,
            roav.artist_id,
            roav.name,
            max(roav.date) AS latest_date
           FROM {{ ref("ratings_of_albums_view") }} as roav
          GROUP BY roav.album_id, roav.title, roav.likes_count, roav.artist_id, roav.name
        ), sum_likes_count AS (
         SELECT latestlikes.artist_id,
            latestlikes.name,
            latestlikes.album_id,
            latestlikes.title,
            sum(latestlikes.likes_count) AS total_likes
           FROM latestlikes
          GROUP BY latestlikes.artist_id, latestlikes.name, latestlikes.album_id, latestlikes.title
          ORDER BY (sum(latestlikes.likes_count)) DESC
        ), ranked_albums AS (
         SELECT sum_likes_count.artist_id,
            sum_likes_count.name,
            sum_likes_count.album_id,
            sum_likes_count.title,
            sum_likes_count.total_likes,
            row_number() OVER (PARTITION BY sum_likes_count.artist_id ORDER BY sum_likes_count.total_likes DESC) AS rank
           FROM sum_likes_count
        )
 SELECT ranked_albums.name,
    ranked_albums.title,
    ranked_albums.total_likes
   FROM ranked_albums
  WHERE ranked_albums.rank <= 5