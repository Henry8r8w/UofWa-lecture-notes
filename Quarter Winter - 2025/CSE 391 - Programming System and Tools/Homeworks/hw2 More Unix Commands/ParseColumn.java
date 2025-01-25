import java.util.*;

// This program takes a column index (1-based) as a command-line argument, reads a CSV file
// containing a header from stdin, and outputs the selected column to stdout.
public class ParseColumn {
  public static void main(String[] args) {
    if (args.length < 1) {
      usage();
      return;
    }

    int columnIndex;
    try {
      columnIndex = Integer.parseInt(args[0]) - 1;
    } catch (NumberFormatException e) {
      usage();
      return;
    }

    Scanner input = new Scanner(System.in);
    input.useDelimiter("\n");

    int lineCount = 0;
    while (input.hasNextLine()) {
      lineCount++;
      String line = input.nextLine();
      List<String> columnsList = new ArrayList<>();
      int numQuot = 0;
      StringBuilder curr = new StringBuilder();
      for (int i = 0; i < line.length(); i++) {
        char c = line.charAt(i);
        if (c == '"') {
          numQuot++;
        } else if (numQuot % 2 == 0) {
          if (c == ',') {
            columnsList.add(curr.toString());
            curr.setLength(0);
          } else {
            curr.append(c);
          }
        } else {
          curr.append(c);
        }
      }
      columnsList.add(curr.toString());
      String[] columns = columnsList.toArray(new String[0]);
      if (columns.length > columnIndex) {
        System.out.println(columns[columnIndex]);
      } else {
        throw new IndexOutOfBoundsException(
            "Invalid column index " + (columnIndex + 1) + " for input on line " + lineCount + " (1-indexed)");

      }
    }

  }

  // Prints out the correct usage of this java program.
  public static void usage() {
    System.err.println("Usage: java ParseColumn <column-index>");
    System.err.println("    A 1-based index for the desired column is required");
  }
}
