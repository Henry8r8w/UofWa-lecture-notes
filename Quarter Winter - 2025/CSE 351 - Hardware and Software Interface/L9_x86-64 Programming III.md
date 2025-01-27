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