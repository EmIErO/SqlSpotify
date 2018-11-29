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

