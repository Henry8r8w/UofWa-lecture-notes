## Lab 2: Disassmebling and Defusing a Binary Bomb
### Tips and Hints

**x86-64 Calling Conventions**
The x86-64 ISA passes the first six arguments to a function in the following registers (in order): %rdi, %rsi, %rdx, %rcx, %r8, and %r9. The return value of a function is passed in %rax.


Lab 2 uses sscanf ("string scan format"), which is similiar to scanf but reads in data from a string instead of stdin:
```
char* mystring = "123, 456"; // our string input
int a, b;
sscanf(mystring, "%d, %d", &a, &b); // %d our string formater (decimal) to parse the string,  and stored at location a and b 
```

**Phase Context Hints**
1. Comparison: Dr. Evil is a fan of inspiring (or not so inspiring) quotes.
2. Loops: Phase 2 calls a function, then starts a loop. What inputs are required by the function? How is the loop using those inputs?
3. Switch statements: Figure out what inputs are required. For each input, what values would cause a call to explode_bomb? Avoid those!
4. Recursion: What are the initial arguments of the recursive function? How are they manipulated before the recursive call occurs? What do we do with the final value once we exit out of the recursive function?
5.Pointers and arrays: Where are the arrays stored? What are their contents, and how are they being manipulated?
6. Linked lists (extra)
### Useful Commands
**GDB**
- `disas <function>` will display the disassembly of the specified function.
- `break <line>`, where <line> can be specified as a line number, a function name, or an instruction address, will create and set a breakpoint.
- `run defuser.txt` will run the bomb using defuser.txt as the command-line argument until it encounters a breakpoint or terminates.
- `stepi <#> ` and `nexti <#>` will move forward by <#> assembly instructions (stepi will enter functions whereas nexti will go over functions). If omitted, <#> will default to 1.
- `print /<f> <expr>`    will evaluate the expression <expr> and print out its value according to the format string <f>. The expression can use variable or register names. The format string can be omitted; see documentation for more details.

**non GDB**
- `objdump -t bomb > bomb_sym`: This will print out the bomb's symbol table into a file called bomb_sym. The symbol table includes the names of all functions and global variables in the bomb, the names of all the functions the bomb calls, and their addresses. You may learn something by looking at the function names!

- `strings -t x bomb > bomb_strings`: This will print the printable strings in your bomb and their offsets within the bomb into into a file called bomb_strings.
### Goal of the lab
Learning to read assembly code as well as gaining familiarity with the debugger, we highly recommend a mixture of the two
### Bomb description
The bomb has 5 regular phases. The 6th phase is extra, and rumor has it that a secret 7th phase exists. The phases get progressively harder to defuse, but the expertise you gain as you move from phase to phase should offset this difficulty. 
### Getting Started
GDB debugger
- gcc -g yourfile.c; first compile your c file
- gdb somefile.out; open your gdb
    - (gdb) break method_name; add break point to your method
    - (gdb) run; you run the code until the break point
        - (gdb) list; you see what the source code looks like
        - (gdb) disas; you see the assmebly code
`bomb` file will exist as a mystry file where you can gdb list it, but you probably won't see anything listed; disas won't do anything as well; but you can probe the `bomb` file using gbb break guess_method to know what methods the file contain

(gdb) step walks through every single line of the source code

(gdb) stepi; this walks thorugh line by line in the source code
- (gdb) disas; this shows you at each line of your assmebly code

**x/NUM SIZE FORMAT**
x/s $register
- you get a string representation binary

x/2wx $register
- you get the 2 num w size hex representation of binary

To check if you found the key to defuse the bomb
- ./bomb defuse.txt
    - where defuse.txt is where you put the key candidate in after inspecting the bomb file
## Lab 1a: Pointers in C

### Getting Started
wget https://courses.cs.washington.edu/courses/cse351/25wi/labs/lab1a.tar.gz
- extract using tar zxvf lab1a.tar.gz


### Checking the work
- look into Makefile
    - run make clean, then run make 
    - you should see a binary ptest file based on ptest.c and execute it to see your test outputs
`pointer.c` and `lab1Asynthesis.txt` will need to be submitted

### Lab Format
- only straight line code; no loop; check ALLOW comment under pointer.c
- >> and << can be used
- only 8 bits, 1 bytes is allowed
- sizeof is not allowed
- () and = can be used for casting if needed
- comments are not graded

### Using Pointers
**Pointer Arithmetic**
- First three functions ask one to compute size of various data elements (e.g., ints, doubles, and pointers)

**Manipulating Data Using Pointers**
- Fourth and fifth functions ask one to manipulate data
    - `swap_int`: you swap the values that two given pointers point to without changing the pointers themselves
    - `change_value`: you change the value of an element of an array using only the starting address of the array; add value to the pointer to create a new pointer to the data element to be modified; [] element access is not allowed
**Pointers and Address Ranges**
- two functions to implements

`within_same_block`: determine if the addresses store dby two pointers lie within the same block of 64-byte aligned memory

`within_array`: determine if the address stored in `ptr` is pointing to a byte that makes up some part of an array element for a passed array

**Byte Traversal**
`string_length`: return the length of a string, given a pointer to its beaning; no loop allowed

`endian_experiment`: set the value a pointer points to to the number 351351; keyword: little endian

**Selection Sort**
- Implement a selection sort
```
// "arr" is an array
// "n" is the length of arr
for i = 0 to n - 1
  minIndex = i
  for  j = i + 1 to n
    if arr[minIndex] > arr[j]
      minIndex = j
    end if
  end for
  Swap(arr[i], arr[minIndex])
end for
```
- note: you might find your previously implemented `swap_ints` useful

## Lab0: warm up & get ready with linux
To compile your c code, you will use gcc

A new command: $ gcc -g -Wall -std=c18 -o lab0 lab0.c
- `-g` tells the compiler to include debugging symbols
- `-Wall` says to print warnings (the W) for all types (the all) of potential problems
- `-std=c18` says to use the C18 standard (the C language standard released in 2018)
- `-o lab0` instructs the compiler to output the executable code to a file called lab0
- use ./ to run your lab0
### ssh and scp
- ssh: a secure porotcal to connect local machine to remote server (c:/usr/local $\to$ \[username@remotename~])
- scp:to make secure copy of file between sever and local machine
    - At  local machine (remote files -> local machine): scp username@remotename:filepath /local/machine/filepath
        - /local/machine/filepath: . copies to cwd (or ./subfolder), .. copies to pd, else specifies your absolute path
    - At your local machine (local files -> remote server): scp /local/machine/filepath username@remotename:fielpath

### The File System as an Organization Tool
- File system is oganized in a tree 
- Directory (aka. folder)  can have any number of folders (recursive) and files
    - files are entites that contatin data (comes in many forms: .txt, .csv, .java, .c, etc.)
- absolute path vs. relative path
    - absolute: the path of accessing a file more specified path (more flexible) (~/someshell.sh)
    - relative: the path of accessing a file within current working directory (someshell.sh)

Let's say you have a Root ->Tools-> format_folder, Tools -> Stat_folder', Tools -> Old; Root -> Data -> one.txt, Data -> two.txt
- ../Tools/Stas refer to the relative path for Stats from the Data folder
- ../../Data/one.txt is a relative path fro One.txt from the Old folder 
    - essentially, .. allows you to go back to your parent directory and accessing relative path from there

type `tree` command in your current directory, you shoudl have a visualization of the file system tree; it is useful to help you idenfity what files are under your directory (recursive)

cd ../.. allows you change directory two parents above
- in a similar fashion, cat ../../somefile.txt allow you to go to the somefile and concatenate the result for display

Additional Reading: https://cplusplus.com/reference/cstdio/printf/
