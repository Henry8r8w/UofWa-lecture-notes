## HW 16: Memory and Caches i
### Cache Performance
Assume we have a cache that starts cold

We execute a short loop that results in the following access pattern: MHHMHHMH, where "M" is a Miss and "H" is a hit.

Question 1: Based on the access pattern, how many cache blocks have been pulled/copied into the cache?
- Ans: three, given three M

Question 2: What is the Hit Rate (as a percentage, including the percentage sign '%') of this access pattern?
- Ans: 5/8 given size(H)/ size(pattern)

Question 3: If the cache has a Hit Time of 4 ns and it takes 200 ns to access data from Memory, what is the Average Memory Access Time of this set of accesses?
- Ans:79 ns given AMAT = hit time (4ns) + miss rate  (3/8) x miss penalty (200)


### IEC Prefixes

| IEC   | Abbr | Size        | IEC   | Abbr | Size         |
|-------|------|-------------|-------|------|-------------|
| Kibi  | (Ki) | 2^10 ≈ 10^3   | Pebi  | (Pi) | 2^50 ≈ 10^15 |
| Mebi  | (Mi) | 2^20 ≈ 10^6   | Exbi  | (Ei) | 2^60 ≈ 10^18 |
| Gibi  | (Gi) | 2^30 ≈ 10^9   | Zebi  | (Zi) | 2^70 ≈ 10^21 |
| Tebi  | (Ti) | 2^40 ≈ 10^12  | Yobi  | (Yi) | 2^80 ≈ 10^24 |

Quetion 1: Write 2^58 addresses using IEC prefixes
- Ans: 2^50 *2^8 = Pi*256 = 256Pi

Quetion 2: Write 2^43 addresses using IEC prefixes
- 2^3 *2^40 = 8 Ti

## HW 15: Buffer Overflow Homework
### Lab 3 prepration 
**Sendstring**

In the lab3 directory, there is a tool included called sendstring that will turn a string of hexadecimal characters into a string of bytes with those hexadecimal values.

This allows us to generate input strings that contain non-printable characters (i.e., characters that we can't type) like 0xBE and 0xEF in the address 0x41BEEF.

Noting that 0x30 to 0x39 are the hexadecimal codes for the digits 0-9 (e.g., 0x30 = '0', 0x35 = '5'), the following example usage generates the bytes for the string "351":
```
$ echo 33 35 31 00 | ./sendstring
351
```

Find the comamdn to pipe into sendstring given an address 0x41BEEF using full address
- ans: echo EF BE 41 00 00 00 00 00 | ./sendstring

**Hex Viewer**
Take the answer to the previous question and save the output into a file called exploit.bytes using the following template:

$ echo ______ | ./sendstring > exploit.bytes
Now open exploit.bytes in a text editor. You should see a lot of weird characters with an 'A' in the middle.

This is because text editors are trying to interpret the file contents as text (e.g. ASCII or other specified encodings), but most of the bytes we used don't have corresponding printable characters other than 0x41, which happens to be 'A'.

To verify that the file bytes are what we expect them to be, we want to use a "hex viewer".  Exit out of the text editor and use the following command:

$ xxd exploit.bytes
This will show us the hex codes of all the bytes in the file. You should now be able to visually recognize the hex digits we passed to sendstring, however, there is an extra byte at the end.

What character does this byte represent? (give the C character literal, including the surrounding single quotes, e.g., 'a' or '\0')

- '\n' using man ascii to idenfiy 0A correspodance
### Prevention
Say we are reading input into a buffer on the stack using gets(), how can we prevent a buffer overflow?

Ans: limit the number of characters that can be read in, using something like fgets()



### Stack Layout
If we overwrite bytes past the current stack frame's stored return address, which of the following parts of the caller's stack frame will we overwrite first that may cause problems for the execution of the caller?


Ans: Saved caller-saved register values

Recall that a stack frame will typically be ordered (from highest to lowest addresses):
- return address
- callee-saved register values
- local variables
- caller-saved register values
- argument build

However, the argument build section contains values needed by the callee and won't affect the execution of the caller.  But the caller-saved register values will be "restored" and popped off the stack to be used once the caller regains control, so changing those values will affect the caller's computations

### Bytes
Consider the following C code:
```
void foo() {
  char buf[8];
  gets(buf);
}
```
Assume that the return address saved in the current stack frame (in a little-endian machine) is currently 0x400CEF.

If we overwrite this return address to be 0x41BEEF, what is the minimum number of bytes written by gets()?

Ans:
- going from (little-endian rep) EF 0C 40 00  to EF BE 41 00, you need the lower three bytes change, the 0C 40 00 <-> BE 41 00; given each writing we have a null terminator, so a 0x00 will be written, whcih adds one more byte. The answer should be 12 bytes
  - note: recall byte deifniton being 8 bits (and 0-F can only be reprsented by 4 bits)

### Strings
Suppose that we use gets() to take the string "1234567" from the console/terminal.

What will be the value of the last byte written by gets()? Answer in hex (including prefix)

- 0x00 (using ASCII(hex) conversion of \0)
### Adresses
Suppose we write 8 bytes into a character buffer starting at 0x7FFFFFFFB4C0, what address will the 1st byte be and what will the 8th byte be?
- 0x7FFFFFFFB4C0 , 0x7FFFFFFFB4C7
## HW 14: Struct Homework
### Structs in Assembly
Q1: 
```
// Suppose we have this sammy function and init_sammy
struct sammy {
   int* x;               // offset 0 (pointer:8 bytes)
   struct {
      short s[2];        // s[0] at offset 8, s[1] at offset  (short:2 bytes)
      int i;             // offset 12 (int:4 bytes)
   } wolfy;
   struct sammy* next;    // offset 16 (pointer8 bytes)
};


void init_sammy(struct sammy* ss) {
   ss->wolfy.s[1] = /* SNIPPET 1 */; // note: -> performs dereferencing
   ss->x = /* SNIPPET 2 */;// store address ss into i: &ss->wolfy.i
   ss->next = /* SNIPPET 3 */;
}
// And that the compilter geenrate the following assembly code for inint_sammy
init_sammy:             # Entry point of init_sammy function
   movw 8(%rdi), %ax    # (2 bytes) Load ss->wolfy.s[0] from offset 8 into %ax
   movw %ax, 10(%rdi)   # (2 bytes) Store the 2-byte value from %ax into ss->wolfy.s[1] at offset 10

   leaq 12(%rdi), %rax  # Compute the effective address of ss->wolfy.i (offset 12); result in %rax
   movq %rax, (%rdi)    # (8 bytes) Store the 8-byte pointer in %rax into ss->x at offset 0


   movq %rdi, 16(%rdi)  # (8 bytes) Store the 8-byte pointer (ss) from %rdi into ss->next at offset 16
   retq                 # Return from the function
note: %rdi is our case holds the pointer to the entire strucutre of ss of the struct, where we compute address of subsequent of its members by leveraging the offset calculation

note: #(reg) tells x86-64 to access memory at the address based on # offsert from the register
note: w in assmebly
```
Q1: Based on the aassembly code init_sammy, fill in the missing C code for SNIPPET 1
- ss->wolfy.s[1] =  ss->wolfy.s[0];
```
movw 8(%rdi), %ax    # (2 bytes) Load ss->wolfy.s[0] from offset 8 into %ax
movw %ax, 10(%rdi)   # (2 bytes) Store the 2-byte value from %ax into ss->wolfy.s[1] at offset 10
```

Q2: Based on the assembly code for init_sammy, fill in the missing C code for SNIPPET 3
- ss->next = ss;

Q3: If we add the following line to the end of init_sammy, what line of assembly code will be generated?
```
ss->wolfy.i = 18;
```
- movl $18, 12(%rdi) operation, for we have type int (byte size of 4: 4*8bits)
  - note: l is used in 32 bits
  
### Struct Layout
Q1: Take the following instnace `rec` of `struct`, and `foo_st`
```
struct foo_st {
   char  *a; // 8 (pointer)
   short  b; // 2
   double c; // 8
   char   d; // 1
} rec;

```
- offset 0  to get 8 (+8), offset from 8 to 10 (+2) and pad to get 16, offset from 16 to 24 (+8), offset from 24 to 25 and padd to 32

Q2: How many bytes of `rec` are internal fragmentation
- the sum of internal padding: 6

Q2: How many bytes of `rec` are external fragmentation
- the sum of internal padding: 7

## HW 13
### Compiling 
Q2: One can use Compiler Explorer for the translationi between C and assembly
On the left half of the window, the upper-right has a drop-down menu for source language. Make sure that C is selected.

On the right half of the window, there is a drop-down menu in the upper-left to choose your compiler. Make sure this is set to x86-64 and choose the version of gcc nearest to the one you found in the question above.

Just below the drop-down menu is a set of buttons. Under the Output... settings, make sure only Demangle identifiers is selected. Under the Filter... settings, make sure everything except Horizontal whitespace is selected

## HW12: Procedures & Recursion Homework
```
long fib (unsigned long n) {
  if (n < 2)
    return 1;
  return fib(n - 2) + fib(n - 1);
}

	.data
.LC0:	.string	"fib(0) = %ld, expecting 1\n"
.LC1:	.string	"fib(1) = %ld, expecting 1\n"
.LC2:	.string	"fib(2) = %ld, expecting 2\n"
.LC3:	.string	"fib(4) = %ld, expecting 5\n"
.LC4:	.string	"fib(6) = %ld, expecting 13\n"
.LC5:	.string "REGISTER SAVING CONVENTION ERROR DETECTED!\n(this message does not catch all cases)\n"

	.text
fib:
	cmpq	$1, %rdi
	ja	.L8
	movl	$1, %eax
	ret
.L8:
	movq	%rdi, %rbx
	leaq	-2(%rdi), %rdi
	call	fib
	movq	%rax, %rbp
	leaq	-1(%rbx), %rdi
	call	fib
	addq	%rbp, %rax
	ret

# ===============================================================
# you do NOT need to read or understand anything below this point
# ===============================================================

	.globl	main
	.type	main, @function
main:
	subq	$8, %rsp
	movq	$-1, %rbx
	movq	$-1, %rbp
	movl	$0, %edi
	call	fib
	movq	%rax, %rdx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$1, %edi
	call	fib
	movq	%rax, %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$2, %edi
	call	fib
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$4, %edi
	call	fib
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$6, %edi
	call	fib
	movq	%rax, %rdx
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	cmpq	$-1, %rbx
	jne	.L7
	cmpq	$-1, %rbp
	jne	.L7
.L6:
	movl	$0, %eax
	addq	$8, %rsp
	ret
.L7:
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L6
```
Run the gcc -o fib fib.s and answer the following questions

Q1: What is the first argument to fib shown that produces an incorrect

- rdi (n - 1), rbx (rdi saved in rbx), rbp (rax stores in rbp), rax (rbp stores in rax)
## HW11: The Stack & Procedures Homework
### F Trace 1
```
f:
    cmpq    $-12, %rsi
    jne    .L2
    movq    %rsi, %rax
    movq    %rdi, %rsi
    movq    %rax, %rdi
    call    f
    ret
.L2:
    addq    $1, %rdi
    movq    %rsi, %rax
    imulq   %rdi, %rax
    ret



long f(long x, long y) {
  if (y == <cond>)
    return f(<farg1>, <farg2>);
  return <ret>; 
}
```
Suppose f is called with -2 in %rdi and 3 in %rsi. Give the values of the following registers just before f returns
- %rdi: 
### F Code
```
f:
    cmpq    $-12, %rsi    # Compare x with -12
    jne     .L2           # If x != -12, jump to .L2
    movq    %rsi, %rax    # Move x to rax
    movq    %rdi, %rsi    # Move y to rsi
    movq    %rax, %rdi    # Move x to rdi
    call    f             # Recursive call f(y, x)
    ret                   # Return result

.L2:
    addq    $1, %rdi      # y + 1
    movq    %rsi, %rax    # Move x to rax
    imulq   %rdi, %rax    # Multiply (y + 1) * x
    ret                   # Return result

long f(long x, long y) {
  if (y == <cond>)
    return f(<farg1>, <farg2>);
  return <ret>; 
}
```
- <Cond>: -12
- <farg1>: y
- <farg2>: x
- <ret>: (x + 1)*y
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