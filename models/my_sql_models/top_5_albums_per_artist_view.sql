with total_likes as 
(
	SELECT album_id,
	       title,
	       genres,
	       sum(likes_count) as total_likes,
	       artist_id,
	       name,
	       date
	FROM {{ ref("ratings_of_albums_view") }} 
	GROUP BY album_id, title, genres, artist_id, name, date
	order by total_likes desc
),
ranked_albums as 
(
	select album_id,
		   title,
		   genres,
		   total_likes,
		   artist_id,
		   name,
		   date,
		   row_number() OVER (PARTITION BY artist_id ORDER BY total_likes DESC) AS rank
	from total_likes
)
select name,
       artist_id,
       album_id,
	    title,
	    genres,
	    total_likes
from ranked_albums
where rank <= 5