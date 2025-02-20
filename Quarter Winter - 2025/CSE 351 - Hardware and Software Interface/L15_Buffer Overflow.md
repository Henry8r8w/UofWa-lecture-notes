## In-Lecture 
### Vulnerable Buffer Code
```
void echo() {
    char buf[8]; /* Way too small! */
    gets(buf);
    puts(buf);`
}

void call_echo() {
    echo();
}
```
0000000000401146 <echo>:
401146:  48 83 ec 18       sub    $0x18,%rsp          # Allocate 24 bytes on the stack (local buffer)
40114a:  48 8d 7c 24 08    lea    0x8(%rsp),%rdi      # Load address of buffer (%rsp + 8) into %rdi (argument for gets)
40114f:  b8 00 00 00 00    mov    $0x0,%eax          # Clear %eax (not necessary here)
401154:  e8 e8 fe ff ff    callq  401050 <gets@plt>  # Call gets(), storing user input in (%rsp + 8)
401159:  48 8d 7c 24 08    lea    0x8(%rsp),%rdi      # Load buffer address into %rdi (argument for puts)
40115e:  e8 be fe ff ff    callq  401030 <puts@plt>  # Call puts() to print the stored input
401163:  48 83 c4 18       add    $0x18,%rsp         # Deallocate 24 bytes from the stack
401167:  c3                retq                      # Return to caller

0000000000401177 <call_echo>:
401177:  48 83 ec 08       sub    $0x8,%rsp          # Allocate 8 bytes on the stack (stack alignment)
40117b:  b8 00 00 00 00    mov    $0x0,%eax          # Clear %eax
401180:  e8 c1 ff ff ff    callq  401146 <echo>      # Call the echo function
401185:  48 83 c4 08       add    $0x8,%rsp          # Restore stack pointer
401189:  c3                retq                      # Return to caller


```






```
### String Library Code 1 - 3
Implmentation of Unix function gets()
```
/* Get string from stdin */
char* gets(char* dest) { // dest is the pointer to the start of an array
    int c = getchar();
    char* p = dest;
    while (c != EOF && c != '\n') { // EOF: end of file
            *p++ = c; // store the character in buffer
            c = getchar(); // get the next character
  }
    *p = '\0'; // null-terminator
    return dest;
}

// return type: a pointer to the start of an array
```
- gcc: warning: the 'gets' function is dangerous and should not be used.
    - there is no way to specify limit on number of characters to read
### Why is Buffer Overflow a Problem?
Buffer overflows on the stack can overwrite
“interesting” data
- Attackers just choose the right inputs

Simplest form (sometimes called “stack smashing”)
- Unchecked length on string input into bounded array causes
overwriting of stack data
- Try to change the return address of the current procedure

Why is this a big deal?
- It was the #1 technical cause of security vulnerabilities
    - #1 overall cause is social engineering / user ignorance
### Buffer Overflow 1 - 3 (the [] zone)
Opposite to Stack, that gorws down to lower address, buffer grows up toward higher address

Buffer overflow can overwrite the return address on the stack

### Buffer Overflow in a Nutshell
- C does not check array bounds
    - many unux/linux/c functions don't check argument sizes
    - allow overflowing (writing past the end of buffers)
- Buffer Overflow: writing "past" the end of an array
### What is a buffer?
- def: an array used to temporarily store data
    - it can also store user input

### Memory Layout Example
(Top) Stack -> []
(Buttom) Instruction -> literals -> static data -> heap -> []
```
char big_array[1L<<24]; /* 16 MB */ 

int global = 0;

int useless() { return 0; }

int main() {
    void *p1, *p2;
    int local = 0;
    p1 = malloc(1L << 28); /* 256 MB */
    p2 = malloc(1L << 8); /* 256 B */
    printf("Hello 351!");
    return 0;
}
```
stack: p1, p2, local

heap: malloc(1L << 28),  malloc(1L << 8)

static data: big array, gobal

literal: "Hello 351"

instruction: main(), useless()