--create tables
CREATE TABLE name_basics (
    nconst varchar,
    primaryName varchar,
    birthYear varchar,
    deathYear varchar,
    primaryProfession varchar,
    knownForTitles varchar
);

CREATE TABLE title_akas (
    titleId varchar,
    ordering varchar,
    title varchar,
    region varchar,
    LANGUAGE varchar
,
    types varchar,
    attributes varchar,
    isOriginalTitle varchar
);

CREATE TABLE title_basics (
    tconst varchar,
    titleType varchar,
    primaryTitle varchar,
    originalTitle varchar,
    isAdult varchar,
    startYear varchar,
    endYear varchar,
    runtimeMinutes varchar,
    genres varchar
);

CREATE TABLE title_crew (
    tconst varchar,
    directors varchar,
    writers varchar
);

CREATE TABLE title_episode (
    tconst varchar,
    parentTconst varchar,
    seasonNumber varchar,
    episodeNumber varchar
);

CREATE TABLE title_principals (
    tconst varchar,
    ordering varchar,
    nconst varchar,
    category varchar,
    job varchar,
    characters varchar
);

CREATE TABLE title_ratings (
    tconst varchar,
    averageRating varchar,
    numVotes varchar
);

--Load data
COPY name_basics
FROM
    'here was path to a csv file saved on my computer'
DELIMITER E'\t' CSV HEADER;

COPY title_akas
FROM
    'here was path to a csv file saved on my computer' QUOTE E'\b' 
DELIMITER E'\t' CSV HEADER;

COPY title_basics
FROM
    'here was path to a csv file saved on my computer' QUOTE E'\b' 
DELIMITER E'\t' CSV HEADER;

COPY title_crew
FROM
    'here was path to a csv file saved on my computer' QUOTE E'\b' 
DELIMITER E'\t' CSV HEADER;

COPY title_episode
FROM
    'here was path to a csv file saved on my computer' QUOTE E'\b' 
DELIMITER E'\t' CSV HEADER;

COPY title_principals
FROM
    'here was path to a csv file saved on my computer' QUOTE E'\b' 
DELIMITER E'\t' CSV HEADER;

COPY title_ratings
FROM
    'here was path to a csv file saved on my computer' QUOTE E'\b' 
DELIMITER E'\t' CSV HEADER;

--replace values
UPDATE
    name_basics
SET
    nconst = NULL
WHERE
    nconst = '\N';

UPDATE
    name_basics
SET
    primaryname = NULL
WHERE
    primaryname = '\N';

UPDATE
    name_basics
SET
    birthyear = NULL
WHERE
    birthyear = '\N';

UPDATE
    name_basics
SET
    deathyear = NULL
WHERE
    deathyear = '\N';

UPDATE
    name_basics
SET
    primaryprofession = NULL
WHERE
    primaryprofession = '\N';

UPDATE
    name_basics
SET
    knownfortitles = NULL
WHERE
    knownfortitles = '\N';

UPDATE
    title_akas
SET
    titleid = NULL
WHERE
    titleid = '\N';

UPDATE
    title_akas
SET
    ordering = NULL
WHERE
    ordering = '\N';

UPDATE
    title_akas
SET
    title = NULL
WHERE
    title = '\N';

UPDATE
    title_akas
SET
    region = NULL
WHERE
    region = '\N';

UPDATE
    title_akas
SET
    LANGUAGE =
    NULL
WHERE
    LANGUAGE =
    '\N';

UPDATE
    title_akas
SET
    types = NULL
WHERE
    types = '\N';

UPDATE
    title_akas
SET
    attributes = NULL
WHERE
    attributes = '\N';

UPDATE
    title_akas
SET
    isoriginaltitle = NULL
WHERE
    isoriginaltitle = '\N';

UPDATE
    title_basics
SET
    tconst = NULL
WHERE
    tconst = '\N';

UPDATE
    title_basics
SET
    titletype = NULL
WHERE
    titletype = '\N';

UPDATE
    title_basics
SET
    primarytitle = NULL
WHERE
    primarytitle = '\N';

UPDATE
    title_basics
SET
    originaltitle = NULL
WHERE
    originaltitle = '\N';

UPDATE
    title_basics
SET
    isadult = NULL
WHERE
    isadult = '\N';

UPDATE
    title_basics
SET
    startyear = NULL
WHERE
    startyear = '\N';

UPDATE
    title_basics
SET
    endyear = NULL
WHERE
    endyear = '\N';

UPDATE
    title_basics
SET
    runtimeminutes = NULL
WHERE
    runtimeminutes = '\N';

UPDATE
    title_basics
SET
    genres = NULL
WHERE
    genres = '\N';

UPDATE
    title_crew
SET
    tconst = NULL
WHERE
    tconst = '\N';

UPDATE
    title_crew
SET
    directors = NULL
WHERE
    directors = '\N';

UPDATE
    title_crew
SET
    writers = NULL
WHERE
    writers = '\N';

UPDATE
    title_episode
SET
    tconst = NULL
WHERE
    tconst = '\N';

UPDATE
    title_episode
SET
    parenttconst = NULL
WHERE
    parenttconst = '\N';

UPDATE
    title_episode
SET
    seasonnumber = NULL
WHERE
    seasonnumber = '\N';

UPDATE
    title_episode
SET
    episodenumber = NULL
WHERE
    episodenumber = '\N';

UPDATE
    title_principals
SET
    tconst = NULL
WHERE
    tconst = '\N';

UPDATE
    title_principals
SET
    ordering = NULL
WHERE
    ordering = '\N';

UPDATE
    title_principals
SET
    nconst = NULL
WHERE
    nconst = '\N';

UPDATE
    title_principals
SET
    category = NULL
WHERE
    category = '\N';

UPDATE
    title_principals
SET
    job = NULL
WHERE
    job = '\N';

UPDATE
    title_principals
SET
    characters = NULL
WHERE
    characters = '\N';

UPDATE
    title_ratings
SET
    tconst = NULL
WHERE
    tconst = '\N';

UPDATE
    title_ratings
SET
    averagerating = NULL
WHERE
    averagerating = '\N';

UPDATE
    title_ratings
SET
    numvotes = NULL
WHERE
    numvotes = '\N';


--Change value types
ALTER TABLE name_basics
ALTER COLUMN primaryname TYPE TEXT USING (primaryname::text),
ALTER COLUMN birthyear TYPE INT USING (birthyear::integer),
ALTER COLUMN deathyear TYPE INT USING (deathyear::integer),
ALTER COLUMN primaryprofession TYPE TEXT USING (primaryprofession::text);

ALTER TABLE title_akas
ALTER COLUMN ordering TYPE INT USING (ordering::integer),
ALTER COLUMN title TYPE TEXT USING (title::text),
ALTER COLUMN region TYPE TEXT USING (region::text),
ALTER COLUMN language TYPE TEXT USING (language::text),
ALTER COLUMN types TYPE TEXT USING (types::text),
ALTER COLUMN attributes TYPE TEXT USING (attributes::text),
ALTER COLUMN isoriginaltitle TYPE INT USING (isoriginaltitle::integer);

ALTER TABLE title_basics
ALTER COLUMN titletype TYPE TEXT USING (titletype::text),
ALTER COLUMN primarytitle TYPE TEXT USING (primarytitle::text),
ALTER COLUMN originaltitle TYPE TEXT USING (originaltitle::text),
ALTER COLUMN isadult TYPE INT USING (isadult::integer),
ALTER COLUMN startyear TYPE INT USING (startyear::integer),
ALTER COLUMN endyear TYPE INT USING (endyear::integer),
ALTER COLUMN runtimeminutes TYPE INT USING (runtimeminutes::integer),
ALTER COLUMN genres TYPE TEXT USING (genres::text);

ALTER TABLE title_principals
ALTER COLUMN ordering TYPE INT USING (ordering::integer),
ALTER COLUMN category TYPE TEXT USING (category::text),
ALTER COLUMN job TYPE TEXT USING (job::text);

ALTER TABLE title_ratings
ALTER COLUMN averagerating TYPE DECIMAL USING (averagerating::decimal),
ALTER COLUMN numvotes TYPE INT USING (numvotes::integer);

