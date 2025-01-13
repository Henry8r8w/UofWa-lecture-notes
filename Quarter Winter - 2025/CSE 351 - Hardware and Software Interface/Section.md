### Section 1   
**Compilation Options**
gcc -Wall -g -std=c18 -o foo foo.c
- `-W` turns on compiler warnings (all of them)
- `-g`turns on debugging symbols
- `-std = cXX` specifies which “standard” of C we are using
- `-o` (aka. outfile) changes the name of the resulting executable (e.g., foo)
- `foo.c` is the source file being compiled

**C Workflow**
1. Edit source file(s) 
    - .c and .h
2. Build executable
    - compiler (e.g. gcc), .exe
3. Run process
    - Command line (e.g., ./<exe>)
**printf**
int printf(const char* format, ... );
- First parameter is a format string, which contains format specifiers
- Format specifier: a % symbol followed by a combination of letters 
and/or numbers that indicates a certain type of data

Common format specifiers:
- %d for signed integers
- %u for unsigned integers
- %f for floating point numbers
- %s for "string"
- %x for hexadecimal
- %p for pointer

example:
int x = 1;
int y = 2;
printf(“I have two numbers: %d, %d”, x, y);
Output:
“I have two numbers: 1, 2”

**Java vs. C Quick Comparison**

Java:
```java
public class Main {
    public static void main(String[] args) {
        int x = 1;
   while (x < 10) {
       if (x % 2 == 0) {
      x += 1;
  } else {
      x += 3;
  }
   }
    }
}
```

C:
```c
int main(int argc, char** argv) {m  //(int command_argument, char** argument_vector)
    int x = 1;
    while (x < 10) {
        if (x % 2 == 0) {
       x += 1;
   } else {
  x += 3;
   }
    }
    return 0;
}
// note: * denotes a poiner to the string, int, or char etc value addresses, which is why it makes sense that ** denotes a pionter to an array address
```


**Editing files**
Helpful Vim commands:
- vim <file> open file (creates one if it does not exist)
    - i enter insert mode
        - Can edit files like normal
- :w save file
- :q! quit without saving
- :wq or :x save and quit
- esc to exit current mode

**Pro Tips**
up/down arrows: search for recently used prompts

ctrl-R: search for prompts you may have used a long 
time ago by keyword

tab complete: complete a long file/directory name 
automatically

**Using the terminal**

- mkdir <directory> makes a directory with the given name
- touch <file> makes a file with the given name
- rm <file> deletes file
- rm -r <directory> delete directory and all other files or directories in it (⚠ be 
careful ⚠)
- ./<exe> runs an executable

