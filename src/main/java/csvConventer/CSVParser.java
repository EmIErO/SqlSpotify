package csvConventer;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class CSVParser {

    public List<String> parseCSVtoString(String fileName) throws IOException {

        List<String> musicData = new ArrayList<>();

        Scanner scanner = new Scanner(new File(Conventer.class.getClassLoader().getResource(fileName).getFile()));

        while (scanner.hasNext()){
            musicData.add(scanner.nextLine());
        }

        return musicData;
    }


}
