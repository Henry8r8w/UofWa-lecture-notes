## Lecture Slides
### Bonus Slides: Hints for Lab1b
### Right Shifting 8-bit Example
Reminder: C operator >> does logical shift on
unsigned values and arithmetic shift on signed values
- Logical Shift: x/2n?
- Arithmetic Shift: x/2n?
### Let Shifting 8-bit Example
No difference in left shift operation for unsigned and
signed numbers (just manipulates bits)
- Difference comes during interpretation: $x\cdot 2^n$?

Let our x be 25 in decimal and out encoding scheme comes in 8-bits:
- 0b00011001; sign: 25, unsigned: 25
- x<<2: 0001100100; sign: 100, unsigned: 100
- x<<3: 00011001000; sign: -56, unsigned: 200
- x<<4: 000110010000; sign: -112, unsigned: 144
    
Notice how, though we are still in 8 bit encoding scheme, our signed values at -56, -112 and unsigned values at 144, cannot be represented anymore
- 8 bit range
    - unsigned: $2^8 - 1: 0 - 255$
    - signed: - 128 to 127 (using twp's complement)


### Shift Operations (Review)
Throw away (drop) extra bits that “fall off” the end
- Left shift (x << n)  bit vector x by n positions
    - Fill with 0’s on **right**
    - ex. 1010  << 4 : 1010 0000
        - 10  $\to$ 10*2^4 = 160

- Right shift (x >> n) bit-vector x by n positions
    - Logical shift (for unsigned values)
        - Fill with 0’s on **left**
    - Arithmetic shift (for signed values)
        - Replicate most significant bit on left (maintains sign of x)

| x          | 0010 0010 |             | x          | 1010 0010 |
|------------|-----------|-------------|------------|-----------|
| x << 3     | 0001 0000 | logical:    | x << 3     | 0001 0000 |
| x >> 2     | 0000 1000 | logical:    | x >> 2     | 0010 1000 |
| x >> 2     | 0000 1000 | arithmetic: | x >> 2     | 1110 1000 |


Notes:
- Shifts by n<0 or n≥w (w is bit width of x) are undefined
- In C: behavior of >> is determined by the compiler
    - In gcc / C lang, depends on data type of x (signed/unsigned)
-  In Java: logical shift is >>> and arithmetic shift is >>

### Arithmetic Overflow (Review)
- C and Java ignore overflow exceptions
**Overflow: Unsigned**
- addition: 1111 + 0010 = 10001 -> 0001 (15 +2 -> 1)
- subtraction: 10001 - 0010 = 1
**Overflow:Two's Complement**
- addition: 0110 + 0011 = 1001 (6+3 -> 7 by negative scaled inverted binary, 0b0111)
    - very funny: (+) + (+) = (-) result
- subtraction: 1001 - 0011 (-7 -3 -> 6)
    - very funny: (-) + (-) = (+) result
note:
- to bit burrow (example: 10001 - 0010), let's go from least significant bit to the most significant bit
    - LSM (index 0): 1- 0 = 1
    - index 1: 0 - 1 = burrowing $\to$ 01121 - 0010 = 1
    - index 2: 1- 0 = 1
    - index 3: 1- 0 = 1
    - Result: 1111
### Two's Complement Arithmetic
- The same addition procedure works for both
unsigned and two’s complement integers
    - Simplifies hardware: only one algorithm for addition
    - Algorithm: simple addition, discard the highest carry bit
    - Called modular addition: result is sum modulo 2^w
example: w = 4 
- 1101_2 (decimal: 13) + 1011_2 (decimal: 11)
    - binary addition: 1101 + 1011 = 11000_2 (decimal: 24 )
    - However, our encoding scheme allows only 4 
        - thus, 1000_2 is our new binary, valued at 8
        - the same thing is 13 + 11 = 24 mod 2^4 = 8 (**sum modulo 2^w**)

### Zero Extension (for the unsigned) vs. Sign Extension
**Zero Extension**
Task: given a w-bit unsigned integer X, convert it to w+ k bit signed integer X-prime with the same value
- Rule: add k 0s
**Sign Extension**
Task: given a w-bit unsigned integer X, convert it to w+ k bit signed integer X-prime with the same value
- Rule: add k copies of _sign_ bit


### Casting Surprises (Review)
Expression Evaluation
- When you mix unsigned and signed in a single expression,
then signed values are implicitly cast to unsigned
- Including comparison operators <, >,==, <=, >=
### In C: Signed vs. Unsigned
- Casting: Bits are unchanged, just interpreted differently
    - int tx, ty
    - unsigned int ux,uy

explicit casting
- tx = (int)ux;
- uy = (unsigned int) ty

implicit casting can occur during assingment or function calls
- tx = ux
- uy = ty

Expression Evaluation
- When you mix unsigned and signed in a single expression, 
then signed values are implicitly cast to unsigned
### Values To Remember 
Unsigned Values
- UMin = 0b00...0 = 0
- UMax = 0b11...1 = $2^w −1@

Two's Complement Values
- TMin = 0b10...0 = $-2^{w-1}$
- TMax = 0b01...1 = $2^{w-1} - 1$
- -1 = 0b11...1
### Signed/ Unsigned Conversion Visualized
From Two Complement to Unsigned (in the decimal representation sense)
- Negative becomes the positive
- Order gets reversed

2's Complement Range: TMin - TmMax  (0 - TMax overlap with the unsigned range)
Unsigned Range: 0 and/or Umin - UMax (0 and/or UMin - TMax)
M
- note: notice how UMax correspond the -1, UMax -1 correspond to -2 in the 2 complemented range


### Why Does Two's Complement Work?
- For all representable positive integers x, we want:
    - bit representation of x + bit representation of -x = 0 (except the carry-out bit (1))
Some 8-bit negative encodings example 
-  (our 8-bits) + (the inverted and plus 1)  / -x == ~x +1
- 00000001 + 11111111 = 100000000
- 00000010 + 11111110 = 111111110
- 11000011 + 00111101 = 100000000


### Polls

## Pre-Lecture Readings
### Integer Arithmetic
Arithmetic on fixed-width binary numbers is performed using modular arithmetic −the operation is performed on the operand's bit patterns, then all bits of the result past the end (i.e., to the left) of the fixed-width are dropped. Subtraction is performed by adding the negated operand  (i.e., \$x - y = x + (-y)$\ ); we negate the operand using Two's Complement negation technique: \$~x = ~x +1$\

4-bit Addition Examples: (HW = hardware bit patterns, US = interpretation as unsigned number, TC = interpretation as signed/two's complement number)

| **HW**    | **US**  | **TC**  |
|-----------|---------|---------|
| `0100`    | 4       | 4       |
| `+ 0011`  | `+ 3`   | `+ 3`   |
| `-------` | `---`   | `---`   |
| `= 0111`  | 7       | 7       |

| **HW**    | **US**  | **TC**  |
|-----------|---------|---------|
| `1100`    | 12      | -4      |
| `+ 0011`  | `+ 3`   | `+ 3`   |
| `-------` | `---`   | `---`   |
| `= 1111`  | 15      | -1      |

| **HW**    | **US**  | **TC**  |
|-----------|---------|---------|
| `0100`    | 4       | 4       |
| `+ 1101`  | `+ 13`  | `+ (-3)`|
| `-------` | `---`   | `---`   |
| `= 10001-> 0001`| 17 ->1     | 1       |


**Arithmetic Overflow**
- occurs when calculation cannot be represented in current encoding scheme
- We differentiate between unsigned overflow (i.e., result lies outside of [UMin, UMax]) and signed overflow (i.e., result lies outside of [TMin, TMax])

Example:
### Integer Casting
When casting froma `short integer` to a `long integer`, one must extend the old data and pad with zeros
- **Zero extension** pads unsigned data with extra zeros on the left
- **Sign extension** pads signed data using copies of the most significant bit to preserve the sign and value

4-bit to 8-bit Examples:
- **Zero extension**:  
  `0b0111 → 0b00000111`,  
  `0b1111 → 0b00001111`

- **Sign extension**:  
  `0b0111 → 0b00000111`,  
  `0b1111 → 0b11111111`


note: Casting between signed and unsigned doesn’t change the representation of the data, just the interpretation of the data’s value and the effect of certain operators. 

**Mixed Integer Comparison***
When you mix signed and unsigned values in an expression, the signed values are implicitly cast to unsigned.  It will appear as if all operators will default to their unsigned behaviors

| **x**      | **y**      | **comparison** | **x < y** |
|------------|------------|----------------|-----------|
| 0          | 0U         | unsigned       | false     |
| 0000 0000  | 0000 0000  |                |           |
| -1         | 0          | signed         | true      |
| 1111 1111  | 0000 0000  |                |           |
| -1         | 0U         | unsigned       | false     |
| 1111 1111  | 0000 0000  |                |           |
| 127        | -128       | signed         | false     |
| 0111 1111  | 1000 0000  |                |           |
| 127U       | -128       | unsigned       | true      |
| 0111 1111  | 1000 0000  |                |           |

- note: < is just a less boolean expression
- comparison column indicate us what whether it is sign or unsigned that we are comparing (U or no U)

Question to ask: What will `(unsigned) -1 <-2` evaluate to?
- False
    - convert signed to unsigned: for minus 1 and invert 0b0001u gets us 0b111 (decimal value: 15) > minus 1 and invert 0b0010 gets us 0b1110u (decimal value: 14)
### Notes on Signed Representation Conversion

- To convert a signed number in two's complement representation:
  1. **Invert all bits**.
  2. **Add 1** to the inverted result.
  3. The result is the absolute value, and the **MSB (most significant bit)** determines the sign:
     - `0`  -> Positive.
     - `1` -> Negative.

- Examples:
  - `0b01111111`:
    - The MSB is `0`, so it's positive.
    - **Signed value**: `127`.
    - As an unsigned value, it would be `255`.

  - `0b11111111`:
    - The MSB is `1`, so it's negative.
    - To find the signed value:
      1. Invert: `0b00000000`.
      2. Add 1: `0b00000001`.
      3. Apply the negative sign: `-1`.

- **Important**:
  - The MSB indicates the **sign**:
    - `0` means positive.
    - `1` means negative.
  - In two's complement, `0b00000000` is `0`, and `0b11111111` is `-1`.


### Casting in C
The data type of a variable of expression in C determine the data's behavior - their interpreted values as well as the behavior and validity of different operators

**Type casting** in C is the conversion of data of one data type into a different data type
- changes in bit-width: `short` to `int`
- changes in interpretation: `int` to `unsigned int`. `long int` to `char*`
- full changes in representations: `int` to `float`

note: casting long integer numerical type to char* pointer type is not particularly useful; it is just an example

An **implicit cast** is done automatically by the compiler when there is a type mismatch in assignment statement or argument assignment -- between format specifier and arguments in printf
- int x = 7000u; notice how int being ranged from negative to positive is casting the unsigned integer

An **explicit** is performed by (data_type)expression
- it helps to surpass to compiler warnings for implicit casts or forcibly cause changes in interpretation or representation

### Signed vs. Unsigned Integers
- In essence, signed and unsigned are just interpretation of data, not the actual storage of the data being different
    - ex. 0x80  can be interpreted as 128 or -128, but the data storage is still at 0b10000000
- Literals/constants can be given an unsigned data type in C by appending a `u` to the end (e.g., `unsigned char x = 100u`)
```C
#include <stdio.h>
int main() {
  char c = 0x80;
  printf("stored  hex: 0x%hhX\n", c);// stored hex: 0x80
  printf("as unsigned: %hhu\n", c); // as unsigned: 128
  printf("as   signed: %hhd\n", c); // as signed: -128
}
// note: %hhu prints unsigned char as decimal integer; %hhd or %hhi print signed char as decimal integer; %hhx prints unsigned char as hex
```
- A w-bit numeral can only represent 2^w values
    - depending on `T` (two's complement) or 'U` (unsigned) integer, we can define a more variety range with different constraints

- **UMin**: minimum representable value of an unsigned numeral  
- **UMax**: maximum representable value of an unsigned numeral  
- **TMin**: minimum representable value of a signed numeral  
- **TMax**: maximum representable value of a signed numeral  

These values will always have specific encodings:

| Encoding       | Unsigned value           | Signed value           |
|----------------|--------------------------|-------------------------|
| `0b00...0`     | 0 (**UMin**)             | 0                       |
| `0b01...1`     | \(2^{w-1} - 1\)          | \(2^{w-1} - 1\) (**TMax**) |
| `0b10...0`     | \(2^{w-1}\)              | \(-2^{w-1}\) (**TMin**) |
| `0b11...1`     | \(2^w - 1\) (**UMax**)   | -1                      |

note: \your latex\ escape md, which helps with the rendering

Question to ask:
Which of the following 8-bit numerals has a different value as a signed and unsigned number?
- 0x00, 0x40, 0x80, 0xc0
    - Ans:0x80, 0xc0 because 
        - 0x00000000, MSB has no sign
        - 0x0x000000, MSB has no sign
        - 0b10000000, MSB has sign 
        - 0b11000000, MSB has sign 