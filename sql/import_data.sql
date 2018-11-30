500k
COPY account(login, password, firstname, surname, gender, email)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/sql/csv/account500k.csv' WITH (DELIMITER ',' , NULL '');

10k
COPY account(login, password, firstname, surname, gender, email)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/sql/csv/accounts10k.csv' WITH (DELIMITER ',' , NULL '');

COPY artist(firstname, surname, birth_date, death_date, country)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/sql/csv/artist.csv' WITH (DELIMITER ',' , NULL '');

COPY band(name, country, start_date, end_date)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/sql/csv/band.csv' WITH (DELIMITER ',' , NULL '');

COPY album(name, genre, release_date, id_band)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/sql/csv/album.csv' WITH (DELIMITER ',' , NULL '');

COPY song(title, length)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/sql/csv/song.csv' WITH (DELIMITER ',' , NULL '');

COPY song_album(id_song, id_album, position)
FROM '/home/angel/codecool/module4/python/TW2/SqlSpotify/sql/csv/song_album.csv' WITH (DELIMITER ',' , NULL '');

SELECT playlist_gen(100);
SELECT playlist_song_gen();

