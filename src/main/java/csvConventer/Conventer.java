package csvConventer;

import java.io.IOException;
import java.util.List;

public class Conventer {

    public static void main(String[] args) throws IOException {
        Conventer conventer = new Conventer();
        CSVParser csvParser = new CSVParser();
        List<String> musicData = csvParser.parseCSVtoString("bands.csv");

    }

    public void splitStringToProperData(List<String> musicData){
        for(String data: musicData){

        }

    }
}
