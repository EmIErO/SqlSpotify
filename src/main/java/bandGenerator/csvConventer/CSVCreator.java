package bandGenerator.csvConventer;

import bandGenerator.bandModel.Album;
import bandGenerator.bandModel.Band;
import bandGenerator.bandModel.Song;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

public class CSVCreator {

    public void createCSVdata() {

        try {

            createBandTable();
            createAlbumTable();
            createSongTable();
            createSong_AlbumTable();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void createBandTable() throws IOException {

        PrintWriter pw = new PrintWriter(new File("band.csv"));
        StringBuilder sb = new StringBuilder();

        for (Band band : Band.getBandList()) {
            sb.append(band.getBandName()).append(",");
            sb.append(band.getCountry()).append(",");
            sb.append(band.getStart_year()).append(",");
            sb.append(band.getEnd_year()).append("\n");
        }
        sb.setLength(sb.length() - 1);
        pw.write(sb.toString());
        pw.close();
    }

    public void createAlbumTable() throws IOException {
        PrintWriter pw = new PrintWriter(new File("album.csv"));
        StringBuilder sb = new StringBuilder();

        for (Album album : Album.getAlbumList()) {
            sb.append(album.getName()).append(",");
            sb.append(album.getGenre()).append(",");

            if(album.getReleaseYear() == null){
                sb.append(",");
            }else{
                sb.append(album.getReleaseYear()).append(",");
            }
            sb.append(album.getBandId()).append("\n");
        }
        sb.setLength(sb.length() - 1);
        pw.write(sb.toString());
        pw.close();
    }

    private void createSongTable() throws IOException {
        PrintWriter pw = new PrintWriter(new File("song.csv"));
        StringBuilder sb = new StringBuilder();

        for (Song song : Song.getSongList()) {
            sb.append(song.getTitle()).append(",");
            sb.append(song.getLength()).append("\n");
        }
        sb.setLength(sb.length() - 1);
        pw.write(sb.toString());
        pw.close();
    }

    private void createSong_AlbumTable() throws IOException {
        PrintWriter pw = new PrintWriter(new File("song_album.csv"));
        StringBuilder sb = new StringBuilder();

        for(Album album : Album.getAlbumList()){

            for(Song song: album.getSongList()){
                sb.append(song.getId()).append(",");
                sb.append(song.getAlbumId()).append(",");
                sb.append(album.getSongList().indexOf(song) + 1).append("\n");
            }
        }
        sb.setLength(sb.length() - 1);
        pw.write(sb.toString());
        pw.close();
    }
}
