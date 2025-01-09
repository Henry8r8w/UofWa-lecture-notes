### Endianess

Endianness only applies to memory storage

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
- Least significant byte has highest address
Little-endian (x86, x86-64)
- Least significant byte has lowest address
Bi-endian (ARM, PowerPC)
- Endianness can be specified as big or little

### Addresses and Pointers
- An address refers to a location in memory
- A pointer is a data object that holds an address
    - Address can point to any type of data

Say, you have a value 504 stored at address 0x08
- 504_{10} = 1F8_{16} hex by (((504%16) %16)&16)((504%16) %16)(504 % 16)
- your pointer stored at 0x38 points to address 0x08
    -note: you pointer can also be pointed by another pointer
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


### Alignment of Multibyte Data
The address of a chunk of memory is considered aligned if its address is a multiple of its size

### Address of Multibyte Data
Addresses still specify locations of bytes in memory, but we can choose to view memory as a series of chunks of fixed-sized data instead
- Addresses of successive chunks differ by data size

The address of any chunk ofmemory is given by the address of the first byte (the lateral concatenated chunks attribute none to the address)
- To specify a chunk of memory, need both its **address** and its **size**

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

### Fixed-Length Binary (Review)
-Becasue storage is finite in reailty, everything is stored as 'fixed' length
    - Data is moved and manipulated in fixed-length chunks
    - Multiple fixed lengths (e.g. 1 byte, 4 bytes, 8 bytes)
    - Leading zeros now must be included up to “fill out” the fixed 
Example:
- eight bit: 0b00000100, where hte bit[7] is the Most Siginifcnat Bit (MSB) and bit[0] is the Least Signifncant Bit (LSB)
- $\text{MSB} \rightarrow 0000 0000 0000 0101_{2} \leftarrow \text{LSB}$
- If we store the 4-byte data 0xA1B2C3D4 at address 0x100
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
# TODO: insert draw.io for cpu -> memory
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