package bandGenerator.bandModel;

import java.util.ArrayList;
import java.util.List;

public class Song {

    private static List<Song> songList = new ArrayList<>();
    private int id;
    private static int countSong = 0;
    private String title;
    private double length;
    private int albumId;

    public Song(String title, double length, int albumId) {
        countSong++;
        this.title = title;
        this.length = length;
        this.albumId = albumId;
        id = countSong;
        songList.add(this);
    }

    public static List<Song> getSongList() {
        return songList;
    }

    public int getAlbumId() {
        return albumId;
    }

    public int getId(){
        return id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getLength() {
        return length;
    }

    public void setLength(double length) {
        this.length = length;
    }
}
