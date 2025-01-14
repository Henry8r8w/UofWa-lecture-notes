// Example program to show how grep is implemented.
// This is a very simple version of grep and doesn't have
// any of their fancy features.
//
// Usage: java SimpleGrep [pattern] [file ...]
//
// If files are not passed as arguments, accepts input from stdin.

import java.io.*;
import java.util.*;

public class SimpleGrep {
    public static void main(String[] args) throws FileNotFoundException {
        if (args.length < 1) {
            throw new IllegalArgumentException("See man page for documentation");
        }

        String pattern = args[0];
        if (args.length == 1) {
            // Read from stdin if no file names are passed
            Scanner input = new Scanner(System.in);
            grep(pattern, input);
        } else {
            // Search through each of the files passed in
            for (int i = 1; i < args.length; i++) {
                String fileName = args[i];

                System.out.println("Results for: " + fileName);

                Scanner input = new Scanner(new File(fileName));
                grep(pattern, input);

                System.out.println();
            }
        }
    }

    // Searches through input (file or standard in) for the given pattern.
    // Any lines that contain the given pattern at least once are printed to the standard out.
    public static void grep(String pattern, Scanner input) {
        while (input.hasNextLine()) {
            String line = input.nextLine();
            if (line.contains(pattern)) {
                System.out.println(line); 
            }
        }
    }
}
