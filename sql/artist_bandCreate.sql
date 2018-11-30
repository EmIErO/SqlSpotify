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

SELECT artist_band_gen();


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



