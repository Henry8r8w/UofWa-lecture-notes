
#include <stdio.h> // standard input/output library (sourced prinf())
#include <stdlib.h> //standard library (sourced atoi)

void print_operation(int a, char operator, int b); // forward declaration, type checking

int main(int argc, char **argv)
{
    // We want three arguments along with function_name (function_name | arg1 | ... | arg3 | '\0')
    if (argc != 4)
    {
        printf("Usage: ./calculator operand1 operator operand2\n");
        return 1; // error exit
    }
    
    // atoi() converts strings to integers 
    int a = atoi(argv[1]);
    int b = atoi(argv[3]);

    // Grab the first character [0] of the third argument/ second parameter [2]
    char operator = argv[2][0];

    print_operation(a, operator, b);

    return 0; // success exit
}

/* Prints out the result when the operator is applied to the 
 * operands a and b. Supports addition (+), subtraction (-),
 * multiplication (x). Can you add division (/)? 
 * What happens when you divide by 0? Can you avoid that? */
void print_operation(int a, char operator, int b)
{
    int result = 0;
    switch(operator)
    {
        case '+':
            result = a + b;
            break;
        case '-':
            result = a - b;
            break;
        case 'x':
            result = a * b;
            break;
        case '%':
            if (b == 0){
                printf("Modulo by 0 is not a valid input\n");
                return;// immediate exit
            }
            result = a % b;
            break;
        case '/':
            if (b ==0){
                printf("Division of 0 is a not valid input\n");
                return;// immediate exit
            }
            result = a / b;
            break;
        default:
            printf("Invalid operator");
            return; // immediate exit
    }
    printf("%d %c %d = %d\n", a, operator, b, result);

}

/* 
Use Cases:
After you compiled this C file with gcc -Wall -g -std=c18 -o calculator section1_calculator.c,
you should have 'calculator' in your directory. Use ./calculator operand1 operator operand2 to execute the program
*/