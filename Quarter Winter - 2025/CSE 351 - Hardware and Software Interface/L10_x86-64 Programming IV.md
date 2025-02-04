
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
