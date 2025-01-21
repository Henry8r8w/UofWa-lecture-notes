


### Choosing the right tool for the join
1. find -name "*.java" | wc -l
2. find -name "*.java" |xarg wc -l
3. 
4. 

debugging tip:
find - name "*.java" | grep "public class"
- see what your output of your smaller operators
    - find - name "*.java" ; saw all the java files
    - find - name "*.java" | grep "java"
        - ah, you are grepping just your java files


### xarg
- writes lines into stdin, program argument

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