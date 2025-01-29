## In Lecture-Notes
### Choosing the right tool for the join
1.Find "public class" in .java files in the current folder
2.Find "public class" in .java files in the current folder and subfolders
3.Calculate line count for .java files in the current folder
4. Calculate line count for .java files in the current folder and subfolders

1. grep "public class" *.java
2. find -name "*.java" | xargs grep "public class"
3. wc -l *.java
    - note: find -name "*.java" | wc -l only count number of java files in the deepest folder based on the find -name output ordering
4. find -name "*.java" |xargs wc -l


grep "public class" *.java
- output:
    - program1.java: public class P1{
    - program2.java: public class P2{
    - program3.java: public class P3{

However, find - name "*.java" | grep "public class" will not give you the result when you seek in subdir as well

debugging tip:
find - name "*.java" | grep "public class"
- see what your output of your smaller operators
    - find - name "*.java" ; saw all the java files
    - find - name "*.java" | grep "java"
        - ah, you are grepping just your java files



### xarg
- writes lines from stdin into program argument

### Review and Summarize L2
grep 
- can access a file; ex. grep 'a' file.txt
- can take in a stdin from pipe; cat file.txt| grep 'a'

**Reference guide**
command|command
command < file > file
(command < file )|command
(command < file) | command > file
- where > and < are you passing file into the command

https://explainshell.com/

Difference between pipe and redirection
- pipe takes in stdinput from the output of another command
- redirection writes in a file to a command or writes the ouput of command into another file

## Pre-Lecture Videos
### cut and parsing logs
echo "abcdef" | cut -c4
- output (character 4 of the stdinpt): d

echo "abcdef" | cut -c4-6
- output (character 4-6 of the stdinpt): def

echo "abcdef" | cut -c1, 3, 5
 - output (character 1,3,5 of the stdinpt): ace

echo "a,b,c,d,e,f" | cut -d -f 5
- output (1st char of the delimited stdinpt): a

cut option:
- -d, which denotes delimiter; only single character
- -f#, which denotes the field #

### find and xargs
Say, we have some java files, and we want to compile all of them within our current directory
- ls *.java | javac
    - pipe did not work in this scenarios
    - Why? javac does not takes standard input from ls; javac only takes in argument
Let's say we use input redirection and gets us a txt file and use it as an arguments for java c
- ls*.java > toCompile.txt
- javac< toCompile.txt
    - nope, this still will not work
Here, we introduce the `xarg` command 
- xargs javac < toCompile.txt
    - you expect .class files to appear in your directory

`xargs` reads stream of data as standard input and output them as arguments for a command


Let's say you have the java files in different subdirectories under your current directory
- `find` -name "*.java"

And you can  compile them

- `find` -name "*.java" | xargs javac

Question to think: to remove multiple files given a toRemove.txt, what do you do
- xargs rm < toRemove.txt
    - redirect the txt file to get each line streamed and interpret as argument for rm command
- cat toRemove.txt | xargs rm
    - get a stdin to xargs to convert to arguments for remove command
- rm $(find - name "*.java"), a stackoverflow solution
    - $() is a command substitution, in which it also create arguments for rm 
### More shell operators
Pipe:
- command1| command2
    - run command1 and send the standard input to command2
&&:
- command1&&command2
    - run command2 only if command1 can compile
    - ex. javac HelloWorld.java && java HelloWorld
    - ex. cd dir1 && ls
|| (or):
- command1 && command2
    - run command2 only if command1 fails

;:
- command1; command2
    - run command1 and command2 continuously yet independently
        - ex.ls dir1; ls dir2