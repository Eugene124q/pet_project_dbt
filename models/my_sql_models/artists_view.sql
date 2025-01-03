WITH all_data_needed AS (
         SELECT artists.artist_id,
            artists.name,
            unnest(
                CASE
                    WHEN artists.name = 'Moby'::text THEN string_to_array('electronics,triphop,house,downtempo,ambient,alternative,techno,punk,rock,chill-out,folk'::text, ','::text)
                    WHEN artists.name = 'Burial'::text THEN string_to_array('electronics,dubstep,ambient,ukgarage,ukbass'::text, ','::text)
                    WHEN artists.name = 'deadmau5'::text THEN string_to_array('electronics,progressive house,electro house,techno,dubstep'::text, ','::text)
                    WHEN artists.name = 'Armin van Buuren'::text THEN string_to_array('eletronics,trance,dance'::text, ','::text)
                    when artists.name = 'ARTY'::text then string_to_array('dance,trance,kpop,lounge'::text, ','::text)
                    when artists.name = 'Bon Iver'::text then string_to_array('indie,pop'::text, ','::text)
                    when artists.name = 'Estiva'::text then string_to_array('trance,house,techno,dance'::text, ','::text)
                    when artists.name = 'Lane 8'::text then string_to_array('house,techno,dance,electronics'::text, ','::text)
                    when artists.name = 'Matt Lange'::text then string_to_array('soundtrack,electronics,dance,rock,alternative'::text, ','::text)
                    when artists.name = 'Mat Zo'::text then string_to_array('experimental,dance, electronics,trance,dnb'::text, ','::text)
                    when artists.name = 'Mogwai'::text then string_to_array('alternative,electronics,trance,rock,pop,soundtrack'::text, ','::text)
                    when artists.name = 'Noisia'::text then string_to_array('dnb,dubstep'::text, ','::text)
                    when artists.name = 'Rohaan'::text then string_to_array('electronics,dance,dnb'::text, ','::text)
                    when artists.name = 'Sander Van Doorn'::text then string_to_array('tracne,dance'::text, ','::text)
                    when artists.name = 'Sigur Rós'::text then string_to_array('postrock, experimental'::text, ','::text)
                    when artists.name = 'Trent Reznor'::text then string_to_array('electronics,animated,soundtrack,films'::text, ','::text)
                    when artists.name = 'Uppermost'::text then string_to_array('electronics,house,lounge'::text, ','::text)
                    when artists.name = 'Andrew Bayer'::text then string_to_array('electronics,dance,trance'::text, ','::text)
                    when artists.name = 'Duumu'::text then string_to_array('electronics,dance,relax,folk'::text, ','::text)
                    when artists.name = 'Ilan Bluestone'::text then string_to_array('dance,trance'::text, ','::text)
                    when artists.name = 'London Grammar'::text then string_to_array('indie, ukbass'::text, ','::text)
                    ELSE string_to_array(replace(artists.genres, 'genre'::text, ''::text), ','::text)
                END) AS genres,
            artists.countries,
            date_trunc('year'::text,
                CASE
                    WHEN artists.init_date ~ '^\d{4}-\d{2}-\d{2}$'::text THEN artists.init_date::timestamp without time zone
                    ELSE NULL::timestamp without time zone
                END) AS init_date,
            artists.cover_uri,
            artists.counts_tracks,
            artists.counts_direct_albums,
            artists.description_text
           FROM {{ source("public", "artists") }}
        ), artist_table_first AS (
         SELECT all_data_needed.artist_id,
            all_data_needed.name,
            replace(TRIM(BOTH '[]'::text FROM all_data_needed.genres), ''''::text, ''::text) AS genres,
            replace(TRIM(BOTH '[]'::text FROM all_data_needed.countries), ''''::text, ''::text) AS countries,
            date_part('year'::text, all_data_needed.init_date) AS init_date,
            all_data_needed.cover_uri,
            all_data_needed.counts_tracks,
            all_data_needed.counts_direct_albums,
            all_data_needed.description_text
           FROM all_data_needed
        ), artist_table_second AS (
         SELECT artist_table_first.artist_id,
            artist_table_first.name,
            artist_table_first.genres,
                CASE
                    WHEN artist_table_first.name = 'Lane 8'::text THEN 'United States'::text
                    WHEN artist_table_first.name = 'Synkro'::text THEN 'Canada'::text
                    WHEN artist_table_first.name = 'Duumu'::text THEN 'France'::text
                    WHEN artist_table_first.name = 'Vacant'::text THEN 'United Kingdom'::text
                    WHEN artist_table_first.name = 'Matt Lange'::text THEN 'United States'::text
                    WHEN artist_table_first.name = 'Ilan Bluestone'::text THEN 'United Kingdom'::text
                    WHEN artist_table_first.name = 'Owsey'::text THEN 'Ireland'::text
                    WHEN artist_table_first.name = 'LXST CXNTURY'::text THEN 'Belarus'::text
                    WHEN artist_table_first.name = 'iSorin'::text THEN 'United States'::text
                    WHEN artist_table_first.name = 'Estiva'::text THEN 'Netherlands'::text
                    WHEN artist_table_first.name = 'Andrew Bayer'::text THEN 'United States'::text
                    WHEN artist_table_first.name = 'Rohaan'::text THEN 'United Kingdom'::text
                    WHEN artist_table_first.name = 'Koven'::text THEN 'United Kingdom'::text
                    WHEN artist_table_first.name = 'Uppermost'::text THEN 'France'::text
                    WHEN artist_table_first.name = 'Sebastian Sellares'::text THEN 'Argentina'::text
                    WHEN artist_table_first.name = '36'::text THEN 'United Kingdom'::text
                    WHEN artist_table_first.name = 'Spencer Brown'::text THEN 'United States'::text
                    WHEN artist_table_first.name = 'Marsh'::text THEN 'United Kingdom'::text
                    ELSE artist_table_first.countries
                END AS countries,
            artist_table_first.init_date,
            artist_table_first.cover_uri,
            artist_table_first.counts_tracks,
            artist_table_first.counts_direct_albums,
            artist_table_first.description_text
           FROM artist_table_first
        ), final AS (
         SELECT artist_table_second.artist_id,
            artist_table_second.name,
            artist_table_second.genres,
                CASE
                    WHEN artist_table_second.countries IS NOT NULL AND (artist_table_second.countries <> ALL (ARRAY['США'::text, 'Великобритания'::text, 'Россия'::text, 'Германия'::text, 'Франция'::text, 'Исландия'::text, 'Норвегия'::text, 'Нидерланды'::text, 'Канада'::text])) THEN artist_table_second.countries
                    WHEN artist_table_second.countries = 'США'::text THEN 'United States'::text
                    WHEN artist_table_second.countries = 'Великобритания'::text THEN 'United Kingdom'::text
                    WHEN artist_table_second.countries = 'Россия'::text THEN 'Russia'::text
                    WHEN artist_table_second.countries = 'Германия'::text THEN 'Germany'::text
                    WHEN artist_table_second.countries = 'Франция'::text THEN 'France'::text
                    WHEN artist_table_second.countries = 'Исландия'::text THEN 'Iceland'::text
                    WHEN artist_table_second.countries = 'Норвегия'::text THEN 'Norway'::text
                    WHEN artist_table_second.countries = 'Нидерланды'::text THEN 'Netherlands'::text
                    WHEN artist_table_second.countries = 'Канада'::text THEN 'Canada'::text
                    ELSE NULL::text
                END AS countries,
            artist_table_second.init_date,
            replace(artist_table_second.cover_uri, '%%'::text, '400x400'::text) AS cover_uri,
            artist_table_second.counts_tracks,
            artist_table_second.counts_direct_albums,
            artist_table_second.description_text
           FROM artist_table_second
        )
 SELECT final.artist_id,
    final.name,
    TRIM(BOTH FROM final.genres) AS genres,
    final.countries,
    final.init_date,
    final.cover_uri,
    final.counts_tracks,
    final.counts_direct_albums,
    final.description_text
   FROM final