--functions to generate data for table account_subscription

CREATE OR REPLACE FUNCTION account_subscription_gen() RETURNS void AS $$
DECLARE rec RECORD;

BEGIN
 FOR rec IN SELECT * FROM account
 LOOP
    INSERT INTO account_subscription (id_account, id_subscription, start_date)
    SELECT rec.id_account,
           random_subscription(),
           random_date('2018-01-01', '2018-11-29')

    WHERE rec.id_account % 7 > 3 AND rec.firstname LIKE '%a%';
 END LOOP;
END ;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION random_date (fromDate DATE, toDate DATE) RETURNS DATE  AS $$
DECLARE
 days_between INT;
 days_rand INT;

BEGIN
 SELECT $2 - $1 INTO days_between;
 SELECT cast(random() * days_between as INT) INTO days_rand;
 RETURN $1 + days_rand;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION random_subscription () RETURNS INT AS $$
DECLARE
 id INT;

 BEGIN
  SELECT id_subscription FROM subscription ORDER BY random() LIMIT 1 INTO id;
 RETURN id;
 END;
$$ LANGUAGE  'plpgsql';

--functions to generate data for table artist_band
CREATE OR REPLACE FUNCTION artist_band_gen() RETURNS void AS $$

DECLARE
  max_artists_in_band INTEGER := 6;
  amount INTEGER;
  band_id INTEGER;
  artist_id INTEGER;

BEGIN

  FOR band_id IN SELECT id_band FROM band LOOP

    SELECT cast(floor(random() * max_artists_in_band + 1) as INT) INTO amount;

    FOR i IN 0..amount LOOP

      SELECT id_artist INTO artist_id FROM artist ORDER BY RANDOM() LIMIT 1;

      IF band_id IS NOT NULL AND artist_id IS NOT NULL THEN
        INSERT INTO artist_band(id_artist, id_band, join_date) VALUES (artist_id, band_id, random_date('1988-01-01', '2017-12-31'));
      END IF;

    END LOOP;
  END LOOP;

END;$$

LANGUAGE  'plpgsql';


CREATE OR REPLACE FUNCTION random_artist() RETURNS INT AS $$
BEGIN
RETURN (SELECT id_artist FROM artist ORDER BY random() LIMIT 1);
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION random_band() RETURNS INT AS $$
BEGIN
RETURN (SELECT id_band FROM band ORDER BY random() LIMIT 1);
END;
$$ LANGUAGE 'plpgsql';


--functions to generate data for table playlist
CREATE OR REPLACE FUNCTION create_word(word_len INTEGER) RETURNS VARCHAR AS $$

DECLARE
  chars TEXT := ' abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789 ';
  next_char CHAR;
  word VARCHAR(50) := '';

BEGIN

  FOR i IN 1..word_len LOOP

    SELECT substr(chars, cast(floor(random() * length(chars) + 1) as INT), 1) INTO next_char;
    word := next_char || word;

  END LOOP;

  RETURN word;

END;$$

LANGUAGE  'plpgsql';

CREATE OR REPLACE FUNCTION playlist_gen(amount INTEGER) RETURNS void AS $$

DECLARE
  random_length INTEGER;
  playlist_name VARCHAR(50) := '';
  account_id INTEGER;

BEGIN

  FOR counter IN 0..amount LOOP

    playlist_name := '';

    SELECT cast(floor(random() * 50 + 1) as INT) INTO random_length;

    SELECT create_word(random_length) INTO playlist_name;

    --SELECT cast(floor(random() * count(*) + 1) as INT) INTO account_id FROM account;
    SELECT id_account INTO account_id FROM account ORDER BY RANDOM() LIMIT 1;

    INSERT INTO playlist(name, id_account) VALUES (playlist_name, account_id);

  END LOOP;

END;$$

LANGUAGE 'plpgsql';

--function to generate table playlist_song
CREATE OR REPLACE FUNCTION playlist_song_gen() RETURNS void AS $$

DECLARE
  max_songs_on_playlist INTEGER := 100;
  amount INTEGER;
  playlist_id INTEGER;
  song_id INTEGER;

BEGIN

  FOR playlist_id IN SELECT id_playlist FROM playlist LOOP

    SELECT cast(floor(random() * max_songs_on_playlist + 1) as INT) INTO amount;

    FOR i IN 0..amount LOOP

      --SELECT cast(floor(random() * count(*) + 1) as INT) INTO song_id FROM song;
      SELECT id_song INTO song_id FROM song ORDER BY RANDOM() LIMIT 1;

      IF playlist_id IS NOT NULL AND song_id IS NOT NULL THEN
        INSERT INTO playlist_song(id_playlist, id_song) VALUES (playlist_id, song_id);
      END IF;

    END LOOP;
  END LOOP;

END;$$

LANGUAGE  'plpgsql';


--function for trigger
CREATE or replace FUNCTION check_if_user_exists() RETURNS trigger AS
  $$
  DECLARE
    loginFromTable varchar(50);
    BEGIN
    loginFromTable := (SELECT login FROM account WHERE login = new.login);
    IF(loginFromTable = new.login) then
      raise exception 'User already exists!';
    else
      raise notice 'Correct';
      return new;
    end if;
  end;
  $$
LANGUAGE PLPGSQL;