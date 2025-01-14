### Endianess

In a computer, data are moved and manipulated in a *fixed-lentgh chunks*. meaning that leading zeros may be required to represent the full extent of the data
- the left most bit is referred as the **most-significant bit (MSB)**
- the right most bit is referred the **least-significant bit (LSB)**

Endianness only applies to memory storage, as multibyte data in memory span multiple addresses

Often programmer can ignore endianness because it 
is handled for you
- Bytes wired into correct place when reading or storing from 
memory (hardware)
- Compiler and assembler generate correct behavior (software)

Endianness still shows up:
- Logical issues:  accessing different amount of data than how 
you stored it (e.g. store int, access byte as a char)
- Need to know exact values to debug memory errors
- Manual translation to and from machine code (in 351)



### Byte Ordering (Review)
#TODO: insert draw.io
How should bytes within a word be ordered in 
memory?
- Want to keep consecutive bytes in consecutive addresses
- Example: store the 4-byte (32-bit) int: 0x A1 B2 C3 D4

By convention, ordering of bytes called endianness
- The two options are big-endian and little-endian

Big-endian (SPARC, z/Architecture)
- Least significant byte (verify by checking the hex) has highest address
Little-endian (x86, x86-64)
- Least significant byte (verify by checking the hex)  has lowest address
Bi-endian (ARM, PowerPC)
- Endianness can be specified as big or little

Note:  leftmost lowest memory address/element value, vice versa

Question1: If we store the value 2 in 4 bytes at address `0x30` on a little-endian machine, what is the address of the byte `0x02`
- 0x30

Question2: Assume that a snippet of memory is shown below (in hex), starting with the byte at address 0x10 on a little-endian machine
```
addr:  0x10  0x11  0x12  0x13  0x14  0x15  0x16  0x17
data:  | 77 | AB | 69 | CA | 0D | F0 | 12 | BE |
```
What is the value of the hosrt stored at address `0x14`?

- 0xF00D since we are ordering by little-endian with a 2 byte short starting from 0x14

### Addresses and Pointers
- An address refers to a location in memory
- A pointer is a data object that holds an address
    - Address can point to any type of data (e.g., values, addresses)

Say, you have a value 504 stored at address 0x08
- 504_{10} = 1F8_{16} hex by (int((504%16) // 16) % 16)(int(504 // 16) %16)(504 % 16)

- note: for any %16 of above 9, you must report the alphabet of the hex
### A Picture of Memory (64-bit view)

Memory Layout (One Word = 8 Bytes):

| Address |  Byte 0  |  Byte 1  |  Byte 2  |  Byte 3  |  Byte 4  |  Byte 5  |  Byte 6  |  Byte 7  |
|---------|----------|----------|----------|----------|----------|----------|----------|----------|
| 0x00    |   0x00   |   0x01   |   0x02   |   0x03   |   0x04   |   0x05   |   0x06   |   0x07   |
| 0x08    |   0x08   |   0x09   |   0x0A   |   0x0B   |   0x0C   |   0x0D   |   0x0E   |   0x0F   |
| 0x10    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |
| 0x18    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |
| 0x20    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |
| 0x28    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |
| 0x30    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |
| 0x38    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |
| 0x40    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |
| 0x48    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |   ...    |

- **Address** represents the starting address of each word in memory.
    - Each row represents 8 bytes of memory (a "word").
    - Each column in the row (cell) represents one byte within that word.
    - It is often to use hex (base 16) to represent address

- Every address is then of the form 0b____, with each space/blank being either a 0 or a 1. We can see that there are $2^4 = 16$ total addresses (0b0000, 0b0001, 0b0010,..., 0b1110, 0b1111), and each one refers to 1 byte of data , so this address space will be 16 bytes

### Alignment of Multibyte Data
The address of a chunk of memory is considered aligned if its address is a multiple of its size

### Address of Multibyte Data
Addresses still specify locations of bytes in memory, but we can choose to view memory as a series of chunks of fixed-sized data instead
- Addresses of successive chunks differ by data size

The address of any chunk of memory is given by the address of the first byte (the lateral concatenated chunks attribute none to the address); we usally check on the MSB and LSB to refer to data along with size information
-  Thus, to specify a chunk of memory, need both its **address** and its **size**

### Data Representations
Size of data types in bytes

| Java Data Type | C Data Type  | 32-bit (old) | x86-64 |
|----------------|--------------|--------------|--------|
| boolean        | bool         | 1            | 1      |
| byte           | char         | 1            | 1      |
| char           | char         | 2            | 2      |
| short          | short int    | 2            | 2      |
| int            | int          | 4            | 4      |
| float          | float        | 4            | 4      |
| long int       | long int     | 4            | 8      |
| double         | double       | 8            | 8      |
| long           | long long    | 8            | 8      |
| long double    | long double  | 8            | 16     |
| (reference)    | pointer *    | 4            | 8      |


To use "bool" in C, you must `#include <stdbool.h>`

### Machine 'Words' (Review)
Instructions encoded into machine code (0’s and 1’s)
- Historically (still true in some assembly languages), all instructions were exactly the size of a word

We have chosen to tie word size to address size/width
- word size = address size = register size
- word size = w bits $\to 2^w$ addresses


X86 systems use 64-bit (8 bytes) words
- Pontetial address space:$2^{64}$ addresses
    - $2^{64}$ bytes $\approx$ 18billion bytes = 18EB (exabyte)
    - In current reailty only 48 bits -> 2^{48} bytes memory is supported by hardware 
### An Address Refers to a Byte of Memory
Conceptually, memory is a single, large array of bytes,
each with a unique address (index) 
- Each address is just a number represented in fixed-length binary

Programs refer to bytes in memory by their addresses
- Domain of possible addresses = address space
- We can store addresses as data to “remember” where other data is in 
memory

But not all values fit in a single byte (e.g. 351 ->101011111), a group of 8 bits
### Binary Encoding
- $2^N = n$, where n is the things N-binary can represent
- A group of 4 bits (1 hex digit) is called a nibble
- A group of 8 bits (2 hex digits) is called a byte

Given b^n as your encoding size where b is the base and n is the num of bit representation, you should notice 
- b is in range of symbol with [0: b -1]
- n is the number of X in the 0bXXX (in this case, n = 3)
### Fixed-Length Binary (Review)
-Becasue storage is finite in reailty, everything is stored as 'fixed' length
    - Data is moved and manipulated in fixed-length chunks
    - Multiple fixed lengths (e.g. 1 byte, 4 bytes, 8 bytes)
    - Leading zeros now must be included up to “fill out” the fixed 
Example:
- eight bit: 0b00000100, where hte bit[7] is the Most Siginifcnat Bit (MSB) and bit[0] is the Least Signifncant Bit (LSB)
- $\text{MSB} \rightarrow 0000 0000 0000 0101_{2} \leftarrow \text{LSB}$

Example: if we store the 4 byte-data `0xA1B2C3D4` at address `0x100`
Big-endian:

| Address  | 0x100 | 0x101 | 0x102 | 0x103 |
|----------|-------|-------|-------|-------|
| Data     | **A1** | **B2** | **C3** | **D4** |

Little-endian:

| Address  | 0x100 | 0x101 | 0x102 | 0x103 |
|----------|-------|-------|-------|-------|
| Data     | **D4** | **C3** | **B2** | **A1** |
### Hardware: 351 View
To execute an instruction, the CPU must:
1.Fetch the instruction
2.(if applicable) Fetch data needed by the instruction
3.Perform the specified computation
4. (if applicable) Write the result back to memory


More CPU details:
- Instructions are held temporarily in the instruction cache
- Other data are held temporrairly in registers

#TODO: insert draw.io for cpu -> memory
### Memory, Data, and Addressing
Representing information as bits and bytes
- Memory is a byte-addressable array
- In machine: “word” size = address size = register size

Organizing and addressing data in memory
- Endianness –ordering bytes in memory
- Manipulating data in memory using C
    - Boolean algebra and bit-level manipulations



### Adminstrivia
Readings should be done at 11am
Lecture activites (RD, LC) should be completed by 11am of the following lecture day