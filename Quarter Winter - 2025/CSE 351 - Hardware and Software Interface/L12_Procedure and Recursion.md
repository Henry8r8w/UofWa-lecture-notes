## In Lecture 
### Recursion Function
### x86-64 Linux Registers - callee saved
%rbx, %r12, %r13, %r14, %r15
- Callee-saved
- Callee must save & restore

%rbp
- Callee-saved
- Callee must save & restore
- May be used as frame pointer
- Can mix & match

%rsp
- Special form of callee save
- Do not need to explicitly save
- But should be restored to original value 
upon exit from procedure (i.e. should point 
to return address when ret is executed)
### x86-64 Linux Registers - caller saved
%rax
- Return value
- Also caller-saved & restored
- Can be modified by procedure

%rdi, ..., %r9
- Arguments
- Also caller-saved & restored
- Can be modified by procedure

%r10, %r11
-  Caller-saved & restored
-  Can be modified by procedure
### Register Saving Conventions
whoa is the caller

who is the callee

Register can be used for temparory storage
```
whoa:
  • • •
  movq $15213, %rdx
  call who
  addq %rdx, %rax
  • • •
ret

who:
  • • •
  subq $18213, %rdx
  • • •
ret

// notice how callee may overwrite callee %rdx
```
Thus, either
- Caller should save %rdx before the call  (and restore it after the call)
- Callee should save %rdx before using it  (and restore it before returning)
### Procedure Call Example
```
long call_incr() {
  long v1 = 351;
  long v2 = increment(&v1, 100);
  return v1 + v2;
}

call_incr:
  subq $16, %rsp
  movq $351, 8(%rsp)
  movl $100, %esi
  leaq 8(%rsp), %rdi
  call    increment
  addq 8(%rsp), %rax
  addq $16, %rsp
  ret

increment:
  movq (%rdi), %rax # x = *p
  addq %rax, %rsi # y = x + 100
  movq %rsi, (%rdi) # *p = y
ret

```
After

Register Use(s)
%rdi     &v1
%rsi     451
%rax     802

### Example Increment
Registers: %rdi (1st arg/ p), %rsi (2nd arg/val, y), %rax(x/return value)

```
long increment(long *p, long val) {
  long x = *p;
  long y = x + val;
  *p = y;
  return x;
}


increment:
  movq (%rdi), %rax
  addq %rax, %rsi
  movq %rsi, (%rdi)
ret
```
### x86-64/Linux Stack Frame
Caller Stacj Frame (blue)
- extra arguments (if > 6 args) for this call
Return Addr

Current/Callee Stack Frame (red)
- Return address
  - Pushed by call instruction
- Old frame pointer (optional)
- Saved register context
(when reusing registers)
- Local variables
(If can’t be kept in registers)
- “Argument build” area
(If callee needs to call another function -
parameters for function about to call, if 
needed)

### Poll Question 1
```
\\ Caller
int main() {
  int i, x = 0;
  for(i=0;i<3;i++)
    x = randSum(x);
  printf("x = %d\n",x);
  return 0;
}

\\ Callee
int randSum(int n) {
  int y = rand()%20;
  return n+y;
}
```
- Lower on the stack/numerically larger address: x
- How many total stack frames created: 6 (3 contributed by loop, multiplby 2 contributed the randSum, 1 contributed to the return)
- Max depth (# of frames) of the Stack: 3
  - note: stack grows to three, then shrink down to one


Recursion Demo: pcount.c
```
/* pcount.c
 * For use in CSE351 Lec 11 on Recursion
 *
 * Intended for use with a gdb demo:
 * gcc -Wall -std=c18 -g -O1 -o pcount pcount.c
 */

#include <stdio.h>
#include <stdlib.h>

long pcount_r(unsigned long x) {
  if (x == 0)
    return 0;
  else
    return (x & 1) + pcount_r(x >> 1);
}

int main(int argc, char* argv[]) {
  if (argc != 2) {
    printf("Usage:  pcount <number>\n");
    exit(0);
  }
  long x = atoi(argv[1]);
  printf("There are %ld 1's in %ld\n", pcount_r(x), x);
  return 0;
}
```

## Pre-Lecture Reading
### Recursion
As each recursive call is made, a new stack frame is created to hold that instance’s local procedure context and the register saving conventions will prevent each instance from corrupting each other’s data.

Example (Factorial)
```
0000000000401126 <fact>:
  401126:   mov    $0x1,%eax
  40112b:   cmp    $0x1,%rdi
  40112f:   ja     401132 <fact+0xc>  # jump if n-1 > 0 (unsigned)
  401131:   retq                      # return from base case
  401132:   push   %rbx               # store old %rbx
  401133:   mov    %rdi,%rbx          # move n into %rbx
  401136:   lea    -0x1(%rdi),%rdi    # decrement n
  40113a:   callq  401126 <fact>      # recursive call
  40113f:   imul   %rbx,%rax          # compute n * fact(n-1)
  401143:   pop    %rbx               # restore %rbx
  401144:   retq                      # return from recursive case

```

From the assembly code, we see that the only instructions that store data on the stack are push %rbx (0x401132) and callq fact (0x40113a), and that the return address for a recursive call to fact is 0x40113f.

If main calls fact(3), this will make two recursive calls and three fact stack frames overall (fact(3)→fact(2)→fact(1)).  Each stack frame will hold an independent procedure context:

```
           HIGHER ADDRESSES
main    |       . . .        |
         --------------------
fact(3) | <ret addr to main> |
        |   <main's %rbx>    |
         --------------------
fact(2) |      0x40113f      |
        |         3          |
         --------------------
fact(1) |      0x40113f      |
         --------------------
          "TOP" OF THE STACK
```


Code trace:
1. `fact(3)`'s stack frame will start with the return address of its caller, `main`.
2. `0x40112f`: this isn't a base case, so jump.
3. `0x401132`: push the old value of `%rbx`, which is whatever value `main` had stored there, onto the stack.
4. `0x401133`: store the value of `%rdi` (the 1st argument = `n = 3`) in `%rbx`.
5. `0x401136`: decrement `n` in preparation for the recursive call `fact(n-1)`.
6. `0x40113a`: the recursive call to `fact` pushes its return value onto the stack, which starts `fact(2)`'s stack frame.
7. `0x40112f`: this isn't a base case, so jump.
8. `0x401132`: push the value of `%rbx`, which we know is `3` (from step #4).
9. `0x401133`: store the value of `%rdi` (the 1st argument = `n = 2`) in `%rbx`.
10. `0x401136`: decrement `n` in preparation for the recursive call `fact(n-1)`.
11. `0x40113a`: the recursive call to `fact` pushes its return value onto the stack, which starts `fact(1)`'s stack frame.
12. `0x40112f`: this *is* a base case, so don't jump (*i.e.*, return).
13. We will start going back up the stack frames, popping off older values of `n` to use in the `n × F(n - 1)` computation.

Question: In a recursive case of fact(n), how is n being saved?
- In a callee-saved register
    - n is stored in %rdi and we see this value getting copied into %rbx at 0x401133.  Although we see some form of n being pushed onto the stack at 0x401132, it is the previous stack frame's n.
### x86-64 REgister Saving Convention
### Stack Frame
The return address, which is pushed onto the stack by the call instruction, marks the beginning of the stack frame.

Older assembly code used %rbp as the frame pointer, an indicator of the beginning of the current stack frame. The old value of %rbp would need to be saved if it is being used as a frame pointer, but this is considered optional in x86-64.

Old register values that needed to be saved would be pushed (discussed in the "Register Saving Conventions" slide), followed by allocated space for local variables that aren’t being stored solely in registers.

Finally, if this procedure calls another procedure, it may need to push more register values and then arguments 7+ onto the stack

Every stack frame is organized the same way, though each frame can be a different size and will omit parts that it doesn’t need since accessing the stack (in memory) is much slower than registers. So, if the callee procedure in the diagram had more than six arguments, arguments 7+ would be part of the caller’s argument build area just above the stored return address.

Question:
If a procedure (the callee) takes 7 arguments, which part of the stack will that argument be found?
- Caller's argument build
    - Because arguments 7+ are put on the stack before call is executed, they appear on the stack above the return address that starts the callee's stack frame.