--SotifyPoularSongs dataset was obtained from kaggle
--the data was imported into an existing  databese project portfolio
--the data has 20 columns

select * 
from SpotifyPopularSongs

--Find the top 10 most streamed songs


select  top 10 track_name, streams
from SpotifyPopularSongs
order by streams desc

--list of artist that have more than one song

select 
 [artist(s)_name], count([artist(s)_name]) count_of_songs
from SpotifyPopularSongs
group by [artist(s)_name]  
having count([artist(s)_name]) > 1
order by count([artist(s)_name]) desc
  
--list of tracks which were released in 2023
select 
track_name
from SpotifyPopularSongs
where released_year = 2023 and track_name is not null
order by track_name

--classify songs according to their released date


select track_name, released_year,
 case
  when released_year  between 1930 and 1999 then 'acient'
  when released_year between 2000 and 2016 then 'old'
  else 'new'
 end as song_age
from SpotifyPopularSongs

--list of songs that have more than one artist

select track_name,  artist_count
from SpotifyPopularSongs
where artist_count > 2 and track_name is not null
group by track_name, artist_count
order by artist_count desc

--find the average danceability of the songs released each year

select 
 released_year, avg([danceability_%]) as avg_danceability
from SpotifyPopularSongs
group by released_year
order by released_year

--find tracks with bpm of between 120-130 and were released past 2010

select 
track_name, bpm
from SpotifyPopularSongs
where bpm between 120 and 130
and released_year > 2010
order by bpm desc

--list tracks with liveliness above 20 and high acoustic above 20

select track_name, [acousticness_%], [liveness_%]
from SpotifyPopularSongs
where [acousticness_%] > 20 and [liveness_%] > 20
order by [acousticness_%] desc

--list of tracks which were released in march 2023

select track_name
from SpotifyPopularSongs
where released_year = 2023 and released_month = 3
order by track_name

--find the average bpm of tracks that are in the spotify playlist

select avg(bpm)
from 
SpotifyPopularSongs

--list the number of tracks released each year and show which year had the most tracks released

 select released_year, count(*) no_of_songs_released_yearly
 from SpotifyPopularSongs
 group by released_year
 order by count(*) desc

 --list of songs that are popular in both spotify and apple


 select apple.track_name, apple.in_apple_charts, spotiy.track_name, spotiy.in_spotify_charts
 from SpotifyPopularSongs as apple
 join
SpotifyPopularSongs as spotiy
  on apple.track_name = spotiy.track_name

 --number of  songs  according to melodic behaviour
 select mode, count(*)
 from
 SpotifyPopularSongs
 group by  mode

  --list of songs by Tylor Swift released in 2023

  select track_name
  from SpotifyPopularSongs
  where [artist(s)_name] = 'Taylor Swift' and released_year = 2023

  --list of most streamed track each year
  
  select a.track_name, a.[artist(s)_name], a.released_year, a.streams
  from SpotifyPopularSongs as a
  join 
  (select released_year,max(streams)  as maxstreams
  from SpotifyPopularSongs 
  group by released_year) max_streams
  on a.released_year = max_streams.released_year
  and a.streams = max_streams.maxstreams
  order by a.released_year desc, streams
  
  --calculate the  average danceability, enerdy  and valence for tracks in spotify

  select avg([danceability_%]) avg_danceability, 
  avg([energy_%]) avg_energy,
  avg([valence_%]) avg_valence
  from SpotifyPopularSongs

  --distribution of tracks by key and mode
  select  
  [key], mode, count(*)
  from 
  SpotifyPopularSongs
 group by [key], mode
  order by count(*) desc
