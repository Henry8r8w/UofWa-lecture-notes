## Demo
```
// say you retook a class (spring, summer 2025) and you want to compare the difference in the materials

echo diff 25s{p,u}/materials // you can also use comparison tools on your editor (vscode)

// To debug your autograder result from gradescope
ssh autgrader_enviroment 
- it's in an isolated container

// To get yourself into the parent folder when lost
cd ~ or cd

// Say, you have a Hello World folder created by mkdir "Hello Word" and you want to access it
cd Hello\ World or cd 'Hello World'

// To remove duplicate, you always need to sort beforehand
sort | uniq

// to word count everything, including the hidden files
ls -al .. | wc -l

```
HW2 tips
- use echo, cat command to see your arguments/ file contnets
- If infty loop encouneted, check your stdin

git archive --remote=git@gitlab.cs.washington.edu:cse391/25wi/lectures.git --prefix=lec3/ HEAD:3/ | tar -x

note: tar archive format need to be unarchive by tar, which unzip line by line (instea of reading the whole file before 'unzip')


Question: what is difference between grep "a" letters.txt and cat letters.txt | grep "a"

- There is a no differnece in the result, but the process is difference: grep opens a file and read its content and highlight the "searchword", so using a pipe for the grep, you are essentially getting a stdin for the grep and the grep reads inputs that are presented and not opening any file

## Pipes
- unlike IO redirection, command < file/ command > file, we use command | command
- ex.  grep "berry" fruits.txt | wc -l
    - this would get us the word count of thethe items containing 'berry' 
note: it's common to have the second pipe command overwrite the first one; to use pipe, you always need a standard input
```
grep "a" berries.txt | grep "e" berries.txt // nope, this only give us items with e in berries, which is all

grep "a" berries.txt | grep "e" // yes, becuase our grep 'e' receive standard input from the first one; so we filtered out berries items with a and e letter
```
- if you used > in the case of grep "e", it is to say taht you'r asking the output of grep "a" berries.txt to write a file named grep and "e"

Say, we want to count berries but we know that there are defintely duplicates, what do we do 
```
sort berrties.txt |uniq| wc -l // use uniq command
```
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

#TODO: this std io vs param still need soem reenforcement

## More Unix commands
- it is always a good practice to use `clear` to clean your terminal look

`cat` command is also availble for one trying to pass-in a path, where you will see the concatenate result of what it inside the directory

`head` gives you the first ten items of the file
- use `-n #` to specify the first # number of the items you want to cat
`tail` gives you the last ten items of the file
- use `-n #` to specify the last # number of the items you want to cat

- use `/worsdyouwanttosearch` to have a ctrl f like search inside a file

- use `less` file.txt, you can view a large file both forward and backward; `more` is less better than less, for it is slower

- `wc` (word count) prints line, words counts, character counts/ bytes, filename.ending
    - flag: -l will allow you only display the word count
- 'sort' filepath, you can sorts items in the file

- `grep` allows you search specific phrases
    - ex. grep 'wordtosearch' filepath1 filepath2 with exact match
    - ex. as it is common to write TODO in your programs, one may use grep in such way --- grep "TODO" project/*
        - note: * wildcard allows use to select of any file that is under the project folder
- To compile a java file in unix enviroment: javac -o run_name, then run it with java run_name

## Vim editing tips/notes
- right bottom #,# gives you infor of your cursor location (row, col)
- when you're in vim, use `:e somefile.txt `to open the somefile to edit
    - `vim newfile.txt` when creating a newfile and start editing
**navigation**
- b to press back an entire word
- w to press forward an entire word
- 0 to press to row 0
- shift 4 to press to get the end of the line

**insertion/editing**
- a to press to append
- . to repeat last insetion, whereas u to undo the last insertion you did