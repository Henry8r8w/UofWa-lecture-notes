## Lecture Slides
### Two's Complement Negatives
- Helps with having more flexibility in our notation
ex. 4-bit:
- **1010 unsigned**
  - $1*2^3+ 0*2^2+1*2^1+0*2^0 = 10
- **1010 two complements**
  - $-1*2^3+0*2^2+1*2^1+ 0*2^0 = -6$

- we can represent -1 in 1111 expression as
  - $1111_2 = -2^3 + (2^3 -1)$

Now, say if you have to perform negation, bit-wise
- you should know that your should first negative your bits and shift by 1
  - (~x +1 == -x), which should be 1
### Sign and Magnitude
- We designate the high-order bit (MSB) as the 'sign bit'
  - sign: 0 is positive number, where as 1 is negative number

Examples of 8-bit Signed Integers
- **0x00 = \(00000000_2\)**
  - Non-negative, because the sign bit is **0**.
  - Decimal equivalent: **0**.
- **0x7F = \(01111111_2\)**
  - Non-negative, because the sign bit is **0**.
  - Decimal equivalent: **+127**.
- **0x85 = \(10000101_2\)**
  - Negative, because the sign bit is **1**.
  - Decimal equivalent: **-5** (Two's complement representation).
- **0x80 = \(10000000_2\)**
  - Negative, because the sign bit is **1**.
  - Decimal equivalent: **-128** (minimum value in an 8-bit signed integer).

Pro and Cons of sign bit 
- two representation of 0 (1000 and 0000), which is bad for checking equality
- arithmetic is cumbersome (ex. 4 -3 != 4+ (-3))

To address the issue with sign and magnitudes, we can flip negative encoding
and shift negative numbers to eliminate - 0 (Two's Complement)

0000: +0,..., 1000: -0, ..., 1111:-7 becomes 0000: +0,..., 1000: -8, ..., 1111:-1
- now, 1111 is the new -1 and 10000 is the new -8

### Encoding Integers
unsigned integer values: 0... $2^{w} -1$

signed integer values: $-2^{w -1}... 2^{w -1} -1$

note: the total number of element they both can encode are the same; use number line
### Compare Card Values
```c
char hand[5];
char card1, card2; // cards to compare
card1 = hand[0];
card = hand[1];
...
if (SameSuit(card1, card2)){...}

#define SUIT_MASK 0x0F// --> 0d(0*16^1 + 15*16^0) --> 0b001111

int sameSuit(char card1, char card2){
  return ((unsigned int)(card1 & VALUE_MASK) > (unsigned int)(card2 & VALUE_MASK))
}
// note: now we bit-mask the values with 1 where we also check if card1 has greater value than
// card2, for we do expect a difference in the cards values, unlike in suits, where they can be overlapped 
```
### Compare Card Suits
```c
char hand[5];
char card1, card2; // cards to compare
card1 = hand[0];
card = hand[1];
...
if (SameSuit(card1, card2)){...}

#define SUIT_MASK 0x30 // --> 0d(3*16^1 + 0*16^0) --> 0b110000

int sameSuit(char card1, char card2){
  return (card1 & SUIT_MASK) == (card2 & SUIT_MASK);
  // return (!((card1 & SUIT_MASK))^(card2 & SUIT_MASK)); less intuitive version, but equivalent
}
// we expect int 1/0 to be returned
// note:  11 part of 0b11000 encodes suit whereas 0000 part encodes the value
// note: the less intuitive version inverts bit values (0 to 1 and non-zero to 0) and so given a values evaluated by xor to be 0 -- which are c1(0)c2(0) and c1(1)c2(1) -- will be evaluated as 1; thus, we know that card2 and card1 have the same suit regardless of what suit (0bXX) they have
```
- c^c  == 0, !(x^y) thus become a boolean condition of x == y
### Numerical Encoding Design Example
- Let's encode a standard deck of playing cards
- 52 cards in 4 suits

we only need 6 bits(0bXXXXXX): $2^6 = 64 /geq 52$
- we can even separate binary encoding into 2 bits and 4 bits for suit encoding and the value encoding

### Bitmasks
- a lot of time, we use binary bitwise operators (&, |, ^) as taking an operand being the input and the another one operand being a specially-chosen "bit-mask" to perform a desired operation

| Operation   | Result | Justification                         |
|-------------|--------|---------------------------------------|
| b & 0       | 0      | AND: Any bit ANDed with 0 is always 0 |
| b & 1       | b      | AND: b AND 1 preserves the value of b |
| b | 0       | b      | OR: b OR 0 preserves the value of b |
| b | 1       | 1      | OR: b OR 1 is always 1  |
| b ^ 0       | b      | XOR: b XOR 0 preserves the value of b (b:0 ^ 0 = 0, b:0^ 1 = 1)|
| b ^ 1       | b̅     | XOR: b XOR 1 flips the value of b (b:1 ^ 1 = 0, b:0 ^ 1 = 1) |



### Logical Operators: Short-Circuit Evaluation
- If the result of a binary logical operator (ex. &&, ||) can be determined by its first operand (a), then the second operand is never evaluated (b)
  - aka. early termination
  - ex. (p && *p): interestingly, && here serves as a check (of p) whether the pointer is Null or not; if true, then we can get the dereferenced p (*p)
### Logical Operator
- bit-wise operators: &, |, ^ (XOR: exclusively or)

In C:
- 0 is False
- "Anything" non-zero is True
- A logical operator always returns 0 or 1

### Lecture Polls


### Administrivia
- the class is one lecture (2 calender days)
- teh catch up will take place during lectures 7 - 10 
  - most likely during 8th lecture


### Lab 1a released
- Workflow
1. edit pointer.c
2. run the Makefile (make clean followed by make) and check for compiler errors and warnings
3. run ptest (./ptest) and check for correct behavior
4. run rule/syntax check (python3 dlc.py)

- Lab Synthesis Questions
  - response must be typed in a .txt file submitted on gradescope
  - graded by TA

## Pre-Lecture Reading
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
