
## HW10: x86-64 Programming IV Homework
### Loops
Consider the following C code and their correspoding assembly
```
int foo(short n, int x) {
  int counter = _____;
  int result = _____;

  while (counter _____) {
    result = _____;
    counter = _____;
  }

  return result;
}


# int foo (short n, int x)
# n in %di, x in %esi
foo: 
  movl    $1, %eax  # Initialize %eax to 1
  movl    $1, %edx  # Initialize %edx to 1
  movswl  %di, %ecx # Sign-extend %di (n) to 32 bits and store in %ecx
.L2:
  cmpl    %esi, %edx # Compare %edx (counter) with %esi (x)
  jge     .L5        # If %edx >= %esi, jump to .L5 (exit loop) from L2 and move to L5, the return statement
  sall    %cl, %eax # shift arithimtic left  by %cl (1 byte/8 bits of %rcx (8 bytes), %ecx (4 bytes)) value 
  addl    %edx, %edx # self add %edx
  jmp     .L2
.L5:
  ret
```
note: jmp is the unconditional, which explicity specify where the go to after some operation has been made
- jmp is used more often in a for loop and to do operation; it jmp less often appeared for a do-while loop, where condition written at the end of 

```
# Example of a `do-while` loop without `jmp`
movl $0, %ecx          # Initialize counter
.LoopStart:
addl $1, %ecx          # Increment counter
cmpl $10, %ecx         # Compare counter with 10
jl   .LoopStart        # Jump back to start if counter < 10


# Example of a loop without `jmp`
movl $0, %ecx          # Initialize counter
.LoopStart:
cmpl $10, %ecx         # Compare counter with 10
jl   .LoopBody         # Jump to loop body if counter < 10
jmp  .LoopEnd          # Exit loop if counter >= 10
.LoopBody:
addl $1, %ecx          # Increment counter
jmp  .LoopStart        # Jump back to start of loop
.LoopEnd:
```

note: `cal` is a command of bit shift
- example: let %eax: 1  (63 0s and 1 1) and %cl: 3 (6 0s and 2 1s), we get a 61 0s and a 100

note: short encodes at the maximum of 2 bytes / 16 bits

Q1: Which register holds the program value `result`?
- %eax, due to x86-64 convention

Q2: What is the initial value (in decimal) of `result`?
- 1, from the initialization

Q3: What is the test condition (i.e., the blank in the `while`-statement) for `counter`?
- <x
  - note: becuase the loop exit when  %edx  (counter) >= %esi(x), so the While-True condition would be counter < x

Q4: What is the update statement (i.e., the blank in the while-statement) for result?
- result << n

Q5: What is the update statement (the blank inside the while-statement) for counter?
- Ans: 2*counter
## HW9: x86-64 Programming III Homework
### Conditionals
Q3: Equivalence

Find an alternative first instruction for the x86-64 code below using test that does not change the behavior.
```
cmpq %rdi, $0
je   MyLabel
```
- Ans: testq %rdi, %rdi
  - note: since je checks for equal to 0 condition, if we test, ass a bitwise AND command, if the result is 0...0, then our ZF will tell us the information by 1 (yes), 0 (no)
  - note: `orq %rdi, %rdi ` is also possible as we are asking for all 0s across the bits, so it is sensitiy to presence of zero
Q2: Comparison

Assuming that the value of the variable `int *p` is currently stored in `%rax`, which of the following choices is the C code equivalent of the following lines of assembly?

```
cmpl   (%rax), $351  # Compare (cmp) the 32-bit value (long/l) at the memory address in %rax with the immediate value 351
setle  %dil         # Set %dil to 1 if the value at (%rax) <= 351, otherwise set %dil to 0
```
- Ans: (*p >- 351)





Q1: Set

Assume that %rax and %rbx both currently hold the value of -1.  We now execute the following instructions:
```
addq %rbx, %rax // -2 + (-2)
setg %bl
```
What value (in hex, including the prefix) is now stored in %rbx?
- Ans: 0xFFFFFFFFFFFFFF00


note_1: recall how to convert hex with two complement
- given positive number 2, you have 0...010 in binary that you flip the 0s and 1s to get -2 sucht that 1...101 is produced
- Thus, 0x15F1E is your added %rbx, %rax
  - note: four 1s give you one F, so there are 60 1s before there is a 1101, which renders one E

note_2: setg sets the %bl (the lower 1 bit of %rbx) 1 if previous operation is greaeter than 0 for the 8 bits
- recall that the addq has result a valu eless than 0; thus, the lower 8 bits become 0
## HW7: x86-64 Programming Homework
### Instructions
Q1: What is the appropriate instruction suffix for:
```
mov_  (%rsi), %eax
```
- l (4 bytes)

Q2: The following x86-64 instruction has an error in it:
```
movq %ebx, (%rdi)
```
Fix the instruction suffix to make the instruction work.
- movl %ebx, (%rdi)


Q3: Write the assembly instruction that stores the sum of the values in registers %rdi and %rax back into %rax.
- addq %rdi, %rax


Q4: Assuming that the register %rdi contains 8 bytes that constitute a valid address, write the x86-64 instruction to dereference this address and move two bytes from memory into the lowest portion of %rsi.
- movw (%rdi), %si

note:() denotes the dereference of the memory
note: (src) to dest and src to (dest) differ by how memory is handled
  - src to (dest): source value writes to location where (dest) is pointed at
  - (src) to dest: src value is read and loads to the dest register/memory

### Operands
There are three types of assembly instruction operands:
- Immediate – constant integer data
- Register – data pulled from the contents of a register
- Memory – consecutive bytes of memory pulled from a specified, calculated address

Indicate data size of the following
1. %dil: 1 byte
2. -11: unknown
3. %r14d: 4 bytes
4. (%rax): unknown, for it is a memory operand; the amount of memory depedn on the operation that memory operand is part of 
5. 0xDEAD: unknown, This is a 2-byte constant, but could still be extended to 4 bytes or 8 bytes depending on the operation
## HW6: Floating Point
### FP Code
```c
#include <stdio.h>

int main(int argc, char* argv[]) {
  int count = 0;
  float cap = 16777216;

  for (float i = 0; i < cap; i++) {
    count++;
  }
ls
  printf("This iterated %d times\n", count);

  return 0;
}
```
- Run $ gcc -g -Wall -std=c18 -o fp fp.c

Q1: How many times did the loop iterate
- 16777216

Q2: Change the initial value of cap to 16777217 (incremented by one). Compile and run the code. How many times does the loop iterate when you run it now?
- 16777216
  - note: notice how this is not something you expect
  - rational: 2^{24} = 1677216, it is the max representation (ex. 1.00000000000000000000000 × 2^24) (1. with 23 zeros x 2^24)

Q3: Increment the value of cap again to 16777218. Compile and run the code. What happens?
- the loop does not stop

Q4:What power of 2 is 16777216? That is, what is x such that 2^x=16777216
- x = 24

Q5: What is the value of the mantissa field (M) of the float representing 16777216? Answer in binary, without the 0b prefix and no spaces.
- 00000000000000000000000

Q6: What is the value of the mantissa field (M) of the float representing 16777218? Answer in binary, without the 0b prefix and no spaces.
- 00000000000000000000001
  - we don't want to further increment, so 0...01 is the last increment possible
Q7: What limitation of floating point is responsible for the behavior we see when cap = 16777217?
- Rounding of `cap`
Q8: What limitation of floating point is responsible for the behavior we see when cap = 16777218?
- Rounding of `i`

### FLoating Point Special Cases
Q1: Convert the single-precision floating point encoding 0x7FC00000 to its decimal value
- Ans:
  - 32 bits: 0 11111111 10000000000000000000000
  - Exponent = E: 255 - bias: 127 = 128
    - notice: the all ones in E and all some non-zeros in mantissa; this patterns renders NaN
    - notice: 255 E represent either infinity or NaN, but when M is non-zeros, it is categorize as NaN
Q2: Convert the single-precision floating point encoding 0xFF800000 to its decimal value
- Ans:
  - 32 bits: 1 11111111 00000000000000000000000
  - notice: since the fraction (M) is all zeros, so the infinity is assigned instead of NaN, and our sign is negative; the result is - infinity
### Decimal to Floating Point
Q: Convert the decimal number 17.3125 into IEEE 754 single-precision floating point encoding 

Sign (S)
- since the number is positive, so the sign bit (S) is: S = 0

Exponent Filed (E)
- 17: 10001_2, .3125: 0.0101_2; 10001.0101_2
  - normalization: 1.00010101_2 x 2^{E:4}, which gives us the some part of the mantissa
  - Bias  = E + 127 = 131, which becomes 0b10000011_2

Mantissa Field (M)
- 1.M: 00010101_2, which requires padding until it reaches to 23 bits
  - 00010101000000000000000_2

S: 0

E: 10000011 

M: 00010101000000000000000

Final 32 bits: 0 10000011 00010101000000000000000
### Floating Point to Decimal
Q: convert this 0b 1100 0000 1101 1000 0000 0000 0000 0000 binary to floating point
- Ans: using the SEM procedure, we can split the binary into sign, exponent, and mantissa, use value = (-1)^{s}x M x 2^{E}
  - E = exponent: 100 0000 1 - bias: 127 = 2
  - M = 1.10110000000000000000000_2 = 2^-1 + 0 + 2^-3 + 2^-4 = 1.6875_10
  - End Result: -1^{1} x 1.6875 x 4 = -6.75

note: with M, assume preceding 1
recall: in 32 bit system, sign takes up 1 bit, expoenent takes up 8 bits, mantissa takes up 23 bits
### Exponents
Q1: What is E when exponent = 0?
- Ans: given bias 127 and exponent = E - bias, we say E = 127, which is 0b01111111 in binary

Q2: What is E when exponent = 1?
- Ans: given bias 127 and exponent = E - bias, we say E = 128, which is 0b10000000 in binary


## HW4: Bitwise and Logical Operators
### Interpretation
What is the integer value stored in `signed char x = 0xE1;`?
- step 1: convert hex to bits to decimal
  - 0b11100001 becomes -31
    - note: the MSB gives you the sign, making a -2^7+2^6+2^5+2^0
tip: one can also use the negation and +1 bit (more official) to get the same result 
- ~x: 0b00011110 + 1, which becomes 00011111
  - a tip when there are n consecutive 1s, use 2^n -1 formula
  - 2^5 -1 = 31, and since the sign bit was 1, so -31 is out answer
Which of the following 8-bit numerals has a larger magnitude (i.e., farther from 0) when interpreted as an unsigned number than when it is interpreted a signed number?
- 0x00, 0x7F, 0x80, 0xFF
  - ans:0xFF
### Bitwise Operators
What is the resulting value (in binary) of r from the following code?
```
char c = 0xF1; // binary: 1111 0001
char m1 = 0x55; // binary: 0101 0101
char m2 = 0x62; // binary: 0110 0010
char m3 = 0x2B; // binary: 0010 1011
char r = ((~c | m1) & m2) ^ m3;
```
- `~c|m1`:  ~0b11110001 | 0b01010101, which is 0b01011111
- `(~c | m1) & m2`:0b01011111 & 0b01100010, which is 0b01000010
- `((~c | m1) & m2) ^ m3`: 0b01000010 ^ 0b00101011, which is 0b01101001

Recall that a null pointer is a pointer that "points to nothing" and has the value 0x0. Logically, what does the null pointer evaluate to?
- False
## HW3: Memory and Data 2
### Memory Allocation
How much memory (in bytes) is taken up by the following variables and data?

```
1 int x = 123; // 4
2 int* p = &x; // 8, size of address in 64-bit system
3 short ar[10]; // 2*10
4 char* str = "hi!"; // 8+ 4, address size + (3*bytesize(Char) + null character)
```

The null character is a special character that denotes the end of a string (i.e., character array) in C (written in code as '\0').

What does the second printf statement below output?
```
char text[] = {'s', 'e', 'l', 'd', 'o', 'm', '\0'};
printf("%s\n", text);
text[-1] = 'c'; // out of bound modification; c goes a memory before seldom
text[2] = '\0'; // seldom -> se
printf("%s", text-1); // starting the array before the start of text
```
- cse

### Pointer Arithmetic
For the following problems, assume that the following lines of C code have been executed:

```
int x = 0x78;  // assume &x is 0xB0
char* x_ptr1 = (char*) &x;
char* x_ptr2 = (char*) (&x + 2);
```
Q1: &x +3
- `&x` is an `int*`, pointing to 0xB0.
- Pointer arithmetic scales by `sizeof(int)` (4 bytes):
  - 0xB0 + 3 * sizeof(int) = 0xB0 + 12 (0d12) = 0xBC.
- Alternatively:
  - Convert 0xB0 to decimal: 0d(11 * 16^1 + 0 * 16^0) = 176.
  - Add 12: 176 + 12 = 179 = 0xBC in hex (verified by 179 // 16 = 11 remainder 13).
note: we scale up with addition

Q2: x_ptr1 +3
- `x_ptr1` is a `char*` pointing to 0xB0 (casted `&x`).
- Pointer arithmetic for `char*` scales by `sizeof(char)` (1 byte):
  - 0xB0 + 3 * sizeof(char) = 0xB0 + 3 = 0xB3.

Q3: what is the hex value return by expression (&x +2) - &x
- Given (&x + 2) - &x:
    - Pointer arithmetic scales by the size of the type being pointed to (`int`, 4 bytes)
    - (0xB0 + 2 * sizeof(int)) - 0xB0 = (0xB0 + 8) - 0xB0 = 8 bytes
    - Divide by `sizeof(int)`: 8 / 4 = 2 integers advanced = 0x2
- note: we scale down from subtraction 
Q4: what is the hex value return by expression x_ptr2 - x_ptr1
- Given x_ptr2 - x_ptr1:
    - `x_ptr2` points to `0xB8` and `x_ptr1` points to `0xB0`
    - x_ptr2 - x_ptr1 = 0xB8 - 0xB0 = 0x8 (difference in bytes since `char*` scales by 1 byte)


### Dereference
Assume that a little-endian machine currently has the data shown (in hex) below in its memory:
```
addr:  0x48 0x49 etc.
data: | AC | EF | AC | CA | FE | CA | 0D | F0 |
```
Which address (in hex) should be put in the blank below so that the variable y holds the value 0xCAFE?  Remember to count in hex!
```
short* p = ______;
short  y = *p;
```
Address:
- p = 0x4c
    - given that little endian stores with the least significant byte
    - note: short stores 2 bytes

### Syntax
```
int x = 42;
int*** p = &x;
printf("*p = %p\n", *p);
```

Identify the error of the above code
- Incompatible assignment to p, given p is a pointer to a pointer to a pointer (triple `*`). To make it compilable, you should just have denote p with a single pointer assignment: int* p = &x, an integer p pointer to the address(x)