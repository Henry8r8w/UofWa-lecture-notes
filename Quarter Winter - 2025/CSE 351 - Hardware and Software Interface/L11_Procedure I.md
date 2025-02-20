## In Lecture Slides
### x86-64/Linux Stack frames

#### **Stack Frame Structure**
A stack frame is allocated for each function call and follows the **Last In, First Out (LIFO)** principle.

#### **Caller’s Stack Frame**
- Stores **extra arguments** (if more than 6 arguments).
- The caller’s frame remains on the stack while the callee executes.

#### **Current (Callee) Stack Frame**
- **Return Address**: Stored on the stack when `call` is executed.
- **Old Frame Pointer** (`%rbp`, optional): Used for stack frame tracking.
- **Saved Registers**: Preserves register values if they need to be reused.
- **Local Variables**: Stored in the stack if they can't fit in registers.
- **Argument Build Area (Optional)**: Used if the function calls another function and needs space for passing parameters.

#### **Stack Growth**
- The stack **grows downward** in memory (`%rsp` moves to lower addresses).
- The **frame pointer (`%rbp`)** helps access previous stack frames but is optional in modern compilers.



 **Stack Layout (Top to Bottom)**
| Stack Section | Description |
|--------------|-------------|
| **Caller’s Frame** | Stores previous function's data. |
| **Arguments 7+** | Extra arguments beyond 6 passed via registers. |
| **Return Address** | Address to return to after function finishes. |
| **Old `%rbp` (Optional)** | Previous frame pointer, used for stack navigation. |
| **Saved Registers + Local Variables** | Preserves registers and local function variables. |
| **Argument Build  `%rsp`(Optional)** | Space for preparing function call arguments. |

### Call-Chain Example
```
whoa(...){ // whoa
    ...
    who(); //who
    ...
}
who(...){
    ...
    amI(); // amI_1
    ...
    amI(); // amI_2
}

amI(...){
    ...
    if(...){
        amI  // amI_3
    }
    ...
}   

Chain
whoa -> who -> (amI_b1, amI_b2)
(amI_b1,)-> am_I -> am_I
``` ()
Stack: [] - whoa - who - amI_1 - amI_2 (%rbp) - amI_3 (%rsp)
### Stack-Based Languages
Languages that support recursion
- e.g. C, Java, most modern languages
Recursion requires re-entrant code, meaning each call must have its own memory space.

Function calls use stack frames to store local variables, arguments, and return addresses.

Stack grows and shrinks dynamically as functions are called and return.

The stack discipline ensures that the most recent function call completes before earlier ones.

Stack discipline
- State for a given procedure needed for a limited time
    - Starting from when it is called to when it returns
- Callee always returns before caller does
### x86-64 Return Values
By convention, values returned by procedures are
placed in %rax
- Choice of %rax is arbitrary
1. Caller must make sure to save its contents of %rax
before calling a callee that returns a value
- Part of register-saving convention
2. Callee places return value into %rax
- Any type that can fit in 8 bytes - integer, float, pointer, etc.
- For return values greater than 8 bytes, best to return a
pointer to them
3. Upon return, caller finds the return value in %rax
### Procedure Control Flow (Review)
- Use stack to support procedure call and return
- Procedure call: call label
    1. Push return address on stack (why? which address?)
    2. Jump to label
- Return address 
    0 address of sintruction immedaly after **call** Instruction
```
400544:    call    400550 <mult2> # Call mult2(x, y), result stored in %rax
400549:    movq    %rax, (%rbx)  # Store result from %rax into memory at address in %rbx
```
Procedure return: ret
1. Pop return address from stack
2. Jump to address
### Code Example
```
0000000000400550 <mult2>:
400550:    movq    %rdi, %rax    # Move first argument (a) from %rdi to %rax
400553:    imulq   %rsi, %rax    # Multiply second argument (b) in %rsi with %rax (a * b)
400557:    ret                    # Return the result in %rax

0000000000400540 <multstore>:
400540:    push    %rbx          # Save %rbx (callee-saved register)
400541:    movq    %rdx, %rbx    # Save third argument (dest) in %rbx
400544:    call    400550 <mult2> # Call mult2(x, y), result stored in %rax
400549:    movq    %rax, (%rbx)  # Store result from %rax into memory at address in %rbx
40054c:    pop     %rbx          # Restore %rbx
40054d:    ret                   # Return
```

```
long mult2(long a, long b) {
    long s = a*b;
    return s;
}


void multstore(long x, long y, long *dest) {
    long t = mult2(x, y); // Call mult2(x, y)
    *dest = t;            // Store the result in memory at address dest
}

```
Here is the C code corresponding to the given assembly:

### **C Code for `mult2`**
```c
long mult2(long a, long b) {
    return a * b;
}
```
- This function takes two `long` integers (`a` and `b`).
- It returns their product (`a * b`).
- The result is returned in register `%rax` in assembly.

---

### **C Code for `multstore`**
```c
void multstore(long x, long y, long *dest) {
    long t = mult2(x, y); // Call mult2(x, y)
    *dest = t;            // Store the result in memory at address dest
}
```
- This function takes two `long` integers (`x` and `y`) and a pointer `dest` where the result should be stored.
- It calls `mult2(x, y)` to compute the product.
- It stores the result at the memory location pointed to by `dest`.

---


| C Code | Assembly Equivalent |
|--------|---------------------|
| `long t = mult2(x, y);` | `call 400550 <mult2>` |
| `*dest = t;` | `movq %rax, (%rbx)` (storing result at `dest`) |
| Saving/restoring registers | `push %rbx` / `pop %rbx` |


### Procedure Call Overview
Callee must know where to find args

Callee must know where to find return address

Caller must know where to find return value

Caller and Callee run on same CPU, so use the same registers
- How do we deal with register reuse?

Unneeded steps can be skipped (e.g. no arguments)

note: caller (set up args, clean args, return val) calls callee (create local var, set up retunr val, destroy local var, ret)
### x86-64: Pop
- popq dest
    - load value at address given by %rsp
    - store value at dest
    - Increment %rsp by 8 , moving to the top / "Stack Buttom"
Ex. popq %rcx
- stores contents of "Stack Top" / value(%rcp) into %rcx and adjust %rsp
### x86-64 Stack: Push
- pushq src
    - Fetch operand at src
        - Src can be reg, memory, immediate
    - Decrement %rsp by 8, moving to the buttom / "Stack Top"
    - Store value at address rendered by %rsp
Ex. pushq %rcs
- adjust %rcp (to keep %rcp always at the buttom / "Stack Top") and store contents of %rcs on the stack

### x86-64 Stack (grows from from down to top)
- Register %rsp contains
lowest stack address
    - %rsp = address of top element, the most-recently-pushed item that is notyet-popped
### Simplified Memory Layout

Address Space
- Low Address (0x0...0)  to  High Address (0xF...F)

Who contains in here
- Instruction (program code), literals (constants), static data (static and the global var), dyanmic data (heapd; var allocated by new or malloc) ->, [    ], <- stack (local varaibles and procedure context)

Reponsibility
- Managed statically (initalized when process starts), Managed statically (initalized when process starts), Managed statically (initalized when process starts), Managed dynamically  (by programmers) ->, [    ], <- Managed automatically (by compilter/assembly)

Permission
- read only;executable, read only; not executable, writable; note exeacutable, writable' not exectuables ->, [   ], <- writeable; not executable

Segemnetaiton faults (def): impermissible memory 

### Poll
How does the stack change afteer executing the following Instruction
```
pushq %rbp
subq $0x18, %rsp
```
- rbp going to pushed into stack, where rsp should leave the space for (decremnet by 8 bytes)
- in our case tho, the subtraction is done by 24 bytes (0x 1*1^16 + 8* 16^0)
- therefore: 8 bytes from rbp + 24 bytes from rsp will result a change in 32 bytes

For the following function, which registers do we
know must be read from/written to?

```c
void* memset(void* ptr, int value, size_t num);
```
According to the **System V AMD64 ABI** (used in Linux and macOS), the first six integer or pointer arguments are passed in registers as follows:

| Argument  | C Type      | Register |
|-----------|------------|----------|
| `ptr`     | `void*`    | `%rdi`   |
| `value`   | `int`      | `%rsi`   |
| `num`     | `size_t`   | `%rdx`   |

Additionally:
- The function returns `ptr`, which means the return value is stored in **`%rax`**.
Why These Registers Must Be Used
- `%rdi` **must** be read (holds the destination pointer).
- `%rsi` **must** be read (holds the value to be set).
- `%rdx` **must** be read (holds the number of bytes to write).
- `%rax` **must** be written to (holds the return value, which is the pointer `ptr`).


