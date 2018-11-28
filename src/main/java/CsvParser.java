import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import com.opencsv.CSVReader;

public class CsvParser {

    public static void main(String[] args) throws IOException{
        List<List<String>> data = new ArrayList<>();

        CsvParser parser = new CsvParser();

        try (
                Reader reader = Files.newBufferedReader(Paths.get("/home/riczard/projects/codecool/tw_projects/sqlSpotify/src/main/resources/music.csv"));
                CSVReader csvReader = new CSVReader(reader);
        ) {
            // Reading Records One by One in a String array
            String[] nextRecord;
            while ((nextRecord = csvReader.readNext()) != null) {
                List<String> line = new ArrayList<>();
                line.add(nextRecord[2]);
                line.add(nextRecord[9]);
                line.add(nextRecord[15]);
                line.add(nextRecord[21]);
                line.add(nextRecord[29]);
                line.add(nextRecord[33]);
                line.add(nextRecord[34]);
                data.add(line);
            }
        }catch (IOException e){
            e.printStackTrace();
        }

        parser.createCsv(data);

        for(List<String> x : data){
            System.out.println("\n");
            for(String y : x){
                System.out.print(y + ", ");
            }
        }
    }


    public void createCsv (List<List<String>> data) throws IOException{
        PrintWriter pw = new PrintWriter(new File("bands.csv"));
        for(List<String> line : data){
            StringBuilder sb = new StringBuilder();
            for(String information : line){
                sb.append(information);
                sb.append(",");
            }
            sb.setLength(sb.length() - 1);
            sb.append("\n");
            pw.write(sb.toString());
        }
        pw.close();
    }


}
