
### Debugger
- GBD gui will be used
- the C and x86-64 assembly will be the new languages to learn

Refer to this page for debugging tips: https://courses.cs.washington.edu/courses/cse351/25wi/debug/

### Executing
./ to the file that you want to execute

Execution Output
- you can do by having the > keyword to store the execution
    - ./execution1 > store.txt
- you can see the output with less command in page-by-page format
    - ./execution1 | less
    - you exist by pressing Q
### Makefiles
make filename
- make sure you do `make clean` before `make` again to restart the compilation process

### Compiliing
- gcc C compilter will be used
    - after every edit on the source code, one will need to recomple to see the change executable

terminal program tend to auto store a command history, making you to access previous command can be done by pressing Up and Down keys

### Editing
emac or vim
- choose vim 
    - and refer to this: https://courses.cs.washington.edu/courses/cse351/25wi/editors/ or Text User Interface Editor_Vim.md
### Changing Shell
- to check your shell: echo $0

Normally, when you open up a terminal, your shell (bash) is a temporraly file

To get yourself a permanent shell, you'll have to do some commands
- chsh -s /bin/bash
    - chsh: change shell 
### Transferring Files Remotely
scp: A shell command of the form scp <source> <destination>
    - FileZilla: GUI version of scp that allows for drag-and-drop and limited remote file system manipulation (e.g., file renaming, file deletion, file permissions, directory creation). Works on all platforms (Windows, MacOS, Linux).

File Download
wget<URL>
- more information: 
### Basic Unix Commands
man <command> allows access to full documentaion pertain to the command

| Command    | Function                                                    | Example         | Explanation                                                                                  | Notes                                                                                                                                          |
|------------|-------------------------------------------------------------|-----------------|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| `mkdir`    | Creates a new directory with the given name in the current working directory. | `mkdir lab1`    | This will create a new directory called "lab1".                                              |                                                                                                                                                 |
| `ls`       | Lists all directories and files in the current directory.   | `ls -A`         | This will list all sub-directories and files. The `-A` flag means that hidden directories and files will also be printed to the console. | Check the manual page for `ls` to find out various flags to show directories and files in different forms.                                      |
| `cd`       | Navigates to the specified directory, given its relative path. | `cd lab1`       | This will navigate to the `lab1` directory inside the current directory.                     | This is a common place where `.` and `..` are used. Also, to use a directory's absolute path, start the directory name with either `/` or `~`. For example: `cd ~/cse351/lab2` |
| `pwd`      | Prints the current working directory path.                  | `pwd`           | This will print the current working directory's absolute path to the console.                |                                                                                                                                                 |
| `exit`     | Exits the console, or logs out of the current SSH session.  | `exit`          | This will terminate the current terminal window. If you are SSH'd into a TTY, this will terminate your session. |                                                                                                                                                 |


### Shell Basics
/- root directory
~ - home directory 

. - current/present working directory
.. - parent directory
### Terminal and Shell Access
Use bash or puTTy (a lightweight SSH client; install needed) for window to make the ssh connection

Use terminal for linux

To log in:
- type ssh <my uw netid>@calgary.cs.washington.edu
- type the netid password, then yes to the prompt

Terminology
- A shell is a program that processes (textual) commands through the operating system and returns the output. This is the piece that "does the work".

- A terminal is a wrapper program that runs a shell. It is primarily responsible for handling the user text input and displaying the output from the shell. This is one example of a command-line interface (CLI).