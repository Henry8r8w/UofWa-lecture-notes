## In Lecture Slides
### Switch Statement Example
```
long switch_ex(long x, long y, long z)
{
   long w = 1;
   switch (x) {
   . . . // 7 cases + a default
   }
   return w;
}

```
Register  Use(s)
%rdi      1st argument (x)
%rsi      1nd argument (y)
%rdx      3rd argument (z)
%rax      return value

```
swtich_ex:
    movq  %rdx, %rcx         # Copy %rdx into %rcx (preserving a value)
    cmpq  $7, %rdi           # Compare %rdi (x) with 7
    ja    .L9                # If x > 7, jump to default case (.L9); note: ja defines 
    'above 0 (unsigned) greater than '
    jmp   *.L4(, %rdi, 8)    # Jump to the indexed label in the jump table .L4



.section .rodata # defines read-only data section
.align 8    # define 8 bytes algin address, allows efficient access and prevent segementation faults 
.L4:
    .quad .L9   # x = 0
    .quad .L8   # x = 1
    .quad .L7   # x = 2
    .quad .L10  # x = 3
    .quad .L9   # x = 4
    .quad .L5   # x = 5
    .quad .L5   # x = 6
    .quad .L3   # x = 7

```
### From Switch Statemnet to Jump Table
```
switch (x) {
   case val_0:
      Block 0
   case val_1:
      Block 1
      • • •
   case val_n-1:
      Block n–1
}
```
Generated Code
```
target = JTab[x]; // an "array" of pointers; our jump table
goto target;
```
- note: Jump table is the containting array of pointers to the target code block
### Switch Example
https://godbolt.org/
### For-Loop -> While Loop
Caveat: C and Java have
break and continue
- Conversion works fine for
break
   - Jump to same label as loop exit condition
- But not continue: would skip doing Update, which it should
do with for-loops
   - Introduce new label at Update

For loop:
```
for (Init; Test;Update)
```

While-Loop version:
```
Init;
while (Test){
   Body
   Update;
}

```
### Compiling Loops
While Loop
```
C Code
while (sum != 0){
   <loop body>
}

Assembly Code
loopTop:  testq %rax, %rax // bitwise AND operation; flags updated; assumes rax stores zero
          je loopDone // jump to loopDone if equal (rax is zero)
          <loop body code>
          jmp loopTop // unconditional jump to LoopTop once body has been executed
loopDone:
```

Do-While Loop:
```
C Code
do {
   <loop body>
} while (sum != 0)

Assembly Code
loopTop:
   <loop body code>
   testq %rax, %rax
   jne loopTop // jne in testq a, a gives us the jump condition of a != a

```

While Loop (ver.2)
```
C Code
while (sum != 0){
   <loop body>
}


Assembly Code
testq %rax, %rax 
je loopDone
loopTop:  testq %rax, %rax 
          je loopDone 
          <loop body code>
          jmp loopTop 
loopDone:

```
### Poll
The following is assembly code for a for-loop; identify
the corresponding parts (Init, Test, Update)
- i $\to$ %eax, x $\to$  %rdi, y $\to$ %esi

```
    movl $0, %eax           # i = 0 (initialize loop counter)

.L2: 
    cmpl %esi, %eax         # Compare i with y
    jge .L4                 # If i >= y, exit loop

    movslq %eax, %rdx       # Convert i (32-bit) to 64-bit for indexing
    leaq (%rdi,%rdx,4), %rcx # Compute address of x[i]
    movl (%rcx), %edx       # Load x[i] into %edx
    addl $1, %edx           # Increment x[i]
    movl %edx, (%rcx)       # Store updated x[i] back

    addl $1, %eax           # i++
    jmp .L2                 # Jump back to loop condition

.L4: 
    # Loop exit

```
- Ans: for (i = 0; y <  i; i = i +1)


note_1: lea_q stands for load effect address
- ex. leqa x(, %rdx, 4), %rcx gets x base address with index at rdx and a byte size of 4 (bytesize(int)) loaded to rcx
   - definition: leaq base(%index, scale), destination or leaq (base, index, scale), destination
   - note: lea differes from mov for it calculates only the memory address, not the actual memory
```
// Given: x is at memory address  0x1000, i = 3 (%rdx = 3), bytesize = 4
leaq x(, %rdx, 4), %rcx

// the above operations should compute: %rcx = 0x1000 + (3 * 4) = 0x100C
// now, %rcx is pointing at x[i], which is x[3]
// the calculation of lea is the euiqvalent of &x[i] / &x[3] in C

```

note_2:movslq moves with sign (`s`) extentions from 32 bits (`l: long`) to 64 bits (`q: quad`)

note_3: mov dest, src copies values from source to destination, where not arithmetics would be perform nor will flags be modified

note_4: (%register) is giving us the address of the %register

note_5: cmp operand, operand
- requires following by jump conditions
- results in sets of flags:
   - ZF: if result is 0 (operand1 == operand2)
   - SF: if result is negatve (operand1 < operand 2)
   - CF: if unsigned burrow occur (operand1 < operand2 in unsigned context)
## Pre-Lecture Reading
### Switch Statements
**jump table**, a data strucutre to branch to different parts of a program

**program counter** ($rip), a special register that holds the address of the next instruction to execute in the program and gets updated every time an instruction is exeucted

**indirect jump**
jmp *Loc
```
jmp *.L4(,%rdi,8)
```
- updates %rip to the address of the appropriate code blcok assuming that .L4  is the label of the beginning of the jump table and %rdi holds the value of the switch variable

note: the astericks tells us abt the indirectness

### Loops
<<CC instr>>
- j* means the appropriate conditional jump instruction 
- j*' is the opposite jump instruction

ex. if j* is jg, then j*' is jle

**Do-While Loop**
```
loopTop:
   <body code>
   <CC instr>
   j*  loopTop
loopDone:
```

**While Loop**
```
// version 1
loopTop:
   <CC instr>
   j*' loopDone
   <body code>
   jmp loopTop
loopDone:

// version 2
   <CC instr>
   j*' loopDone
loopTop:
   <body code>
   <CC instr>
   j*  loopTop
loopDone:
```

Questions:
Which while-loop version is the following for-loop code using?
```
1    movl $0, %rsi
2    cmpl $9, %rsi
3    jg   .L2
  .L3:
4    addq $10, %rdi
5    addl $1, %rsi
6    cmpl $9, %rsi
7    jle .L3
  .L2:
```
Using the same code shown in Question 1, which line corresponds to the loop update statement? Enter an integer from 1 to 7.
- rsi register is updated in the L3 conditional at line 5
