
--first create functions
--IMPORTANT
-- to find command to execute whole file functions.sql

--import, insert, generate data

COPY account(login, password, firstname, surname, gender, email)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/csv/account500k.csv' WITH (DELIMITER ',' , NULL '');

COPY artist(firstname, surname, birth_date, death_date, country)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/csv/artist.csv' WITH (DELIMITER ',' , NULL '');

COPY band(name, country, start_date, end_date)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/csv/band.csv' WITH (DELIMITER ',' , NULL '');

COPY album(name, genre, release_date, id_band)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/csv/album.csv' WITH (DELIMITER ',' , NULL '');

COPY song(title, length)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/csv/song.csv' WITH (DELIMITER ',' , NULL '');

COPY song_album(id_song, id_album, position)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/csv/song_album.csv' WITH (DELIMITER ',' , NULL '');

INSERT INTO subscription (name, days, cost)
VALUES
('standard', 30, 30),
('premium', 90, 80),
('vip', 180, 150);

SELECT playlist_gen(100);
SELECT playlist_song_gen();
SELECT artist_band_gen();
SELECT account_subscription_gen();