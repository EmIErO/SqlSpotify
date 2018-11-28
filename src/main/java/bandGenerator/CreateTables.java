package bandGenerator;

import bandGenerator.BandGenerator;
import bandGenerator.csvConventer.CSVCreator;
import bandGenerator.csvConventer.CSVParser;

import java.io.IOException;
import java.util.List;

public class CreateTables {

    public static void main(String[] args) throws IOException {
        CSVParser csvParser = new CSVParser();
        CSVCreator csvCreator = new CSVCreator();
        List<String> musicData = csvParser.parseCSVtoString("bands.csv");
        BandGenerator bandGenerator = new BandGenerator();
        bandGenerator.generate(musicData);
        csvCreator.createCSVdata();
    }

}
