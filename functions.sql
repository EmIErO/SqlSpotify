COPY band(name, country, start_date, end_date) FROM '/home/riczard/projects/codecool/tw_projects/SqlSpotify/src/main/resources/csvGenerated/band.csv' WITH (DELIMITER ',' , NULL '');

COPY album(name, genre, release_date, id_band) FROM '/home/riczard/projects/codecool/tw_projects/SqlSpotify/src/main/resources/csvGenerated/album.csv' WITH (DELIMITER ',' , NULL '');

COPY account (login, password, firstname, surname, gender, email) FROM '/home/riczard/projects/codecool/tw_projects/SqlSpotify/accounts500kUsers.csv' WITH (DELIMITER ',');

COPY song(title, length) FROM '/home/riczard/projects/codecool/tw_projects/SqlSpotify/src/main/resources/csvGenerated/song.csv' WITH (DELIMITER ',' , NULL '');

COPY song_album(id_song, id_album, position) FROM '/home/riczard/projects/codecool/tw_projects/SqlSpotify/src/main/resources/csvGenerated/song_album.csv' WITH (DELIMITER ',' , NULL '');


--index
CREATE index login_idx on account(login);
explain select login from account where login = 'i9o72rcih8vx35k42a';

--view
CREATE VIEW album_detail as
select album.name, song.title, song_album.position from album
right join song_album on album.id_album = song_album.id_album
right join song on song_album.id_song = song.id_song;

select * from album_detail;



CREATE TRIGGER check_User_Exist
  BEFORE INSERT ON account
  for each row
  execute procedure checkIfUserExists();

CREATE or replace FUNCTION checkIfUserExists() RETURNS trigger AS
  $$
  DECLARE
    loginFromTable varchar(50);
    BEGIN
    loginFromTable := (SELECT login FROM account WHERE login = new.login);
    IF(loginFromTable = new.login) then
      raise exception 'User already exists!';
    else
      raise using message = 'Correct';
      return new;
    end if;
  end;
  $$
LANGUAGE PLPGSQL;

insert into account(login, password, firstname, surname, gender, email) values ('yoni9q37m96m9sb','AxmcDZo`hH]sFHajvI','Jewell','Mccaskin','male','metalshemika@msn.com');

CREATE TRIGGER informUser
  BEFORE INSERT
  ON table_name
EXECUTE PROCEDURE procedure_name();