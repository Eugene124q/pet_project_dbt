with total_likes as 
(
	SELECT album_id,
	       title,
	       CASE 
                WHEN genres LIKE '%bass%' THEN REPLACE(genres, 'bass', 'ukbass')
				when ratings_of_albums_view.title = 'Breathe In'::text then 'trance'::text
                when ratings_of_albums_view.title = 'Anjunabeats Worldwide 03'::text then 'trance'::text
                when ratings_of_albums_view.title = 'A State of Trance 2024'::text then 'trance'::text
                when ratings_of_albums_view.title = 'In Search of Sunrise 19'::text then 'trance'::text
                ELSE ratings_of_albums_view.genres
           END AS genres,
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