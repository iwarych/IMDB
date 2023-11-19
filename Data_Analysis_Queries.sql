--Query #1
--count titles, view by year
WITH films_year AS (
    SELECT
        tb.startyear AS start_year,
        COUNT(DISTINCT tb.tconst) AS film_count
    FROM
        title_basics AS tb
    WHERE
        tb.startyear < 2024
    GROUP BY
        tb.startyear
),
--count distribution countries for title
--create distribution buckets, group by year and title
release_cnt_title AS (
    SELECT
        tb.startyear AS start_year,
        ta.titleid,
        (
            CASE WHEN count(DISTINCT ta.ordering) = 1 THEN
                'One'
            WHEN count(DISTINCT ta.ordering) <= 5 THEN
                'Up to 5'
            WHEN count(DISTINCT ta.ordering) <= 10 THEN
                'Up to 10'
            WHEN count(DISTINCT ta.ordering) > 10 THEN
                '11 and more'
            ELSE
                'None'
            END) AS distribution_cnt
    FROM
        title_akas AS ta
        JOIN title_basics AS tb ON tb.tconst = ta.titleid
    GROUP BY
        ta.titleid,
        tb.startyear
),
--count titles by distribution buckets and year
distribution_buckets AS (
    SELECT
        start_year,
        distribution_cnt,
        count(titleid) AS film_cnt_buckets
    FROM
        release_cnt_title
    GROUP BY
        start_year,
        distribution_cnt
    ORDER BY
        start_year,
        distribution_cnt)
--caluclates film volume % by year and distribution bucket 
    SELECT
        fy.start_year,
        dbu.distribution_cnt,
        dbu.film_cnt_buckets,
        fy.film_count,
        (dbu.film_cnt_buckets / fy.film_count::float) * 100 AS prct_total_year
    FROM
        films_year AS fy
        JOIN distribution_buckets AS dbu ON dbu.start_year = fy.start_year;

--Query #2
--count titles, group by years
SELECT 
  tb.startyear AS start_year, 
  COUNT (DISTINCT tb.tconst) as film_count 
FROM 
  title_basics AS tb 
WHERE 
  tb.startyear < 2024 
GROUP BY 
  tb.startyear;

--Query #3
--titles count and type, group by years
SELECT
    tb.startyear AS start_year,
    tb.genres AS genres,
    COUNT(DISTINCT tb.tconst) AS film_count
FROM
    title_basics AS tb
WHERE
    tb.startyear < 2024
GROUP BY
    tb.startyear,
    tb.genres;

--Query #4
--title volume by run time
SELECT
    startyear AS start_year,
    titletype,
    avg(runtimeminutes) AS run_time_min
FROM
    title_basics
WHERE
    startyear < 2024
GROUP BY
    startyear,
    titletype
ORDER BY
    startyear,
    titletype;

--Query #5
--genres count by directors
SELECT
    tp.nconst AS person_id,
    count(DISTINCT tb.genres) AS genres_cnt,
    nb.primaryname AS person_name,
    nb.birthyear AS birth_year,
    nb.primaryprofession AS primary_profession,
    nb.knownfortitles AS known_for_titles
FROM
    "imdb".title_principals AS tp
    INNER JOIN "imdb".title_basics AS tb ON tb.tconst = tp.tconst
    INNER JOIN "imdb".name_basics AS nb ON nb.nconst = tp.nconst
WHERE
    nb.primaryprofession LIKE '%director%'
    AND nb.birthyear >= 1900
GROUP BY
    tp.nconst,
    nb.primaryname,
    nb.birthyear,
    nb.primaryprofession,
    nb.knownfortitles
ORDER BY
    tp.nconst;

--Query #6
--genres: average rating, number of votes, (last 50 years)
SELECT
    tb.genres,
    tb.startyear,
    avg(tr.averagerating) AS avg_rating,
    avg(tr.numvotes) AS avg_number_votes,
    count(DISTINCT tr.tconst) AS cnt_titles
FROM
    "imdb".title_ratings AS tr
    INNER JOIN "imdb".title_basics AS tb ON tb.tconst = tr.tconst
WHERE
    tb.startyear < 2024
    AND tb.startyear > 1972
GROUP BY
    1,
    2
ORDER BY
    1,
    2;

--Query #7
--average rating, run time, title numbers by title type
SELECT
    tb.titletype AS title_type,
    avg(tr.averagerating) AS avg_rating,
    avg(tb.runtimeminutes) AS avg_run_time,
    count(DISTINCT tb.tconst) AS cnt_titles
FROM
    "imdb".title_ratings AS tr
    INNER JOIN "imdb".title_basics AS tb ON tb.tconst = tr.tconst
WHERE
    tb.startyear < 2024
    AND tb.startyear > 1972
GROUP BY
    1
ORDER BY
    1;

--Query #8
---distribiution count by title
WITH base AS (
    SELECT
        tb.startyear AS start_year,
        ta.titleid,
        tb.genres AS genres,
        count(DISTINCT ta.ordering) AS distribution_cnt
    FROM
        title_akas AS ta
        JOIN title_basics AS tb ON tb.tconst = ta.titleid
    GROUP BY
        ta.titleid,
        tb.startyear,
        tb.genres)
--title average distribution by year
SELECT
    start_year,
	genres,
    count(DISTINCT titleid) AS title_volume,
    avg(distribution_cnt) AS avg_distribution
FROM
    base
GROUP BY
    start_year,
    genres;

--Query #9
--episode count vs rating
SELECT
    tb.startyear AS start_year,
    te.parenttconst AS TV_series,
    tb.primarytitle AS title,
    count(DISTINCT te.tconst) AS episodes_cnt,
    avg(tr.averagerating) AS rating
FROM
    title_episode AS te
    LEFT JOIN title_basics AS tb ON tb.tconst = te.parenttconst
    LEFT JOIN title_ratings AS tr ON tr.tconst = te.parenttconst
WHERE
    tb.startyear < 2024
GROUP BY
    tb.startyear,
    te.parenttconst,
    tb.primarytitle;

--Query #10
---average rating, number of votes, title count by genres
SELECT
    tb.genres,
    avg(tr.averagerating) AS avg_rating,
    sum(tr.numvotes) AS sum_number_votes,
    count(DISTINCT tr.tconst) AS cnt_titles
FROM
    title_ratings AS tr
    INNER JOIN title_basics AS tb ON tb.tconst = tr.tconst
WHERE
    tb.startyear < 2024
    AND tb.startyear > 1972
GROUP BY
    1
ORDER BY
    1;

--Query #11
--rank by type based on number of votes
SELECT
    tb.titletype AS title_type,
    tb.primarytitle AS title,
    tr.averagerating AS avg_rating,
    tr.numvotes AS votes,
    tb.startyear AS year,
    ta.region,
    tc.directors AS director,
    tc.writers AS writer,
    tb.runtimeminutes AS runtime,
    tb.genres AS genres,
    rank() OVER (PARTITION BY tb.titletype ORDER BY tr.numvotes DESC) AS rank
FROM
    title_basics AS tb
    LEFT JOIN title_ratings AS tr ON tr.tconst = tb.tconst
    LEFT JOIN title_akas AS ta ON ta.titleid = tb.tconst
    LEFT JOIN title_crew AS tc ON tc.tconst = tb.tconst
WHERE
    tb.startyear < 2024
    AND tr.averagerating IS NOT NULL
    AND ta.isoriginaltitle = 1 AND  tb.startyear > 1972 AND ta.isoriginaltitle = 1;



