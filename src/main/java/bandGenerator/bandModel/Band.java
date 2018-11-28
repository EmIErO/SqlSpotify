package bandGenerator.bandModel;

import java.util.ArrayList;
import java.util.List;

public class Band {
    public static List<Band> bandList = new ArrayList<>();
    private static int countBand = 0;
    private List<Album> albums = new ArrayList<>();
    private int id;
    private String bandName;
    private String country;
    private int start_year;
    private int end_year;

    public Band(String bandName, String country, int start_year, int end_year) {
        countBand++;
        id = countBand;
        this.bandName = bandName;
        this.country = country;
        this.start_year = start_year;
        this.end_year = end_year;
        bandList.add(this);
    }

    public static List<Band> getBandList(){
        return bandList;
    }

    public List<Album> getAlbums() {
        return albums;
    }

    public int getId(){
        return id;
    }

    public String getBandName() {
        return bandName;
    }

    public void setBandName(String bandName) {
        this.bandName = bandName;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getStart_year() {
        return start_year;
    }

    public void setStart_year(int start_year) {
        this.start_year = start_year;
    }

    public int getEnd_year() {
        return end_year;
    }

    public void setEnd_year(int end_year) {
        this.end_year = end_year;
    }

    public void addAlbum(Album album){
        albums.add(album);
    }
}
