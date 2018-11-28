package bandGenerator.bandModel;

import java.util.ArrayList;
import java.util.List;

public class Album {

    private static List<Album> albumList = new ArrayList<>();
    private static int countAlbum = 0;
    private int id = 0;
    private String name;
    private String genre;
    private Integer releaseYear;
    private List<Song> songList = new ArrayList<>();

    private int bandId;


    public Album(String name, String genre, Integer releaseYear, int bandId) {
        countAlbum++;
        this.name = name;
        this.genre = genre;
        this.releaseYear = releaseYear;
        this.bandId = bandId;
        id = countAlbum;
        albumList.add(this);
    }

    public int getBandId() {
        return bandId;
    }

    public static List<Album> getAlbumList() {
        return albumList;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Integer getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(Integer releaseYear) {
        this.releaseYear = releaseYear;
    }

    public List<Song> getSongList() {
        return songList;
    }

    public void setSongList(List<Song> songList) {
        this.songList = songList;
    }

    public void addSong(Song song) {
        songList.add(song);
    }
}
