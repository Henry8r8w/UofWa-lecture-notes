## Pre-Lecture Reading
### Condition Codes
Condition codes are status bits that are part of the CPU state that indicate information about the most recently executed assembly instructions. 
- They can be thought of as multiple single-bit registers, though they are actually part of a larger EFLAGS register in x86-64. The four condition codes that we will focus on are the `Carry Flag (CF)`, `Zero Flag (ZF)`, `Sign Flag (SF)`, and `Overflow Flag (OF)`

**Implicit Setting**
Example:  If 0x80 is stored in %al, then addb %al, %al would update the value in %al to 0x00, but also set CF = 1, ZF = 1, SF = 0, and OF = 1 because the result had unsigned overflow, was zero, was not negative, and had signed overflow.

**Explicit Setting**
Example:  If 0x83 is stored in %al and 0x8C is stored in %bl, then testb %al, %bl would not update any values, but set CF = 0, ZF = 0, SF = 1, and OF = 0 because the result of %al & %bl is 0x80

### Address Computation Instruction (`lea`)
Sometimes we don’t want to dereference a memory operand and want to use the address instead
- Here comes the instruction 'load effective address' `lea`
    - source: must be a memory operand
    - destination: must be a register operand
```
lea D(Rb, Ri, S), R # stores Reg[Rb] + S*Reg[Ri] + D =  Reg[R]
```
As the name suggests, the result does not have to actually be used as an address (it’s an “effective address”), so lea can be used to perform arithmetic computations that fit the address calculation format b + s*i

Example: lea (%rdi,%rsi,4), %rax with x stored in %rdi, y stored in %rsi, and z stored in %rax

If we have int* x and long y, then this is equivalent to int* z = &x[y];

If we have long x and long y, then this is equivalent to long z = x + 4*y;

Question: If %rax currently holds the value 3, what value is stored in %rbx after the following instruction is executed?
```
leaq (%rax,%rax,2), %rbx
```
- Ans: given we have two rax , so we have Reg[rbx] = D:0 + Reg[Rb]: Reg[rax] + S*Reg[Ri]: 2 * Reg[rax], Reg[rbx] =  0 + 3 + 2*3 = 9