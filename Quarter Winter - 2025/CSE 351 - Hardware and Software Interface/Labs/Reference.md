## Lab0
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
    - At the remote server: scp username@remotename:filepath /local/machine/filepath
        - /local/machine/filepath: . copies to cwd (or ./subfolder), .. copies to pd, else specifies your absolute path
    - At your local machine: scp /local/machine/filepath username@remotename:fielpath

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