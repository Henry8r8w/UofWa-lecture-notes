## Pre-Lecture Reading
### Extension Instructions (`movz` and `movs`)
-  `movz` and `movs` will perform the two types of extension in C
    -  zero extension and sign extension, respectively
Unlike a normal mov instruction that takes one width specifier (i.e., one instruction suffix), the extension instructions require two: the first for the source width and the second for the destination width. 

Example: If 0x80 is currently stored in %al:
- movzbw %al, %bx sets %bx to 0x0080
- movsbw %al, %bx sets %bx to 0xFF80
    - bit to 
- movsbl %al, %ebx sets %ebx to 0xFFFFFF80 and %rbx to 0x00000000FFFFFF80
    - bit (1 byte) to long (4 bytes): 32 - 8 = 24
Visual Representation:
| Instruction       | Source (`%al`) | Destination (`%bx` or `%ebx`) | Explanation                                                                 |
|--------------------|----------------|-------------------------------|-----------------------------------------------------------------------------|
| `movzbw %al, %bx`  | `0x80`         | `0x0080`                      | Zero extension: Upper bits filled with `0`.                                |
| `movsbw %al, %bx`  | `0x80`         | `0xFF80`                      | Sign extension: Upper bits filled with the sign bit (`1`).                 |
| `movsbl %al, %ebx` | `0x80`         | `0xFFFFFF80`                  | Sign extension: Upper 24 bits filled with the sign bit (`1`).              |


Question: If the initial value of %rdi is `0x` `F8F7F6F5` `F4F3` `F2` `F1`, what is its value after executing the following instruction?
```
movesq %di, %rdi
```
- Ans: `0xFFFFFFFF` `FFFFF2F1`
    - The instruction calls for sign-extension (s) from 2 bytes (w) to 8 bytes (q). Since %di (0xF2F1) has an MSB of 1, we copy all 1's into the bits of the upper 6 bytes of %rdi
### Memory Addressing Modes
The most general way to express a Memory operand has 4 parts and the form: D(Rb,Ri,S)
- Displacement D – displacement value (must be an immediate or constant)
- Base register Rb – name of the register whose value will act as the “base” of our address calculation
- Index register Ri – name of the register whose value will be scaled and added to the base
- Scale factor S – scales the value in Ri by the specified number, which can only be 1, 2, 4, or 8

The computed address is Reg[Rb] + S*Reg[Ri] + D, where Reg[] means “the value in the specified register.
- When passed a Memory operand, most instructions will dereference this address.  Dereferencing returns the value stored in memory at address Reg[Rb] + S*Reg[Ri] + D, which we write as Mem[Reg[Rb] + S*Reg[Ri] + D]
    - note: S can only be a 2 power based

Example:  The instruction movb 8(%rax,%rbx,2), %cl will copy ("move") the byte of data stored in memory at address Reg[rax] + Reg[rbx]*2 + 8 into the lowest byte of register %rcx.


**Special Cases**
When any of the parts are omitted, their corresponding default values are:
- D = 0 
- Reg[Rb] = 0
- Reg[Ri] = 0
- S = 1

Examples:
- (%rsi) →Mem[ Reg[rsi] ] 
- 4(%r10, %r11) → Mem[ Reg[r10] + Reg[r11] + 4 ]
- (,%rdx,2) → Mem[ Reg[rdx]*2 ]

Question: In the memory operand `8(%rsp)`, which parts are present?
- D: 8, Rb: Reg[rsp] $\to$ Mem[Reg[rsp]+8]
### x86-64 Registers
A register is a location in the CPU that stores a small amount of data (a word), which can be accessed very quickly
- There are a fixed number of them in every architecture and they are referred to by name
- In x86-64, there are only 16 general purpose registers that the programmer can use.

|8 bytes  | 4 bytes | 2 bytes | 1 byte|
|----------|--------|--------|-------|
| %rax     | %eax   | %ax    | %al   |
| %rbx     | %ebx   | %bx    | %bl   |
| %rcx     | %ecx   | %cx    | %cl   |
| %rdx     | %edx   | %dx    | %dl   |
| %rsi     | %esi   | %si    | %sil  |
| %rdi     | %edi   | %di    | %dil  |
| %rsp     | %esp   | %sp    | %spl  |
| %rbp     | %ebp   | %bp    | %bpl  |


|8 bytes  | 4 bytes | 2 bytes | 1 byte|
|----------|--------|--------|-------|
| %r8      | %r8d   | %r8w   | %r8b  |
| %r9      | %r9d   | %r9w   | %r9b  |
| %r10     | %r10d  | %r10w  | %r10b |
| %r11     | %r11d  | %r11w  | %r11b |
| %r12     | %r12d  | %r12w  | %r12b |
| %r13     | %r13d  | %r13w  | %r13b |
| %r14     | %r14d  | %r14w  | %r14b |
| %r15     | %r15d  | %r15w  | %r15b |

Notice that the register names that refer to the smaller divisions always refer to the least significant bytes of the register (e.g., %ax refers to the lowest two bytes of %rax)

Question: If the register %r15 currently holds the data `0x` `00` `00` `7f` `fc` `c1` `04` `97` `f4`, what value is specified by `%r15w`?
- Ans: 0x 97f4
    - explanation: `%r15w` refers to the lowest two bytes of `%r15`
### x86-64 Operands

The operands for x86-64 assembly instructions can be one of three types:
1. Immediates − constant integer data (look for the prefix '$')
2. Registers − the name of any of the 16 general-purpose registers (look for the prefix '%')
3. Memory − an address in memory (look for parentheses '()', which supersede the '%' that you will find inside of them).  This address is usually dereferenced


For binary instructions (i.e., those that take two operands), these can be used in any combination except:
- You cannot use an Immediate as your destination operand
    - i.e., depending on the instruction, your last operand cannot be an Immediate
- You cannot do a direct memory to memory operation
    - i.e., both operands can’t be Memory.

One of the most commonly-used data transfer instructions is `mov`, which is a binary instruction. It copies ("moves") the value from its source operand to its destination operand.
**Example 1:**  
```
movq $-101, %rax
```  
This will move the 8-byte immediate value `-101` into the register `%rax`.
**Example 2:**  
```
movl %ebx, (%ecx)
```  
This will move the 4 bytes contained in the register `%ebx` into memory at the address specified in `%ecx`.


Question: Which of the following x86-64 assembly instructions have valid operator combinations?  Mark all that apply.

As a reminder, the instruction form we are looking at here is:  `instr src, dst`

Ans: ~~`andb %cl, $351`~~, `cmpw 8(%rsp), %si`, `movl $333, %ebx`, ~~`subq (%rax), (%rdx)`~~
- Explanation:
    - (A) Reg, Imm
        - The `and` instruction stores its result into the second operand, and you cannot store into a constant.  
    - (B) Mem, Reg
        - This is ok!  

    - (C) Imm -> Reg
        - Also ok!  
    - (D) Mem -> Mem 
        - You can't do a direct memory-to-memory operation. Either one of these operands must be changed to a register, or the first operand must be changed to an immediate.  


### x84-64 Instructions
- 0-3 operands, separated by comma
- we uses AT & T syntax and with only two operands in this class
```
instr op # e.g., "negq %rsi" negates the value in %rsi
instr src, dst # e.g., "addq %rdi, %rax" does %rax = %rax + %rdi
```
note: in AT&T syntax, the destination operand is always last

Most x86-64 assembly instructions can be broadly lumped into the following categories:

1. Data transfer -- copying data from one place to a specified location
2. Arithmetic and logical operations
3. Control flow -- affecting which instruction is executed next

Each instruction includes a size specifier letter at the end, describing the size of its operand(s).  The different sizes are:

- b for 1 byte (mnemonic: 'byte')
- w for 2 bytes (mnemonic: 'word', corresponding to the original 8086's word size; this is not the word size of your machine)
- l for 4 bytes (mnemonic: 'long word')
- q for 8 bytes (mnemonic: 'quad word')

So the addb, addw, addl, and addq instructions all perform integer addition, but on different data widths.

Question: Take the instruction `orb (%rsi) , %al`, how much data does this instruction operate on?
- Ans: given orb is the combination of or + b, the size specifier b tells us that the data is stored at 1 byte

Question: Take the instruction `orb (%rsi), %al`, what instruction category does this fall under?
- Ans: Arithmetic and logical operations, ~~Data transfer ~~, Control flow
### Instruction Set Architectures (ISAs)
Components:

The system's **state** -- all of the information that uniquely defines the culmination of past instructions

The **instruction set** -- the list and format of all instructions that the CPU can execute

The **Effect** on the system state of each instruction

Design Philosophy
1. **Complex Instruction Set Computer (CISC)**: Continue to add more and more elaborate and specialized instructions over time as needed. Good for backward compatibility and giving programmers tons of tools to work with, but bad for the hardware designers.

2. **Reduced Instruction Set Computer (RISC)**: Restrict the ISA to a small set of very general instructions. This makes it easier to build hardware, but complex software tasks must now be composed of many smaller instructions.