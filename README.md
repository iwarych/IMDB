# IMDB

## Data source and data overview

I have analyzed dataset publicly available on the [IMDB website](https://developer.imdb.com/non-commercial-datasets/). It is a subset of IMDB data, refreshed daily.

Analysis provides with high level overview of the titles, annual volume and scoring.

Data are provided in seven gzipped, tab-separated-values (TSV) formatted files. Files are quite large as they contain worldwide titles from years 1874 - 2031 (title's release year). In total a little over 10M unique titles.

### Provided datasets along with data points description (copied from the IMDB website):

title.akas.tsv.gz

    titleId (string) - a tconst, an alphanumeric unique identifier of the title
    ordering (integer) – a number to uniquely identify rows for a given titleId
    title (string) – the localized title
    region (string) - the region for this version of the title
    language (string) - the language of the title
    types (array) - Enumerated set of attributes for this alternative title. 
    attributes (array) - Additional terms to describe this alternative title, not enumerated
    isOriginalTitle (boolean) – 0: not original title; 1: original title

title.basics.tsv.gz

    tconst (string) - alphanumeric unique identifier of the title
    titleType (string) – the type/format of the title (e.g. movie, short, tvseries, tvepisode, video, etc)
    primaryTitle (string) – the more popular title / the title used by the filmmakers on promotional materials at the point of release
    originalTitle (string) - original title, in the original language
    isAdult (boolean) - 0: non-adult title; 1: adult title
    startYear (YYYY) – represents the release year of a title. In the case of TV Series, it is the series start year
    endYear (YYYY) – TV Series end year. ‘\N’ for all other title types
    runtimeMinutes – primary runtime of the title, in minutes
    genres (string array) – includes up to three genres associated with the title

title.crew.tsv.gz

    tconst (string) - alphanumeric unique identifier of the title
    directors (array of nconsts) - director(s) of the given title
    writers (array of nconsts) – writer(s) of the given title

title.episode.tsv.gz

    tconst (string) - alphanumeric identifier of episode
    parentTconst (string) - alphanumeric identifier of the parent TV Series
    seasonNumber (integer) – season number the episode belongs to
    episodeNumber (integer) – episode number of the tconst in the TV series

title.principals.tsv.gz

    tconst (string) - alphanumeric unique identifier of the title
    ordering (integer) – a number to uniquely identify rows for a given titleId
    nconst (string) - alphanumeric unique identifier of the name/person
    category (string) - the category of job that person was in
    job (string) - the specific job title if applicable, else '\N'
    characters (string) - the name of the character played if applicable, else '\N'

title.ratings.tsv.gz

    tconst (string) - alphanumeric unique identifier of the title
    averageRating – weighted average of all the individual user ratings
    numVotes - number of votes the title has received

name.basics.tsv.gz

    nconst (string) - alphanumeric unique identifier of the name/person
    primaryName (string)– name by which the person is most often credited
    birthYear – in YYYY format
    deathYear – in YYYY format if applicable, else '\N'
    primaryProfession (array of strings)– the top-3 professions of the person
    knownForTitles (array of tconsts) – titles the person is known for

## Methodology

I have used PostgreSQL to complete data processing and analysis, and then Tableau Public to create visualizations and dashboards.

### Data processing pipeline:

1. Downloaded raw data.
2. Created SQL database and tables (separate table for each downloaded file) with column names corresponding to column headers in downloaded TSV files. Initially I have set up value types to varchar.
3. Imported data from TSV files to tables.
4. Transformed and cleaned up data:
    - '/N' values replaced with null.
    - Changed data types from varchar to other types (if needed).
5. Analyzed data:
    - By joining tables, using window functions, case statements or mathematical operations between existing columns.
6. Loaded data into CSV files to proceed with visualizations in Tableau Public.

_You can run below files on PostgreSQL:_

[ETL Pipeline](ETL_Queries.sql)

[Data Alaysis Queries](Data_Analysis_Queries.sql)

## Data Visualization in Tableau Public

### [IMDB Dataset Analysis](https://public.tableau.com/app/profile/ilona.warych/viz/IMDBDatasetAnalysis_17000212313630/IMDBDatasetAnalysis)

![image](https://github.com/iwarych/IMDB/assets/59580976/9992fc24-bd51-4c23-8bb8-7bccd50c5f96)

Dashboard provides high level overview on titles included in the IMDB datasets. Due to the number of records, I have limited analyzed data to titles with production started in years 1972 - 2023.

In the top left corner, you will find a bar chart with title volume overview. You can see that volume has increasing trend with few exceptions (2019, 2020, 2022). Year 2023 is not closed yet and perhaps there are titles with production started but not included in the IMDB dataset yet.

On the right side you can see histogram of the average rating. It is nearly symmetrical with most of the votes with rates 6.5- 7.5.

Below those two charts you can find line chart that shows how average run time (in minutes) changed across the years. There is a separate line for each title type. For majority of the title types run time trend did not change across the years (there are small local fluctuations that do not impact overall trend). Run time of Tv miniseries had decreasing trend until 2016 and after that year trend is going upward. TV special had slow increasing trend until around 2009 and then slow downward trend.

On the right-hand side, you can find scatter plot with number of votes and rating. Marks on the chart represents genres, size depends on the title volume. There is no correlation between rating and number of votes.

### [IMDB Rating Overview](https://public.tableau.com/app/profile/ilona.warych/viz/IMDBRatingOverview/IMDBRatingOverview)

![image](https://github.com/iwarych/IMDB/assets/59580976/3dc581a1-8948-466d-aee9-d659fa051842)


Dashboard provides with rating overview. 
In the top left corner, you can select type and how many top titles you would like to see in the table below. Titles are rank based on the number of votes.

Line chart located on the right side provides overview on how average number of episodes for TV shows changed across the years, and if that impacts TV show rating (color coding). As you can see there is a decreasing trend in number of episodes but please note that chart includes also TV series that are still not completed and new seasons are in progress.

On the bottom of the dashboard there is a chart providing overview of titles count and average rating for top genres. As you can see there is a significant gap in titles volume between first three genres (sorted by title volume) and the rest of the genres included on the chart.

