### Hw1 - Basic Unix Shell Commands

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
9.Using the diff command, output the differences between lyrics.txt and lyrics2.txt. Note that line differences from the first file argument begin with a left-pointing caret < and line differences from the second file argument begin with a right-pointing caret >. The autograder is picky about the order you provide lyrics.txt and lyrics2.txt to the diff command.
10.Display the contents of the file lyrics.txt.
11.Display the contents of all files whose names begin with song and end with the extension .txt (e.g., song1.txt and song2.txt).
12.Display only the first 7 lines of the file animals.txt. The head and tail commands output only the first or last few lines (respectively) of a file to the terminal.
