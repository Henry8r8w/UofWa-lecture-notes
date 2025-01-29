### Labels
Labels give us a way to refer to a specific instruction in
our assembly/machine code
- Associated with the next instruction found in the assembly code
(ignores whitespace)
- Each use of the label will eventually be replaced with something
that indicates the final address of the instruction that it is
associated with

ex. max and done are your Labels
```assembly
max:
  movq %rdi, %rax
  cmpq %rsi, %rdi
  jg done
  movq %rsi, %rax
done:
  ret


```

### Practice Question 1
### Control Flow
Register: %rdi (use: operand1), %rsi (use: operand2), %rax (use: return value)

```assembly
max: 
    if true
    if false then jump to else
    movq %rdi, %rax
    jump to done
else:
    movq %rsi, %rax
done:
    ret

```
Translate to c

```C
long max(long x, long y)
{
    long max;
    if (x > y) {
        max = x;
    } else {
        max = y;
    }
    return max;
}

```
### Choosing instructions for conditionals
All arithmetic instructions set condition flags based on result of
operation (op)
- Conditionals are comparisons against 0
- Come in instruction pairs: first set flags, then jump!


addq 5, (p)
- je: *p+5 == 0
- jne: *p+5 != 0
- jg: *p+5 > 0
- jl: *p+5 < 0

orq a, b
- je: b|a == 0 
- jne: b|a != 0 
- jg: b|a > 0 
- jl: b|a < 0 

cmpq 5, (p)
- je: *p == 5 
- jne: *p != 5 
- jg: *p > 5 
- jl: *p < 5

testq a, a
- je: a == 0 
- jne: a != 0 
- jg: a > 0 
- jl: a < 0

testb a, 0x1
- je: aLSB == 0.
- jne: aLSB == 1.

example
```c
if (x <3){
  return 1;
}
return 2;
```
Register: %rdi (use: operand1), %rsi (use: operand2), %rax (use: return value)
```assembly
cmpq $3, %rdi
jge T2 # greater or equal

T1: # x <3:
  moveq $1, %rax
  ret
T2: # !(x < 3):
  movq $2, %rax
  ret
```
### Reading Condition Codes
Operand is byte register (e.g., %al) or a byte in memory
- Do not alter remaining bytes in register
  - Typically use movzbl (zero-extended mov) to “finish the job”

Register: %rdi (use: operand1), %rsi (use: operand2), %rax (use: return value)

```c
int gt (long x, long y){
  return x > y
}

```


```assembly
cmpq %rsi, %rdi # Compare x:y
setg %al # set when >
movzbl %al, %eax # zero rest of %rax: | %rax     | %eax   | %ax    | %al   |
ret
```
### Using COndition COdes: Setting
set* Instructions
- Set low-order byte of dst to 0 or 1 based on condition codes
- Does not alter remaining 7 bytes


| Instruction | Condition         | Description                  |
|-------------|-------------------|------------------------------|
| `sete`      | ZF                | Equal / Zero                 |
| `setne`     | ~ZF               | Not Equal / Not Zero         |
| `sets`      | SF                | Negative                     |
| `setns`     | ~SF               | Nonnegative                  |
| `setg`      | ~(SF^OF) & ~ZF    | Greater (Signed)             |
| `setge`     | ~(SF^OF)          | Greater or Equal (Signed)    |
| `setl`      | (SF^OF)           | Less (Signed)                |
| `setle`     | (SF^OF)           | Less or Equal (Signed)       |
| `seta`      | ~CF & ~ZF         | Above (unsigned ">")         |
| `setb`      | CF                | Below (unsigned "<")         |

### Using Condition Codes: Jumping
J* Instructions
- Jumps to target (an address) based on condition codes

Note: We can’t define our own j* instructions. But we can
simulate customizing one by “saving” flags for a compound conditional, and jumping based on that…


### Example Condition Code Setting
Assuming that %al = 0x80 and %bl = 0x81, which flags
(CF, ZF, SF, OF) are set when we execute:
cmpb %al, %bl

CF:, ZF:, SF:, OF:


### Setting Condition Codes: Explicit Setting with test
Explicitly set by Test instruction
- testq src2, src1 ↔ sets flags based on a&b
Kind of like andq a, b but doesn’t store result anywhere
Tip: Useful to have one of the operands be a mask
- Can’t have carry out (CF) or overflow (OF)—why?
  - Jump 'jump' to an target address, whereas set modify the lower-order byte of the destination
- ZF=1 if a&b==0
- SF=1 if a&b<0 (signed)

### Setting Condition Codes: Explicit Setting with cmp
- Explicitly set by the Compare instruction
  - cmpq src1, src2 ↔ sets flags based on b-a
      - Kind of like subq a, b but doesn’t store result anywhere

- CF=1 if carry out from MSB (good for unsigned comparison)
- ZF=1 if a==b, because b-a==0!
- SF=1 if (b-a)<0 (if MSB is 1)
-  OF=1 if signed overflow
  -(a>0 && b<0 && (b-a)>0) || (a<0 && b>0 && (b-a)<0)
### Setting Condition Codes: Implicit Setting
- Implicit set by arithmetic operations
  - ex. addq src, dst $\leftrightarrow$ r = d +s

- CF=1 if carry out from MSB (unsigned overflow)
- ZF=1 if r==0
- SF=1 if r<0 (if MSB is 1)
- OF=1 if signed overflow
  - (s>0 && d>0 && r<0)||(s<0 && d<0 && r>=0) = out
  - (condition1) or (condition2) met ? out: 1
 

- Carry Flag (checks MSB carrying out; move 1 to left, add one bit)
- Zero Flag (check the result operation being 0 or not)
- Overflow Flag (checks overflow of sign)
  - (a>0 && b<0 && (b-a)>0) || (a<0 && b>0 && (b-a)<0)
    - note: a and b are signed binary in representation of decimal
  - ex. let a: 3 and b : 5
    - two's complement: 0011 + 0110 = 1001 , which results in a signed -8, and is a overflow in MSB (from 0 to 1). Now the OF should be flaged 1


  
### Condition Codes
- Carry Flag (CF): Set to 1 if most recent op result carried out data which
couldn’t be stored; i.e. unsigned overflow (usually when dest < src)
- Zero Flag (ZF): Set to 1 if most recent op result computed to 0
- Sign Flag (SF): Set to 1 if most recent op result is a signed (negative)
value i.e. MSB produced is 1
- Overflow Flag (OF): Similar as carry flag, but applies to signed overflow i.e. if MSBs were both 0, and now result MSB is 1, or vice versa
### Processor State (x86-64, partial)
Information about
currently executing
program
- Temporary data ( %rax, … )
- Location of runtime
stack ( %rsp )
- Location of current
- code control point ( %rip, … ), which is the  instruction pointer
- Status of recent tests( CF, ZF, SF, OF ), which are the condition code

### Conditional and Control Flow
Two types of conditionals: branch and jump
  - Jump: you "jump" to somewhere else if some condition is true
  , otherwise execute next instruction
Two types of unconditional: (still) branch and jump
- Always jump when you get to this instruction


### Move extension: movz and movs
1. movz _ _  src, regDest # move with zero extension

2. movs _ _ src, regDest # move with sign extension
- note: _ _ denotes  the 2 width specifier where the lateral subtract the forecomer
- copy from a smaller source value to a larger destination
- source can be memory or register, but destination **must** be a register

Example: movzbq %al, %rbx
- q:8 byte - b:1 byte, which render a 28 bits zero extension (on right left)


### Poll
Keyword: interactive broker



## Pre-Lecture Reading
### If-else Statements
Translating this C code
```c
if (x < 3)  // assume x stored in %rax
  y += 2;   // assume y stored in %rbx
else
  y = 10;
```
We can get the assembly of
```assembly
 1    cmpq $3, %rax  # computes x - 3
 2    jl   .L2       # jump if  x < 3
 3    movq $10, %rbx # y = 10
 4    jmp  .L3
 .L2:                # label associated with line 5
 5    addq $2, %rbx  # y += 2
 .L3:                # label associated with line 6 (not shown)
```
### Labels
The operand to a jump instruction (the target) is known as a label in assembly. A label is a symbolic representation of an instruction’s address and is indicated by an identifier (symbolic string) followed by a colon

Examples:  main:, foo:, loop:

```
max: 
    movq %rdi, %rax  # Copy the value in %rdi (first argument) to %rax (return value register)
                     # Assume %rax = %rdi (default return value is the first argument)

    cmpq %rsi, %rdi  # Compare %rdi (first argument) with %rsi (second argument)
                     # Sets flags based on the result of (%rdi - %rsi)

    jg done          # If %rdi > %rsi (first argument > second argument), jump to the label 'done'
                     # This skips the next instruction and returns %rax (which is %rdi)

    movq %rsi, %rax  # If the jump is not taken, copy %rsi (second argument) to %rax
                     # This means %rax now holds the value of %rsi (second argument is larger)

done:                # Label 'done': marks the end of the function
    ret              # Return from the function. The return value is in %rax
```

The equivlanent C code
```C
long max(long a, long b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}
```
### Conditionals
In the simplest case, a conditional in assembly is made up of two assembly instructions:
1. The instruction that sets/changes the condition codes (arithmetic, logical, cmp, test)
2. A conditional jump instruction (j*)

Recall that the condition codes can be set implicitly by arithmetic and logical instructions or explicitly using `cmp`/`test`, and that conditional jumps are determined by the previous result compared to zero. Conditionals can be massaged into the appropriate format to make it clear which instructions to choose.
Examples:

1. **x >= y**  
   → x – y >= 0  
   → Use:  
     ```
     cmp y, x  
     jge target
     ```
2. **x == 3**  
   → x – 3 == 0  
   → Use:  
     ```
     cmp $3, x  
     je target
     ```
3. **x & 1**  
   → x & 1 != 0  
   → Use:  
     ```
     test $1, x  
     jne target
     ```
Question: Which pair of pseudo-assembly instructions below will jump to `target` when `x < 3`?
```
cmp $3, x
jl target
```
- recall: cmp (and sub) subtract the 1st operand from the 2nd (x - 3), meaning that we want cmp $3, x as our first instruction. Then, our comparison with 0 is "less than" so our second instruction should be jl.
### Jump and Set

| Jump Instr | Set Instr    | Condition    | Description    |
|------------|--------------|--------------|----------------|
| jmp target | —            | 1            | Unconditional  |
| je target  | sete_dst     | ΣF           | Equal to 0     |
| jne target | setne_dst    | ~ΣF          | Not Equal to 0 |
| js target  | sets_dst     | SF           | Negative       |
| jns target | setns_dst    | ~SF          | Nonnegative    |
| jg target  | setg_dst     | ~(SF^OF) &~ΣF| Greater Than 0 (Signed) |
| jge target | setge_dst    | ~(SF^OF)     | Greater Than or Equal To 0 (Signed) |
| jl target  | setl_dst     | (SF^OF)      | Less Than 0 (Signed) |
| jle target | settle_dst   | (SF^OF)      | Less Than or Equal To 0 (Signed) |
| ja target  | seta_dst     | ~CF&~ΣF      | Above 0 (unsigned ">") |
| jb target  | setb_dst     | CF           | Below 0 (unsigned "<") |

The difference between these families of instructions is that the jump family will jump our program to the specified target (i.e., change which instruction we execute next) if the condition is met, while the set family will set the value of the 1-byte dst register to the value of the condition (i.e., 0x00 or 0x01)

Instead of focusing on the formulas in the "Condition" column, it is more intuitive to ask if the "Description" column is true of the result of the last instruction that modified the condition codes (either implicitly via arithmetic/logical instruction or explicitly via a compare/test instruction).


Example:  Assuming `x` is stored in `%rdi` and `y` is stored in `%rsi`, then the following two instructions set `%al` to the logical equivalent of `x - y > 0`, as the description entry for `setg` says "greater than 0". 
```
cmpq  %rsi, $rdi  # set condition codes based on x - y
setg  %al         # al = (x > y)
```