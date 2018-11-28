package csvConventer;

import dateGenerator.DateGenerator;
import net.andreinc.mockneat.MockNeat;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

public class BandGenerator {

    private MockNeat mock = MockNeat.threadLocal();
    DateGenerator dateGenerator = new DateGenerator();

    private List<String> data;
    private final int bandNameIndex = 0;
    private final int lengthIndex = 1;
    private final int countryIndex = 2;
    private final int albumNameIndex = 3;
    private final int genreNameIndex = 4;
    private final int songNameIndex = 5;
    private final int songYearRealiseIndex = 6;
    private List<Band> bandList = new ArrayList<>();

    public BandGenerator(List<String> data) {
        this.data = data;
    }

    public void generate() {

        String[] partsOfData;
        for (String part : data) {
            partsOfData = part.split(",");

            Band band = getBandByName(partsOfData[bandNameIndex]);

            if(band == null) band = bandGenerate(partsOfData);


            Album album = getAlbumByName(partsOfData[albumNameIndex], band.getAlbums());
            if(album == null) album = albumGenerate();


        }

    }

    private Album getAlbumByName(String albumName, List<Album> albums){

        for(Album album: albums){
            if(album.getName().equals(albumName)) return album;
        }
        return null;
    }

    private Band getBandByName(String bandName) {
        for(Band band: bandList){
            if(band.getBandName().equals(bandName)) return band;
        }
        return null;
    }

    private Band bandGenerate(String[] partsOfData) {

        String bandName = partsOfData[bandNameIndex];
        String country = (partsOfData[countryIndex].equals("Not available")) ? ("") : partsOfData[countryIndex]; //because we dont want not avaible in database
        int randomStartYear = getRandomStartYearBasingOnSongRelease(Integer.parseInt(partsOfData[songYearRealiseIndex]));
        int randomEndYear = getRandomEndYearBasingOnSongRelease(Integer.parseInt(partsOfData[songYearRealiseIndex]), randomStartYear);

        Band band = new Band(bandName, country, randomStartYear, randomEndYear);
        return band;
    }

    private int getRandomStartYearBasingOnSongRelease(int songReleaseYear) {
        if (songReleaseYear == 0) {
            return ThreadLocalRandom.current().nextInt(1948, 2018);
        }
        return ThreadLocalRandom.current().nextInt(songReleaseYear - 20, songReleaseYear + 30);
    }

    private int getRandomEndYearBasingOnSongRelease(int songReleaseDate, int startYearBand) {
        int endOfRange = (songReleaseDate - startYearBand);
        return ThreadLocalRandom.current().nextInt(songReleaseDate, endOfRange + 20);
    }


}
