### Signed Integers
- representation: using the most significant bit (msb)
- range: $[-2^{n - 1}: 2^{n - 1} -1]$
- negation procedure: - x = ~x +1 (-x is assign by the negation of x and add one (negative signed))

Question 1: Compute the decimal value of the 8-bit Two's Complement number 0xAA

- $0b 1010 1010 \to ~() \to 0b01010101 + 0b0001 \to 0b01010110 \to 2+ 4 + 16 + 64 = -86$

```c
#include <stdio.h>

int main() {
  signed char x = 0xAA;  // "signed" uses Two's Complement
  printf("x = %d\n", x); // -86
}

#include <stdio.h>

int main() {
  unsigned char x = 0xAA;  // "signed" uses Two's Complement
  printf("x = %d\n", x); //  -> 0b 1010 1010 :128 + 32 + 8 + 2 = 170
}
```

Question 2: Give the binary representation of -1 as a 8-bit Two's Complement number by applying the negation procedure to 1 as an 8-bit Two's Complement number.
- ~(0b00000001) + 0b00000001  = 0b 1111 1111

### Unsigned Integers
- def: non-negative integers
- In C, the integer width (assuming a 64 bit machine)
  - `unsigned char` (1 byte)
  - `unsigned short` (2 bytes)
  - `unsigned int` (4 bytes)
  - `unsigned long` (8 bytes)

For any given integers width (n), we can represent only $2^n$ things with a range $[0:2^{n} -1]$

we pefrom addition and subtraction the same way as with decimal, but carry and borrow a value at 2

![alt text](Quarter Winter - 2025\CSE 351 - Hardware and Software Interface\PNGs\binary_op.png)

Question: What is the result of the following operation
```
  0b 1000 0000
- 0b 0001 0001
--------------
```
- consider 0b 1000 0000 (128) $\leftrightarrow$ 0b 0111 1112, so subtracting 0b 0001 0001 (17) leaves you with 0b 0110 1111 = 0x6F = 111

### Bitwise and Logical Operators
- Bit-wise operator: applies boolean to the **bits** of the operands, and they only be used on integral data types (e.g., `char`, `short`, `int`,`long`)

Example: bit-wise operator
```c
#include <stdio.h>

int main() {
  char a, b, c;
  a = 0x69;   // 0x69 -> 0b 0110 1001
  b = 0x55;   // 0x55 -> 0b 0101 0101
  c = a & b;  //         0b 0100 0001 -> 0x41
  printf("c = 0x%x\n", c);
}
// note: observe how 0 and 1 or 0 and 0 result to 0 to the corr. bit location
```
- Boolean operator: applies boolean operations to the **values** of the operand(s)
Example 2
```c
#include <stdio.h>

int main() {
  char a, b, c;
  a = 0xCC;   // 0b 1100 1100
  b = 0x33;   // 0b 0011 0011
  c = a & b;  // 0b 0000 0000 -> 0b0
  printf("a & b  = %d\n", a & b); // -> 0
  printf("a && b = %d\n", a && b);//
}
```
note: C treats a value of 0 in any form, NULL and '0/', as False, and anything else as true
- in the case of &&, the non-zero are evaluated in non-binary representation (hex or decimal)
- it does not matter what representations a and b are in, binary, hex, decimal, but it is only evaluated based on 'non-zero-ness'

recall: %d evals to decimal, whereas %x eval to hexidecimal (16 based)

recall: and is &, or is |, xor is ^, not is ~

Question to ask:
What binary of of char x can have us x ^ 0xBE such that it yields a 0xF4
- 0xBE -> 0b10111110
- 0xF4 -> 0b11110100
- since we're using a bit-wise operator, 0100 0100 xor 1011 1110 should help use get 1111 1010

```c
#include <stdio.h>

int main() {
  char x = 0x4A; // -> 0b 0100 1010
  printf("x ^ 0xBE = 0x%X\n", x ^ 0xBE);
}

``
