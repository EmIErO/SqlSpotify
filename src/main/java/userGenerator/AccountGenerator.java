package userGenerator;

import java.io.FileNotFoundException;

public class AccountGenerator {

    public static void main(String[] args) throws FileNotFoundException {
        UserGenerator generator = new UserGenerator();
        generator.generateUsers();
    }
}
