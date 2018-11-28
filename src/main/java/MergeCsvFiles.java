import csvConventer.Conventer;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class MergeCsvFiles {

    public static void main(String[] args) throws IOException {
        String firstFile = "artistTable.csv";

        BufferedWriter writer = new BufferedWriter(new FileWriter(firstFile, true));

        for (int i = 1; i <= 12; i++) {
            String fileName = "MOCK_DATA(" + i + ").csv";

            Scanner scanner = new Scanner(new File(Conventer.class.getClassLoader().getResource(fileName).getFile()));

            while ((scanner.hasNext())) {
                String line = scanner.nextLine();
                writer.write(line);
                writer.write("\n");
            }

            scanner.close();
        }
        writer.close();
    }
}
