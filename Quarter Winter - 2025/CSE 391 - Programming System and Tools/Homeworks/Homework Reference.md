


## Hw2 - More Unix Commands

**Task 1: Vim Navigation**

In vim, open `intro_survey.csv` and answer the following questions in `task1.txt`.

1. What is the command to move your cursor to the end of the file?
2. What is the command to move your cursor back up to the beginning of the file?
3. What is the command to move to line 50 of the file? Practice moving around to different lines in the file. You may notice that vim does not show line numbers of a file by default but you can enable line numbers. While it’s not required that you look this up, you may find it helpful.
4. What is the command to search for the text “chocolate”?
5. What is the command to go to the next match from your search?

While the answers to the questions themselves are relatively easy to find by simply looking them up, the real learning will come from you actually practicing these commands yourself. We also recommend getting even more practice by writing the answers to your `task1.txt` and `task2.sh` files using vim!

**Task 2: Bash Commands**

For this task, we will compose shell commands with input/output redirection operators such as `>`, `<`, and `|` to perform more complicated data analyses of `intro_survey.csv`. For each problem below, determine a single bash statement that will either perform the operation(s) requested or answer the given question.

Write your answers on the indicated lines in the `task2.sh` file in the `hw2` folder.

1. Compile the Java file `ParseColumn.java`.
2. Assuming `ParseColumn` has already been compiled, run `ParseColumn` to parse `intro_survey.csv` and output only the answers to “What’s your favorite candy?” and write the output to a file called `candies.txt`. The `ParseColumn` program takes a column number (1-indexed) as a command-line argument, reads a CSV file from stdin, and outputs only the specified column in the CSV file.
3. Given a list of `candies.txt`, output only the lines that include the text “chocolate” (ignoring case).
4. Given a list of `candies.txt`, output only the lines that do not include the text “chocolate” (ignoring case). Your answer should include the CSV header, “What’s your favorite candy?”
5. Create a new file called `intro_survey_no_header.csv` containing all the contents of `intro_survey.csv` except for the first line (the CSV header), “What’s your favorite candy?” Write your command in a general way so that it works regardless of the specific data in `intro_survey.csv` using the `head` or `tail` commands.
6. Assuming the `intro_survey_no_header.csv` lists responses from oldest to newest, output the favorite dinner of the newest survey submission.
7. How many students completed the survey? Write a command that outputs a string with both the number and the name of the file separated by a space: `[number] intro_survey_no_header.csv`.
8. How many students in the course are not also taking CSE 351? Since the answers to the question, “Are you currently enrolled in CSE 351?” are “Yes” and “No”, you won’t be able to simply `grep` `intro_survey.csv` for “No” as it may appear as part of answers to other questions.
9. How many unique answers (ignoring case) are there to the question, “What’s your favorite candy?” Don’t worry right now about the difference between answers like “kit kat” and “kitkat”, but your solution should count “kitkat” and “KITKAT” as the same. Be careful that the header “What’s your favorite candy?” is not counted.





## Hw1 - Basic Unix Shell Commands

**Task1: log in to calgary server**
- open terminal
- set up ssh key for CSE gitlab

**Task 2: Downaload homework files on calgary**
- mkdir cse391
- cd cse391
- use the following command to grab the homeowrk files: `git archive --remote=git@gitlab.cs.washington.edu:cse391/25wi/hw1.git --prefix=hw1/ HEAD | tar -x`

**Task 3: Edit text in the terminal using vim**

Refer to task3.txt

1.From the hw1 directory, how do you open animals.txt in vim?

2.Practice moving your cursor around the file. Move your cursor up, down, left and right. Assuming your cursor is at the beginning of the first line of the file, what are the keystrokes to move your cursor to the end of the line and append the text "animal"?

3.Next, what are the keystrokes to move your cursor back to the front of the line and insert the word "animal"?

4.How do you save your changes to the file?
5.How do you exit the file and return back to your command line prompt in the shell?


**Task4: Linux Bash Shell commands**

Refer to task4.sh

1. Copy the file MyProgram.java from the current directory to the java subdirectory.
2. List the files in the current directory, in “long listing format”.
3. List all files, including hidden files, in the /var directory, in reverse alphabetical order and long listing format. (Notice the slash in the directory!)
4. Rename the file Burrot.java to Borat.java. Renaming is done using the same command as moving.
5. Delete the files diff.html and diff.css. Remember that many commands can accept more than one parameter.
6. Set the file MyProgram.java to have a last-modified date of January 1, 2020, 4:15am. When consulting the man page for touch, the last-modified date is often called a “timestamp” or “STAMP”. Remember that Linux is case-sensitive when you are specifying file or directory names.
7. List all files with the extension .html or .css in the current directory. The ls command can accept more than one parameter for listing files. Use a * (asterisk) as a wildcard character to specify a group of files. For example, *foo means all files whose names end with foo, and foo* means all files whose names begin with foo. You can use a wildcard in the middle of a file name, such as foo*bar for all files that start with foo and end with bar.
8. Copy all text files (ending with .txt) from the current folder to the java subdirectory.
9. Using the diff command, output the differences between lyrics.txt and lyrics2.txt. Note that line differences from the first file argument begin with a left-pointing caret < and line differences from the second file argument begin with a right-pointing caret >. The autograder is picky about the order you provide lyrics.txt and lyrics2.txt to the diff command.
10. Display the contents of the file lyrics.txt.
11. Display the contents of all files whose names begin with song and end with the extension .txt (e.g., song1.txt and song2.txt).
12. Display only the first 7 lines of the file animals.txt. The head and tail commands output only the first or last few lines (respectively) of a file to the terminal.
