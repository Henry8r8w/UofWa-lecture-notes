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
