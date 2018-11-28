import java.io.*;
import java.util.ArrayList;

public class MergeCsvFiles {

    public static void main(String[] args) throws IOException {
        String firstFile = "/home/riczard/projects/codecool/tw_projects/sqlSpotify/src/main/resources/artistTable.csv";

        BufferedWriter writer = new BufferedWriter(new FileWriter(firstFile, true));

        String fileToAdd = "MOCK_DATA";

        for(int i = 1; i <= 10 ; i++) {
            String fileName = "/home/riczard/projects/codecool/tw_projects/sqlSpotify/src/main/resources/MOCK_DATA(" + i + ").csv";
            BufferedReader reader = new BufferedReader(new FileReader(fileName));

            String line = null;
            String[] firstLine = null;
            if ((line = reader.readLine()) != null)
                firstLine = line.split(",");


            while ((line = reader.readLine()) != null) {
                writer.write(line);
                writer.newLine();
            }

            reader.close();
        }
        writer.close();
    }
}
