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