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

