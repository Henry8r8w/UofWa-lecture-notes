### HW1 
log in to your ssh usernetid@calgary.cs.washington.edu
git archive --remote=git@gitlab.cs.washington.edu:cse391/25wi/lectures.git --prefix=lec1/ HEAD:1/ | tar -x

### Vim basics

| Key stroke | Description                          |
|------------|--------------------------------------|
| :w         | Write (save) the current file       |
| :wq        | Write (save) the current file and exit |
| :q!        | Quit, ignoring all changes          |
| i          | Go into insert mode                 |
| Esc        | Go back to normal mode              |
| h j k l    | Move cursor left, down, up, right   |
| u          | Undo last change                    |
| x          | Delete character                    |


Difference between insert mode and normal mode
- Normal: view and command only, Esc then q to exit
- Insert Mode: a for append to move the cursor after current character, 0 insert a new line below current line 


Visual Mode
- press v
    - `<c-v>` to enter visual block mode
- block-visual: `<ctrl> +v`
- linewise-visual: `<shift>+v`

### File Commands
directory: cp
- description: copy a file

directory: mv
- description: move a file (or rename a file)
```
mv [options(s)] [source_file_name(s)] [Destination_file_name]
```

directory: touch
- description: create empty file, or change time-modified
### Unix File system conventions

| Directory   | Description                            |
|-------------|----------------------------------------|
| /           | Root directory that contains all directories |
| /bin        | Applications/programs (i.e. binaries) |
| /dev        | Hardware devices                      |
| /etc        | Configuration files                   |
| /home       | Contains user’s home directories      |
| /proc       | Running programs (processes)          |
| /tmp, /var  | Temporary files                       |
| /usr        | Universal system resources            |



### Relative Directories
directory: ~username
- description: username' home directory

directory: ~/Desktop
- description: Your desktop


### Basic Shell Commands
command: date 
- description: output system date
command: cal -  
- description: output a text calender

command: uname
-description: print information about the current system
### Anatomy of a Command
```
$ ls -al dir1 (command: list -flag:all argument:directory1)
```

### Why Unix & Linux
-  light weight program solve big problems
- multiple user permission
- hierarchial file system (recursive order)
- documentation is within the software
    - other keywords: shell scripts, coroutines, pipelines, regular expressions

- One of the most deployed os in the world
    - macOS & iOS (Unix -> BSD -> FreeBSD -> Darwin)
    - Android (uses Linux kernel)
    - Linux “distributions”, like Ubuntu, Debian, Arch, Red Hat, and Amazon Linux
    - (and integrated with Windows via WSL)

