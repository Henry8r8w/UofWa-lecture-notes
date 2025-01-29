## Lab 3
**Instruction: write a sv code for identifying an return item being discounted? and stolen?**

Following the bit pattern in the following table

| Item Name          | UPC Code | Discounted? | Expensive? |
|--------------------|---------|-------------|------------|
| Shoes            | 0 0 0   | Yes         | Yes        |
| Costume Jewelry  | 0 0 1   | Yes         | No         |
| Christmas Ornament | 0 1 0 | No          | No         |
| Business Suit    | 1 0 1   | No          | Yes        |
| Socks           | 1 1 0   | Yes         | No         |
| Winter Coat     | 1 1 1   | No          | Yes        |

you should see how 3'bXXX correspond to each logic condition (discounted?, expensive?). Having 2 K- Maps to perform your logic reduction based on discounted? and the expensive*Not(M)?/Stolen? result. 
Once the reduction logic obtained, convert the logic into a systemervilog assign statement with 2 LED lights to indicate the result of the 2 logics. Provide the physical result and the simulation from ModelSim to TA; draw down the simplified circuit.

note: with expensive? logic, there is actually another mark (M) bit condition -- when a expensive item has no original mark received from the return item, we consider it stolen -- where it is not specified in the table from the lab 3 instruction. Therefore, one actually need to draw one 4 variable K-Map on top of the expensive 3 bits logic

**My Solution**

Discounted? LED[0]

| UP \ C | 0  | 1  |
|--------|----|----|
| **00** |  1  |  1  |
| **01** |  0  | x   |
| **11** |  1  | 0   |
| **10** |  x  |  0  |

We group the 
- 11 from U_0 P_0 and C_0 $\to$ C_1 together
- 1 from U_1 P_1 and C_0 together

Simplified logic: D = NOT(U)* NOT(P) + U * P * NOT(C)


Stolen? LED[1]
| UP \ CM | 00  | 01  | 11  | 10  |
|---------|-----|-----|-----|-----|
| **00**  |  1   |     |     |     |
| **01**  |     |     |     |     |
| **11**  |     |     |     |  1   |
| **10**  |     |     |     |  1   |

We group the 
- 1 from U_0 P_0 and C_0 M_0  together
- 11 from U_1 P_1 C_1 M_0 and U_1 P_0 C_1 M_0 together $\to$ C_1 M_0 U_1

Simplified logic: S = NOT(U) * NOT(P) * NOT(C) * NOT(M) + C * NOT(M) * U

ModelSim



notice how the activation of LED[1] correspond to the of discount UPC, and the activation of LED[1] correspond to the expensive UPC code and NOT(M)