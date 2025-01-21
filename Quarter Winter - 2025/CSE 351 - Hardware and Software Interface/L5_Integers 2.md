## Lecture Slides
### Sign Extension
### In C: Signed vs. Unsigned
- Casting: Bits are unchanged, just interpreted differently
    - int tx, ty
    - unsigned int ux,uy

explciit casting
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
### Why Does Two's Complement Work?
- For all representable positive integers x, we want:
    - bit representation of x + bit representation of -x = 0 (except the carry-out bit (1))

### Polls