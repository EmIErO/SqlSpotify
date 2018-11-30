--first execute file drop_all_from_db.sql

CREATE TABLE artist
(id_artist SERIAL PRIMARY KEY,
firstname VARCHAR(50),
surname VARCHAR(50),
birth_date date,
death_date date,
country VARCHAR(50)
);

CREATE TABLE band
(id_band SERIAL PRIMARY KEY,
name VARCHAR(300),
country VARCHAR(50),
start_date INTEGER,
end_date INTEGER
);

CREATE TABLE artist_band
(id_artist INTEGER REFERENCES artist (id_artist),
id_band INTEGER REFERENCES band (id_band),
join_date DATE
);

CREATE TABLE album
(id_album SERIAL PRIMARY KEY,
name VARCHAR(300),
genre VARCHAR(50),
release_date INTEGER,
id_band INTEGER REFERENCES band (id_band)
);

CREATE TABLE song
(id_song SERIAL PRIMARY KEY,
title VARCHAR(300),
length numeric (6,2)
);

CREATE TABLE song_album
(id_song INTEGER REFERENCES song (id_song),
id_album INTEGER REFERENCES album (id_album),
position INTEGER
);

CREATE TABLE account
(id_account SERIAL PRIMARY KEY,
login VARCHAR(50),
password VARCHAR(50),
firstname VARCHAR(50),
surname VARCHAR(50),
gender VARCHAR(6),
email VARCHAR(50) NOT NULL
);

CREATE TABLE playlist(
id_playlist SERIAL PRIMARY KEY,
name VARCHAR(50),
id_account INTEGER REFERENCES account (id_account)
);

CREATE TABLE playlist_song
(id_playlist INTEGER REFERENCES playlist (id_playlist),
id_song INTEGER REFERENCES song (id_song)
);

CREATE TABLE subscription
(id_subscription SERIAL PRIMARY KEY,
name VARCHAR(50),
days INTEGER,
cost INTEGER
);

CREATE TABLE account_subscription
(id_account INTEGER REFERENCES account (id_account),
id_subscription INTEGER REFERENCES subscription (id_subscription),
start_date DATE
);