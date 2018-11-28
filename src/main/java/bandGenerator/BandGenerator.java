package bandGenerator;

import bandGenerator.bandModel.Album;
import bandGenerator.bandModel.Band;
import bandGenerator.bandModel.Song;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

public class BandGenerator {

    private List<String> data;

    private final int bandNameIndex = 0;
    private final int albumNameIndex = 3;
    private final int albumYearRealiseIndex = 6;

    public void generate(List<String> data) {

        String[] partsOfData;
        for (String part : data) {
            partsOfData = part.split(",");
            if (partsOfData.length > 7) partsOfData = resizeArray(partsOfData);

            System.out.println(Arrays.toString(partsOfData));

            Band band = getBandByName(partsOfData[bandNameIndex]);
            if (band == null) {
                band = bandGenerate(partsOfData);
            }

            Album album = getAlbumByName(partsOfData[albumNameIndex], band.getAlbums());
            if (album == null) album = albumGenerate(partsOfData, band.getId());

            Song song = songGenerate(partsOfData, album.getId());
            album.addSong(song);

        }

    }

    private String[] resizeArray(String[] data) {
        String[] newData = new String[7];
        for (int i = 0; i < 3; i++) {
            newData[i] = data[i];
            newData[newData.length - i - 1] = data[data.length - i - 1];
        }
        return newData;
    }

    private Song songGenerate(String[] partsOfData, int albumId) {
        int songNameIndex = 5;
        int songLengthIndex = 1;
        double songLength;
        String title = partsOfData[songNameIndex];
        if (partsOfData[songLengthIndex].equals("duration")) {
            songLength = ThreadLocalRandom.current().nextDouble(1.62, 4.58);

        } else {
            songLength = BandGenerator.round((Double.parseDouble(partsOfData[songLengthIndex])) / 60, 2);
        }

        return new Song(title, songLength, albumId);
    }

    private Album albumGenerate(String[] partsOfData, int bandId) {
        int genreNameIndex = 4;
        Integer releaseYear;

        String albumName = partsOfData[albumNameIndex];
        String genre = partsOfData[genreNameIndex];

        if (partsOfData[albumYearRealiseIndex].equals("year") || partsOfData[albumYearRealiseIndex].equals("0")) {
            releaseYear = null;
        } else {
            releaseYear = Integer.parseInt(partsOfData[albumYearRealiseIndex]);
        }


        return new Album(albumName, genre, releaseYear, bandId);
    }

    private Album getAlbumByName(String albumName, List<Album> albums) {

        for (Album album : albums) {
            if (album.getName().equals(albumName)) return album;
        }
        return null;
    }

    private Band getBandByName(String bandName) {
        for (Band band : Band.getBandList()) {
            if (band.getBandName().equals(bandName)) return band;
        }
        return null;
    }

    private Band bandGenerate(String[] partsOfData) {
        int countryIndex = 2;

        String bandName = partsOfData[bandNameIndex];
        String country = (partsOfData[countryIndex].equals("Not available")) ? ("") : partsOfData[countryIndex]; //because we dont want not avaible in database
        int randomStartYear = getRandomStartYearBasingOnSongRelease(partsOfData[albumYearRealiseIndex]);
        int randomEndYear = getRandomEndYearBasingOnSongRelease(partsOfData[albumYearRealiseIndex], randomStartYear);

        return new Band(bandName, country, randomStartYear, randomEndYear);
    }

    private int getRandomStartYearBasingOnSongRelease(String songReleaseYear) {
        if (songReleaseYear.equals("0") || songReleaseYear.equals("year")) {
            return ThreadLocalRandom.current().nextInt(1948, 2018);
        }
        return ThreadLocalRandom.current().nextInt(Integer.parseInt(songReleaseYear) - 20, Integer.parseInt(songReleaseYear + 30));
    }

    private int getRandomEndYearBasingOnSongRelease(String songReleaseDate, int startYearBand) {
        if (songReleaseDate.equals("0") || songReleaseDate.equals("year")) {
            return ThreadLocalRandom.current().nextInt(startYearBand, startYearBand + 50);
        }
        int endOfRange = (Integer.parseInt(songReleaseDate) - startYearBand);
        return ThreadLocalRandom.current().nextInt(Integer.parseInt(songReleaseDate), Integer.parseInt(songReleaseDate) - endOfRange);
    }

    public static double round(double number, int scale) {
        int pow = 10;
        for (int i = 1; i < scale; i++)
            pow *= 10;
        double tmp = number * pow;
        return ((double) ((int) ((tmp - (int) tmp) >= 0.5f ? tmp + 1 : tmp))) / pow;
    }

}
