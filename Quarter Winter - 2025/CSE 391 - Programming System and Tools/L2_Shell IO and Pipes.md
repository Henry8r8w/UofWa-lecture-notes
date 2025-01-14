
---
## Input and Output Redirection
**Standard Streams**
- stdin (input), stdout (output), stderr (error)
    - the java correspondance: System.in, System.out, System.err
 
stdin -> Process(a program s.a ls, cd, or grep) -> stdout, stderr

Let's say we have a txt files containing all the fuirts name, and we want just the berry; how can we store that infroamtion somewhere isolated? (aka. output redirection)
- grep "berry" fruits.txt > berry.txt
- now, anything items that contain the berry string will be stored inside a newly created berry.

To do input redirection, you can just ue <; let's use an exmaple of a javac-ed HelloWorld.java
- java HelloWorld < userinfo.txt
    - this is a powerful tool

```java
import java.util.*
public class HellowWorld{
    public static void main(String[] args){
        System.out.println("Welcome to the best program ever!");

        Scanner input = new Scanner(System.in);
        System.out.println("Enter your name:");
        String username = input.nextline();
        System.out.println("Enter your password:");
        String password = input.nextLine();
        System.out.println("Hello, "+ username);
        System.out.println("Your password is" + passowrd+ ". You've been hacked!")
    }
}
```
- notice how you should expect the username and password be the head -n 2 of your userinfo.txt


One thing one might want to do while compiling a program in bash is to save-keep error
- with command of 2 >, you can save your error message into an .err file
    - javac Err_HelloWorld.java 2> errors.err

Note: input/output redirection (<, >) can overwirte existing file 

If you want to do append instead of overwritting, you will use >> and << instead

**Stdin/out vs. parameters**
- your parameters are the ones that comes as your arguments
- your input comes as file

Refer to SimpleGrep.java for for tryout to see the difference
## More Unix commands
- it is always a good practice to use `clear` to clean your terminal look

`cat` command is also availble for one trying to pass-in a path, where you will see the concatenate result of what it inside the directory

`head` gives you the first ten items of the file
- use `-n #` to specify the first # number of the items you want to cat
`tail` gives you the last ten items of the file
- use `-n #` to specify the last # number of the items you want to cat

- use `/worsdyouwanttosearch` to have a ctrl f like search inside a file

- use `less` file.txt, you can view a large file both forward and backward; `more` is less better than less, for it is slower

- `wc` prints line, words counts, character counts/ bytes, filename.ending
    - flag: -l will allow you only display the word count
- 'sort' filepath, you can sorts items in the file

- `grep` allows you search specific phrases
    - ex. grep 'wordtosearch' filepath1 filepath2 with exact match
    - ex. as it is common to write TODO in your programs, one may use grep in such way --- grep "TODO" project/*
        - note: * wildcard allows use to select of any file that is under the project folder
- To compile a java file in unix enviroment: javac -o run_name, then run it with java run_name
