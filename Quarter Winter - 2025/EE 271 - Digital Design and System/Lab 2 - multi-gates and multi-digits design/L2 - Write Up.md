Circuit Diagram:
- NOT(NAND(NOT(NAND(NOT(SW1), NOT(NAND(SW2, SW3)))), NOT(SW4))) = out
- digit: 0110 (representation: 6)
    - 5 gates (2 NOT, 3 NAND) used, under the condition when inverter connected to an output is free
Extra Credit: simplification of the circuit diagram
- my current circuit is irreducible
    - if we want to simplify the gate, say just using NAND, then we can use it on SW1 AND SW4, but the cost of NAND is the same as NOT

