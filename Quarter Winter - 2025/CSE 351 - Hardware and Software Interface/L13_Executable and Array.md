## In Lecture 
### Element Access in Multilevel Array
```
int get_univ_digit
    (int index, int digit)
{
    return univ[index][digit];
}

salq $2, %rsi # rsi = 4*digit
addq univ(,%rdi,8), %rsi # rsi/p = univ[8*index] + 4*digit or univ[8*index] + rsi
movl (%rsi), %eax # return *p
ret

```
| Step | Assembly | Computation |
|------|----------|-------------|
| 1️| `salq $2, %rsi` | `%rsi = 4 * digit` (byte offset for column) |
| 2️ | `addq univ(,%rdi,8), %rsi` | `%rsi = univ[index] + 4 * digit` (pointer to element) |
| 3️ | `movl (%rsi), %eax` | `%eax = *p` (fetch integer) |
| 4️ | `ret` | Returns the value in `%eax` |

Computation
- Element access Mem[Mem[univ+8*index]+4*digit]
- Must do two memory reads
    - First get pointer to row array
    - Then access element within array

note: sal_q stadns for "shift arithemtic left"
### Multilevel Array Example
```
int cmu[5] = { 1, 5, 2, 1, 3 };
int uw[5] = { 9, 8, 1, 9, 5 };
int ucb[5] = { 9, 4, 7, 2, 0 };

int* univ[3] = {uw, cmu, ucb}; // a pointer array
```
### Nested Array Element Access Code
Given Code
```
int get_sea_digit
    (int index, int digit)
{
    return sea[index][digit];
}

int sea[4][5] =
{{ 9, 8, 1, 9, 5 },
{ 9, 8, 1, 0, 5 },
{ 9, 8, 1, 0, 3 },
{ 9, 8, 1, 1, 5 }};

leaq (%rdi,%rdi,4), %rax # rdi + rid*4 = 5 rdi (note: rdi is our index)
addl %rax, %rsi # rsi = 5*idnex + rax (note: rax is our digit)
movl sea(,%rsi,4), %eax #  eax holds (sea + 4*(5*index+digit))

# note: the 4 from (, %rsi, 4) is used to calcualte the int value
```

Array Elements
- sea[index][digit] is an int (sizeof(int)=4)
- Address = sea + 5*4*index + 4*digit

Assembly Code
- Computes address as: sea + ((index+4*index) + digit)*4
- movl performs memory reference
### Nested Array Element Access
- Array Elements
    - A[i][j] is element of type T, which requires k bytes
    - Address of A[i][j] is
        - A + i(C*K) + i*K == A +(i*C + j)*K
### Nested Array Row Access
Row vectors
- Given T A[R][C]
    - A[i] is an array of C elements (row"i)
    - Starting address of row i = A + i*(C*sizeof(T))
### Two-Dimensional (Nested) aRRAYS
- Deceleration: T A[R][C]
- each element requires sizeof(T) bytes

Array size: R*C*sizeof(T) bytes
- arrangemnet: row-major ordering
### Nest Array Example
```
int sea[4][5] =  // 4 rows and 5 columns
{{ 9, 8, 1, 9, 5 },
{ 9, 8, 1, 0, 5 },
{ 9, 8, 1, 0, 3 },
{ 9, 8, 1, 1, 5 }};
```
- “Row-major” ordering of all elements
- Elements in the same row are contiguous
### C Details: Arrays and Pointers
- Arrays are (almost) identical to pointers
    - char *string and char string[] are nearly
identical declarations
    - Differ in subtle ways: initialization, sizeof(), etc.

An array name is an expression (not a variable) that
returns the address of the array
- It looks like a pointer to the first (0th) element
    - *ar same as ar[0], *(ar+2) same as ar[2]
- An array name is read-only (no assignment) because it is a
label
    - Cannot use "ar = <anything>"
### Array Accessing Example
```
// return specified digit of ZIP code
int get_digit(int z[5], int digit) {
        return z[digit];
}

get_digit:
    movl (%rdi,%rsi,4), %eax # z[digit]
```
Register %rdi contains starting address of array

Register %rsi contains array index

Desired digit at %rdi+4*%rsi, so use memory reference
(%rdi,%rsi,4)
### Array Example
```
// arrays of ZIP code digits
int cmu[5] = { 1, 5, 2, 1, 3 };
int uw[5] = { 9, 8, 1, 9, 5 };
int ucb[5] = { 9, 4, 7, 2, 0 };

to draw, each array each be happen to be allocated in successive 20 bytes blocks
```

### C Data Strucutre: Array
Allocation
- T A[N]: array of datat type T and length N
- Congituous allocated region of N*sizeof(T) bytes
- Identifer A returns address of array (type T*)

Ex
```
char mse[12] gives us from x to x +12 with 12 chunks in between

int val[5] gives us from x to x + 20 with 5 chunks in between

double a[3] gives us from x + 24 with 3 chunks in between

char* p[3] gives us from x to x + 24 with 3 chunks in between

note: the # of chunks denote the size of T and where as each chunk length correpsond to the lenght of data type
```
Access
- Identiferi A returns address of array (type T*)
    - ex. 3,7,1,9,5 are stored in an int x[5] with range from a to a + 20
| Reference   | Type   | Value                                      |
|------------|--------|--------------------------------------------|
| x[4]       | int    | 5                                          |
| x          | int*   | a                                          |
| x+1        | int*   | a + 4                                      |
| &x[2]      | int*   | a + 8                                      |
| x[5]       | int    | ?? (whatever’s in memory at addr x+20)     |
| *(x+1)     | int    | 7                                          |
| x+i        | int*   | a + 4*i                                    |
   
### Building an Executable Summary
Multistep process:
- compiling, assembling, linking
Object code finished by linker
- using symbol and relocation tables to produce machine code (with finalized addresses)
Loader sets up initial memory from executable
### Loader (Review)
Input: executable binary program, command-line arguments
    - ./a.out arg1 arg2
Output: <program is run>

Loader duties primarily handled by OS/kernel
- More about this when we learn about processes
Memory sections (Instructions, Static Data, Stack) are set up

Registers are initialized
### Disassembling Object Code (Review)
Disassmebled
```
0000000000400536 <sumstore>:
400536: 48 01 fe add %rdi,%rsi
400539: 48 89 32 mov %rsi,(%rdx)
40053c: c3 retq

```
Disassembler (objdump -d sum)
- Useful tool for examining object code (man 1 objdump)
- Analyzes bit pattern of series of instructions
- Produces approximate rendition of assembly code
- Can run on either a complete executable or object file

Disassembler examines bytes and attempts to reconstruct
assembly source
- However
    - ex.  objdump -d WINWORD.EXE (which won't show anything however, becuase MS forbid reverse engineering)
### Linking (Review)
1. Take text segment from each .o file and put them together
2. Take data segment from each .o file, put them together, and
concatenate this onto end of text segments
3. Resolve References
    - Go through Relocation Table; handle each entry
### Linker (Review)
Input: Object files (e.g. ELF, COFF)
- foo.o
Output: executable binary program
- a.out  default name for executable

Combine several object files into a single executable ("linking")
    - Enables separate compilation/assembling of files
    - Changes to one file do not require recompiling of whole program
### Object File Format
1. object file header: size and position of the other pieces of the
object file
2. text segment: the machine code
3.  segment: data in the source file (binary)
4.  table: identifies lines of code that need to be
“handled”
5. symbol table: list of this file’s labels and data that can be
referenced
6.  debugging information
### Object File Information Tables (Review)
- Each object file has its own symbol and relocation tables
- Symbol Table holds list of “items” that may be used by other
files
    - Non-local labels – function names for call
    - Static Data – variables & literals that might be accessed across files
- Relocation Table holds list of “items” that this file needs the
address of later (currently undetermined)
    - Any label or piece of static data referenced in an instruction in this file
        - Both internal and external
### Producing Machine Language (Review)
- Simple cases: arithmetic and logical operations, shifts, etc.
    - All necessary information is contained in the instruction itself
- What about the following?
    - Conditional/unconditional jump
    - Accessing static data (e.g. global var or jump table)
    - call

- Addresses and labels are problematic because the final
executable hasn’t been constructed yet!
    - So how do we deal with these in the meantime?
### Assmebler (Rview)
Input: Assembly language code (e.g. x86, ARM, MIPS)
- foo.s
Output: Object files (e.g. ELF, COFF)
- foo.o
- Contains object code and information 
---
- Reads and uses assembly directives
    - e.g. .text, .data, .quad
    - x86: https://docs.oracle.com/cd/E26502_01/html/E28388/eoiyg.html
- Produces “machine language”
    - Does its best, but object file is not a completed binary
- Example: gcc -c foo.s
### Compiling Into Assembly (Review)
C Code (sum.c)
```
void sumstore(long x long y, long *dest){
    long t = x +y
    *dest = t
}
x86-64 assembly (gcc -Og -S sum.c)
```
sumstore(long, long, long*):
    addq %rdi, %rsi
    movq %rsi, (%rdx)
    ret

```


```
### Compiler
- Input: Higher-level language code (e.g. C, Java)
    - foo.c
- Output: Assembly language code (e.g. x86, ARM, MIPS)
    - foo.s
### Building an Executable with C
- Code in files p1.c p2.c
-  Compile with command: gcc -Og p1.c p2.c -o p
    -  Put resulting machine code in file p
- Run with command: ./p

```
text [C program(p1.c p2.c)] - Compiler (gcc - Og -S)-> text [Asm program(p1.s p2.s)] - Assmebler (gcc - c or as) -> binary [Object program p1.o p2.o] - Linker (gcc or ld) - > binary [Executable program (p)] Loader (the OS)
```

### Poll Questions
```
0000000000401126 <main>:   # Function entry

401126:    48 83 ec 08        # sub    $0x8, %rsp      ; Allocate 8 bytes on stack
40112a:    bf 10 20 40 00     # mov    $0x402010, %edi ; Load immediate 0x402010 into %edi
40112f:    e8 fc fe ff ff     # callq  401030 <puts@plt> ; Call puts function
401134:    b8 00 00 00 00     # mov    $0x0, %eax      ; Set return value to 0
401139:    48 83 c4 08        # add    $0x8, %rsp      ; Restore stack pointer
40113d:    c3                 # retq                   ; Return
40113e:    66 90              # xchg   %ax, %ax        ; NOP (No Operation, used for alignment)

```
What is the byte of data at address 0x40113b?
```
Address   Byte
401139 -> 48
40113a -> 83
40113b -> c4  (the asnwer)
40113c -> 08
```
The immediate $0x402010 appears in the machine code. What is its address?
```
Address   Byte
40112b -> 10  (least significant byte) (answer)
40112c -> 20
40112d -> 40
40112e -> 00  (most significant byte)
```

Which of the following statements if False?
Let's break it down with **visuals** to clarify why **Option C is actually false** and why `sea[4][-2]` might be valid.

---

### **Step 1: Understanding the Memory Layout**
The array is declared as:
```c
int sea[4][5];
```
This means:
- 4 **rows**
- 5 **columns** per row
- Stored in **row-major order** (left to right, top to bottom in memory).

#### **Memory layout (assuming `sizeof(int) = 4 bytes`):**
Each row has **5 elements**, so the memory looks like this:

| Index | Address | sea[i][j] |
|--------|------------|---------|
|  0  | 76  | sea[0][0] |
|  1  | 80  | sea[0][1] |
|  2  | 84  | sea[0][2] |
|  3  | 88  | sea[0][3] |
|  4  | 92  | sea[0][4] |
|  5  | 96  | sea[1][0] |
|  6  | 100 | sea[1][1] |
|  7  | 104 | sea[1][2] |
|  8  | 108 | sea[1][3] |
|  9  | 112 | sea[1][4] |
| 10  | 116 | sea[2][0] |
| 11  | 120 | sea[2][1] |
| 12  | 124 | sea[2][2] |
| 13  | 128 | sea[2][3] |
| 14  | 132 | sea[2][4] |
| 15  | 136 | sea[3][0] |
| 16  | 140 | sea[3][1] |
| 17  | 144 | sea[3][2] |
| 18  | 148 | sea[3][3] |
| 19  | 152 | sea[3][4] |

## Pre-lecture 
### Multidimensional and Multi-level Arrays
Multi-dimensional:

- C utilizes **row-major ordering**, placeing consecutive elements in each row next to each other. 
- A N-diemmnsiona. array N subscript to access indinvsula elements

Multi-level:
- created by adding extra levels of arrays of pointers to arrays. Each individual array is guaranteed to use contiguous memory, but allocating the extra levels takes up more space in total and adds an extra memory access per level



### Arrays in Assembly
**In C**
- Declaring an array T ar[N] for a contigous space to hold the specified N elements of sizeof(T)
- Separate array declarations are not guaranteed to be adjacent, nor is their relative ordering guaranteed
- The array subscript operator (i.e., ar[i]) uses pointer arithmetic to access the correct memory address


**In Assembly**
- The name of an array(`ar`) is actually just a label/placeholder for the starting address of the array

```
// example: the global array int uw_zip[] = {9, 8, 1, 9, 5}; gets converted to the following in assembly:
uw_zip:
        .long   9
        .long   8
        .long   1
        .long   9
        .long   5
```
Subscript operator
- `ar[i]` $\leftrightarrow$ `*(ar+i)` $\leftrightarrow$ `Mem[ar + i*sizeof(T)]`
    1. `(Rb, Ri, S)` -- with `Reg[Rb]` = an address, `Reg[Ri]` = the index, and S = `sizeof(T)`
    2. `D(, Ri, S)` -- with D = an array name/label, `Reg[Ri]` = the index, anf S = `sizeof(T)`

Ex. Assuming the address of uw_zip is stored in %rdi and the value of i is stored in %rsi, then `int east = uw__unzip[i]` might be translated to either `movl (%rdi, %rsi, 4), %eax` or `movl uw_zip(, %rsi,4), % eax`

### Linking
- Linker will stitich together all the object and static library files needed to produce the final executable
    - the stiching process will fail if theany unresovled symbols (e.g., undefined functions, missing source files) exsit
-  At the end of linking, the executable has been built and the data in the Code, Static Data, and Literals sections have been assigned finalized addresses

Note: objects and exectuable are binary files, implying that human-readibility is lost at this stage
- However, we can still try to read the binary due to ISA defined ecnoding rule uisng "disassembling"

```
// A look into disassembly:
// The left column shows the starting address of each instruction,
// and the right columns display the corresponding machine code bytes.
// Note that the first byte listed corresponds to the address in the left column
// (e.g., 0x401126 -> 0x48, 0x401127 -> 0x83), and so on.

0000000000401126 <main>:
  401126:   48 83 ec 08             sub    $0x8,%rsp
  40112a:   bf 10 20 40 00          mov    $0x402010,%edi
  40112f:   e8 fc fe ff ff          callq  401030 <puts@plt>
  401134:   b8 00 00 00 00          mov    $0x0,%eax
  401139:   48 83 c4 08             add    $0x8,%rsp
  40113d:   c3                      retq
  40113e:   66 90                   xchg   %ax,%ax

```
### Loading
- The loader will take an exectuabel file and start up a runnign process from it, which includes setting up its memory sections an dinitailziaiton regiester values, which is typically hanlded by the operating system (covered in CSE451)
### Compiling
- Trnaslate the text file
    - In C: command such as `#` and like `include` and `define` (CSE 333)
    - Some more in the tranlating process comes in the semantics of the source, which is material you learn from CSE 401
### Assembling
- Assmebler will convert a text file of assembly code into a binary object file
    - some patching will be done later once the address become known
        - based on symbol table (stores the labels assocaited with object: functio names, global variables) and relocation tblae (store address to be patched)
### CALL - compiling, assembling, linking, and loading 
- Purpose: to build an executibe (./ able ) from C source file

A standard compilter (e.g., `gcc`) command on our source code to do all the three phases. However, one can ask `gcc` to stop at an intermediate phase if desired. The benefits is that it allows the design to be build from multip source files

```
C program (.c) --compiler (gcc -Og -S)--> Asm program (.s) -- Assembler (gcc -c or as)> Object program (.o) --Linker (gcc or 1d)-> Executable program (p) --Loader (the OS)

text          text           binary            binary

```

Question_1: Which of the following assembly instructions would have an "incomplete" translation in the object file?
- callq puts (ans: for puts is not a refenrece of an assembly instruction; puts can be a C-var tho)
- push %rbx
- retq
- shrl $1, %rax

Question_2: The linker is unessesary if I only wrote a single source file
- False, the linker also brings in static libraries (e.g., `#inclsuve <studio.h>` allows you to use library functison that are defined elsewhere)


Question_3: If we have:
```
int x = 351;
int  uw_zip[] = {9, 8, 1, 9, 5};
int ucb_zip[] = {9, 4, 7, 2, 0};
```
how will we return 5?
- uw_zip[4]