
CREATE OR REPLACE VIEW user_playlist_view AS
  SELECT account.login, playlist.name, song.title, song.length
  FROM account JOIN playlist ON account.id_account = playlist.id_account
        JOIN playlist_song ON playlist.id_playlist = playlist_song.id_playlist
        JOIN song ON playlist_song.id_song = song.id_song


EXPLAIN SELECT login FROM account WHERE login = 'h7ft42';

CREATE INDEX login_index ON account(login);

EXPLAIN SELECT login FROM account WHERE login = 'h7ft42';

DROP INDEX login_index;