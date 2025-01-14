### Numerical Encoding
- $d \cdot b^{i}$
- In base b, using a fixed width of n digits will allow you to represent at most $b^n$ things
- Examples: With 3 bits, we can represent at most $2^3$ things, corresponding to the numerals 0b000, 0b001, 0b010, 0b011, 0b100, 0b101, 0b110, and 0b111
### Binary Encoding - Files and Programs
At the lowest level, all digital data is stored as bits!
-  Layers of abstraction keep everything comprehensible
- Data/files are groups of bits interpreted by program
- Program is actually groups of bits being interpreted by your 
CPU

Computer Memory Demo (rec to try)
- From vim:  %!xxd


Some Question to Think About:
a. What is a GFLOP and why is it used in computer benchmarks?
b. How and why does running many programs for a long time 
eat into your memory (RAM)?
c. What is stack overflow and how does it happen?
d. Why does your computer slow down when you run out of 
disk space?
e. What was the flaw behind the original Internet worm, the 
Heartbleed bug, and the Cloudbleed bug?
f. What is the meaning behind the different CPU specifications? 
(e.g., # of cores, size of cache)


### Why Base 2?
Electronic implementation
- Easy to store with bi-stable elements
- Reliably transmitted on noisy and inaccurate wires

Other bases possible, but not yet viable:
- DNA data storage (base 4:  A, C, G, T) is hot @UW
- Quantum computing

### Converting inary < - > Hexadecimal
Hex $\to$ Binary
- Substitute hex digits, then drop any 
leading zeros

- Example:  0x2D to binary
    - 0x2 is 0b0010, 0xD is 0b1101
    - Drop two leading zeros(00), answer is 0b101101


Binary $\to$ Hex
- Pad with leading zeros until multiple of 
4, then substitute each group of 4
- Example:  0b101101
    - Pad (expand space) to 0b 0010 1101
    - Substitute to get 0x2D

### Conveting from Decimal to Binary
The algorithm

Given a decimal number N:
1. List increasing powers of 2 from right to left until ≥N
2. Then from left to right, ask is that (power of 2) ≤N?
- If YES, put a 1 below and subtract that power from N
- If NO, put a 0 below and keep going

ex: 13 to binary

| 4        | 3        | 2        | 1        | 0        |
|----------|----------|----------|----------|----------|
| 2^4 =16  | 2^3 = 8  | 2^2 = 4  | 2^1 = 2  | 2^0 = 1  |
| NONE     | 5        | 12       | 1        | 0        |
| 0        | 1        | 1        | 0        | 1        |

Row1: power factor
Row2: power(base)
Row3: Greatest Number Subtraction
Row4: Resulting binary



### Decimal to Binary
Convert 13_{10} to binary

x^2 + y^1 + z^0 = 13
- thus, 0b332 (wrong; visit Converting From Deimal to Binary)

note: 
- the attempt from this was trying to convert decimal to decimal, which is impossible; what is possible, is to convert decimal to numerical to decimal (13 ->x_{10}) by doing so: $1 \cdot 10^{1} + 3 \cdot 10^{0} = 13$, which is quite meaningless in this situation, but the using a $34_{8}$ you can get a 28 numerical

### Binary and Hexadecimal
Binary is base 2
- Symbols: 0 and 1
- Convention: $2_{10} = 10_{2} = 0b10$

Example: what is 0b110 in base 10?
- $\text{0b110} = 110_{2}= 1\cdot 2^2 + 1 \cdot 2^ 1 + 0 \cdot 2^0 = 6_{10}$

Hexadecimal (hex, for short) is base 16
- Symbols: 0,1,2,3,4,5,6,7,8,9,A ,B,C,D,E,F
- Convention: $16_{10} = 10_{16} = 0x10

Example: What is 0xA5 in base 10?
- 0xA5 = $\text{A}5_{16} = 10 \cdot 16^1$

note: A is 10 -> F is 15, 0b and 0x are just preceding conventions
### Decimal Numbering System
- 7061 in decimal (base 10): $7 \cdot 10^3 + 0 \cdot 10^2 + 6 \cdot 10^1 + 1 \cdot 10^1$
