## Section 5: Procedures 
### Stack Frame Example
Consider the following lines of code
```
int main(int argc, char* argv[]) {
 int x = 351;
 int a[] = {1, 2, 3};
 int y = foo(&x, 2, 3, 4, 5, 6, 7); // one pointer argument wotj 6 int argument
 return y + argc; // resturn the the foo() resul and add it to argc
}

int foo(int* arg1, int arg2, ..., int arg7) {
 return *arg1 + arg7; // return derefernece the pointer pointed address vlaue and add arg7 
}

// Assembly of main function
main:
01 pushq %rbx // push the rbx as our return address

02 subq $16, %rsp // allocate 16 bytes at %rsp (the buttom pointer)
03 movl %edi, %ebx // edi values to copied to the lower 4 bytes of rbx
04 movl $351, 12(%rsp) // allocate 351 (x) to 12 bytes above rsp

05 movl $1, (%rsp) // start of initilaize the a[] array
06 movl $2, 4(%rsp) // store 2 at 4 bytes above rsp
07 movl $3, 8(%rsp) // store 3 at 8 bytes above rsp

08 pushq $7      // push an inmmediate values 7 on the stack (exceeds the 6th agrument)

09 movl $6, %r9d // store the array vlues for foo (caller or callee saved regsiter?)
10 movl $5, %r8d
11 movl $4, %ecx
12 movl $3, %edx
13 movl $2, %esi

14 leaq 20(%rsp), %rdi // computer current x location and store the address literal to rdi; note: due to pushq 7, x is
15 movl $0, %eax // zero out eax for foo to use
16 call foo 



17 addl %ebx, %eax // our eax add whatever ebx is (argc in C); note ebx is in 4 bytes
18 addq $24, %rsp //reset out rsp pointer to restore the stack
19 popq %rbx  //
20 ret // eax return by x86-64 convention


foo:
21 movl (%rdi), %eax // load *arg1 (our x = 351) into eax
22 addl 8(%rsp), %eax // add the  8+rsp (the 7th argument) value in eax; we are calling the values from the return address (8bytes)
23 ret 


```
Stack: return address (to function_called_main); saved %rbx (callee-saved); 351, 3,2, 1 (the local variables); 7 (the 7th argument); return address (to main)

- note: recall that rsp allocate memory by going the lower address (lower in the stack) (growing downwards)
- note:
    - 8 bytes (64-bit registers): Full registers like %rax, %rbx, etc.
    - 4 bytes (32-bit registers): Lower half of the 64-bit registers, like %eax, %ebx, etc.
    - 2 bytes (16-bit registers): Like %ax, %bx, etc.
    - 1 byte (8-bit registers): Like %al, %ah, etc.
### Caller vs. Callee
Caller function:
- Instantiate a call to anotehr function (invoked by `callq`)
- Responsible for saving any needed values in registers before calling callee

Callee function
- Performs a specific task 
- Assumes free reign to change the values in the caller-saved registers
- Reponsible for saving and restoring callee register values
```
// Caller
<use %rbx>
callq
...       // where retq from callee return
<use rbx>

// Callee
pushq %rbx   // save old value
<change %rbx value>
popq %rbx    // restore old value
retq

```

### Calling Conventions
**First 6 arguments are ordered in registers:**
- 1. `%rdi` 2. `%rsi` 3. `%rdx` 4. `%rcx` 5. `%r8` 6. `%r9`
    - note: registers are not part of memroy/the stack
- Additional arguments are pushed to the stack by the caller before invoking callq
    - In reverse order: arg n pushed first, arg 7 last
    - Part of the caller's stack frame
- Return value
    - Placed in %rax


**"Caller-saved" registers:"**
- %rax, %rcx, %rdx, %rsi, %rdi, %r8–%r11
- If caller needs to use their value(s) across a function call, then psuh onto the stack
- Pushed just before function call; popped right after (from the buttom)

**"Callee-saved" registers:"**
- %rbx, %rbp, %rsp, %r12– %r15
- If callee wants to changes their value(s), then push onto the stack
- Pushed at beginning of funciton; popped before ret


### Stack Frame Structure (strucutre within the stack)
low: argument build -> caller-saved register value -> local varaibles and padding -> callee-saved register values -> return address
- Return address
    - pushed by callq; address of instruction after callq
- Callee-saved registers
    - Only if function modifies/uses them
- Local variables
    - Variables that fit in a register may not be allocated on the Stack
    - Unavoidable if varaible is too big for a register (e.g., array)
    - Unavoidable if variable needs an address (i.e., uses & var)
- Caller-saved registers
    - Only if values are needed across a function call
- Argument build
    - Only if function calls a function with more than six arguments
### Memory Layout
- The Stack is at the top of the memroy layout
- Upside down in memory: higher addresss considered the "top"
- There is a dedicated register %rsp that points to the stack top
- %rsp regsiter points to the to stack top

## Section 1   
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

