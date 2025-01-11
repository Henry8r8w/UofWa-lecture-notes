
### Lab 0

int* initialzaiton is used take on address for &value, which allows us access the address of a value


%d: format specifer used in printf to include the output decimal

%s: format specifer used in printf to include the output string

%p: fomrat specifer used in printf to print the adddress of stored pointer varaible
- to declare/access a pointer, use *pointer; to get the varaible assign to the pointer use &value

```c
// Declare: 


// Access: this exmaple give you student is an array of 4 elements
(int*) &student[3] // this allow you to access the address of the student and into the fourth index of the array
```
%i: a format specifier used in printf to work with int

%li: a format specifier used in printf to work with long integer
- ex. we want produce a a - b result:
    - printf('string of expression =  %format_specifier \n", a operator b)
    - printf('A - B  =  %li \n", a -  b) given a =  0x7ffe3ebbf9ec, b = 0x7ffe3ebbf9e8
    - output: a - b  = 1

note: long int (or just long) is a data type that stores int but require a wider range of values to compared to just int