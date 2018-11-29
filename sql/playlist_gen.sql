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

    SELECT cast(floor(random() * count(*) + 1) as INT) INTO account_id FROM account;

    INSERT INTO playlist(name, id_account) VALUES (playlist_name, account_id);

  END LOOP;

END;$$

LANGUAGE  'plpgsql';

