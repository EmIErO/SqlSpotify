
DROP TABLE IF EXISTS artist CASCADE;
CREATE TABLE artist
(id_artist SERIAL PRIMARY KEY,
firstname VARCHAR(50),
surname VARCHAR(50),
birth_date DATE,
death_date DATE,
country VARCHAR(50)
);

DROP TABLE IF EXISTS band CASCADE;
CREATE TABLE band
(id_band SERIAL PRIMARY KEY,
name VARCHAR(50),
start_date DATE,
end_date DATE,
country VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS artist_band CASCADE;
CREATE TABLE artist_band
(id_artist INTEGER REFERENCES artist (id_artist),
id_band INTEGER REFERENCES band (id_band)
);

DROP TABLE IF EXISTS album CASCADE;
CREATE TABLE album
(id_album SERIAL PRIMARY KEY,
name VARCHAR(50),
genere VARCHAR(50),
release_date DATE
);

DROP TABLE IF EXISTS song CASCADE;
CREATE TABLE song
(id_song SERIAL PRIMARY KEY,
title VARCHAR(50),
lenght TIME
);

DROP TABLE IF EXISTS song_album CASCADE;
CREATE TABLE song_album
(id_song INTEGER REFERENCES song (id_song),
id_album INTEGER REFERENCES album (id_album),
position INTEGER
);

DROP TABLE IF EXISTS account CASCADE;
CREATE TABLE account
(id_account SERIAL PRIMARY KEY,
login VARCHAR(50),
password VARCHAR(50),
firstname VARCHAR(50),
surname VARCHAR(50),
gender VARCHAR(1),
email VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS playlist CASCADE;
CREATE TABLE playlist(
id_playlist SERIAL PRIMARY KEY,
name VARCHAR(50),
id_account INTEGER REFERENCES account (id_account)
);

DROP TABLE IF EXISTS playlist_song CASCADE;
CREATE TABLE playlist_song
(id_playlist INTEGER REFERENCES playlist (id_playlist),
id_song INTEGER REFERENCES song (id_song)
);

DROP TABLE IF EXISTS subscription CASCADE;
CREATE TABLE subscription
(id_subscription SERIAL PRIMARY KEY,
name VARCHAR(50),
password VARCHAR(50),
days INTEGER,
cost INTEGER
);

DROP TABLE IF EXISTS account_subscription CASCADE;
CREATE TABLE account_subscription
(id_account INTEGER REFERENCES account (id_account),
id_subscription INTEGER REFERENCES subscription (id_subscription),
start_date DATE
);