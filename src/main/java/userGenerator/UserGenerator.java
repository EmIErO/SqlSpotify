package userGenerator;

import net.andreinc.mockneat.MockNeat;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

public class UserGenerator {

    private static List<String> uniqueMail = new ArrayList<>();
    private static List<String> uniqueLogin = new ArrayList<>();
    private static int countRepeatMail = 0;
    private static int countRepeatLogin = 0;
    private MockNeat mock = MockNeat.threadLocal();


    public void generateUsers() throws FileNotFoundException {

        PrintWriter pw = new PrintWriter(new File("accounts500kUsers.csv"));
        StringBuilder sb = new StringBuilder();

        long startTime = System.currentTimeMillis();
        for (int i = 0; i <500000; i++) {
            sb.append(getUniqueLogin()).append(",");
            sb.append(getPassword()).append(",");
            String firstName = mock.names().first().val();
            sb.append(firstName).append(",");
            sb.append(mock.names().last().val()).append(",");
            sb.append(getGenderByFirstName(firstName)).append(",");
            sb.append(generateUniqueMail());
            sb.append("\n");
        }
        sb.setLength(sb.length() - 1);
        pw.write(sb.toString());
        pw.close();
        long endTime = System.currentTimeMillis();
        System.out.println("Total execution time: " + (endTime - startTime) + "ms");
        System.out.println("Repeat mails: " + countRepeatMail);
        System.out.println("Repeat logins: " + countRepeatLogin);
    }

    private String getGenderByFirstName(String name){
        int lastLetterIndex = name.length() - 1;
        if(name.substring(lastLetterIndex).equals("a")) {
            return "female";
        }return "male";
    }

    private String generateUniqueMail() {
        String email = String.valueOf(mock.emails().val());
        while (uniqueMail.contains(email)) {
            countRepeatMail++;
            email = String.valueOf(mock.emails().val());
        }
        uniqueMail.add(email);
        return email;
    }

    //int randomNum = ThreadLocalRandom.current().nextInt(min, max + 1);  +1 if we want inclusive max and min
    private String getUniqueLogin() {
        int randomLoginLength = ThreadLocalRandom.current().nextInt(6, 25 + 1);
        String login = generateUniqueLogin(randomLoginLength);

        while (uniqueLogin.contains(login)) {
            countRepeatLogin++;
            randomLoginLength = ThreadLocalRandom.current().nextInt(6, 25 + 1);
            login = generateUniqueLogin(randomLoginLength);
        }

        uniqueLogin.add(login);
        return login;
    }

    private String generateUniqueLogin(int loginLength) {
        int randomChar = ThreadLocalRandom.current().nextInt(97, 122 + 1);
        StringBuilder sb = new StringBuilder();
        sb.append(((char) randomChar)); //first char always is a letter
        for (int i = 1; i < loginLength; i++) {
            int asciiIndex = getUniqueLoginPermittedAsciiIndex();
            sb.append(((char) asciiIndex));
        }
        return sb.toString();
    }

    private int getUniqueLoginPermittedAsciiIndex() {
        int letterOrNumber = ThreadLocalRandom.current().nextInt(0, 1 + 1);
        if (letterOrNumber == 1) {
            return ThreadLocalRandom.current().nextInt(97, 122 + 1);
        }
        return ThreadLocalRandom.current().nextInt(48, 57 + 1);
    }


    private String getPassword() {
        int randomPasswordLength = ThreadLocalRandom.current().nextInt(6, 33 + 1);
        return generatePassword(randomPasswordLength);
    }

    private String generatePassword(int loginLength) {
        StringBuilder sb = new StringBuilder();

        for (int i = 1; i < loginLength; i++) {
            char randomChar = getPasswordPermittedChar();
            sb.append(randomChar);
        }
        return sb.toString();
    }

    private char getPasswordPermittedChar() {
        int randomPasswordCharIndex = ThreadLocalRandom.current().nextInt(48, 122 + 1);
        char randomChar = (char) randomPasswordCharIndex;
        while (randomChar == ':' || randomChar == ';' || randomChar == ',') {
            randomPasswordCharIndex = ThreadLocalRandom.current().nextInt(48, 122 + 1);
            randomChar = (char) randomPasswordCharIndex;
        }
        return randomChar;
    }
}
