CREATE OR REPLACE VIEW album_detail_view as
  select album.name, song.title, song_album.position from album
  right join song_album on album.id_album = song_album.id_album
  right join song on song_album.id_song = song.id_song;

CREATE OR REPLACE VIEW account_playlist_view AS
  SELECT account.login, playlist.name, song.title, song.length
  FROM account JOIN playlist ON account.id_account = playlist.id_account
        JOIN playlist_song ON playlist.id_playlist = playlist_song.id_playlist
        JOIN song ON playlist_song.id_song = song.id_song;

CREATE OR REPLACE VIEW invalid_subscription_view AS
  SELECT a.firstname || ' ' || a.surname AS fullName,
           asub.start_date AS startDate,
           asub.start_date + s.days AS endDate,
           s.name AS subsriptionType
        FROM account_subscription asub
             INNER JOIN account a ON  asub.id_account = a.id_account
             INNER JOIN subscription s on asub.id_subscription = s.id_subscription
  WHERE asub.start_date + s.days < current_date
  ORDER BY endDate DESC;