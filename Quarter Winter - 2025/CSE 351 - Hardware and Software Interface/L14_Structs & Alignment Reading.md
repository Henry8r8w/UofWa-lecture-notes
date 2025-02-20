## In Lecture-Slides
### Accessing Struct Members (Review)
```
strucut rec{
    int a[4];
    long i;
    struct rec* next;
}
```
Given a struct instance, access
member using the . operator:
```
struct rec r1;
r1.i = val;
```
Given a pointer to a struct:
```
struct rec* r;
r = &r1;
```
- We have two options:
    - Use * and . operators: (*r).i = val;
    - Use -> operator (shorter): r->i = val;
In assembly:register holds address of the first byte
### Scope of Struct Definition (Review)
Why is the placement of struct definition important?
- Declaring a variable creates space for it somewhere
- Without definition, program doesn’t know how much space
```
// size = 24 bytes
struct data {
    int ar[4];
    long d;
}

// size = 32 bytes
struct rec{
    int a[4];
    long i;
    strucut rec* next;
}
```
Almost always define structs in global scope near the
top of your C file
- Struct definitions follow normal rules of scope
- Top of singular C files, or if using a header file, place there
### Typedef in C (Review)
A way to create an alias for another data type:
typedef <data type> <alias>;
- After typedef, the alias can be used interchangeably with the
original data type

```
typedef unsigned long int uli;
unsigned long int x = 12131989;
uli y = 12131989; // can now use it like this!
```
Joint struct definition and typedef
- Don’t need to give struct a name in this case
```
struct nm{
    /* fields */
};
typedef struct nm name;
name n1;

becomes

typedef struct{
    /* fields */
} name;
name n1

```
### Struct Definitions (Review)
Struct definition:
- Does NOT declare a variable
- Tells compiler we’re defining it and
- will be using instances of it
- Variable type is “struct name”

Variable declarations like any other data types:
```
struct name name1; // instance
struct name* pn; // pointer
struct name name_ar[3]; //array
```
Or they can be combined into a struct and instance definitions
```
struct name {
/* fields */
} st, *p = &st; // varibales st and pointer declared cor. st
```
### Structs in C
User-defined structured group of variables, possibly including
other structs
- Similar to Java object, but no methods nor inheritance; just fields
- Way of defining compound data type

```
struct song {
    char* title;
    int lengthInSeconds;
    int yearReleased;
};
struct song song1;
song1.title = "DDU-DU DDU-DU";
song1.lengthInSeconds = 211;
song1.yearReleased = 2018;

struct song song2;
song2.title = "Boy with Luv";
song2.lengthInSeconds = 230;
song2.yearReleased = 2019;


```
## Pre-Lecture Reading
### Struct Layout
**Alignment (Review)**
- a primitive object of size K bytes in memory is considered aligned if its address is a multiple of K.

**Struct Layout**
The size and layout of a struct instance in C is automatically determined by the compiler following strict rules set by:
1. the user-defined ordering of the struct fields and
2. alignment requirements.

**Internal Fragmentation**
- Def: padding, to ensure aligment, in between fields that are unused 

```
struct ex1 {
  short s;
  int   i;    //  2B  2B  4B
} instance1;  // [s ][__][i   ]
```
- If instance1 (theoretically) started at address 0x0, then &instance1.s would be 0x0 (multiple of 2), but there would be 2 bytes of padding before &instance1.i = 0x4 (multiple of 4).
    - the padding are multiplied by the sizeof(datatype) that we deal with
    - thus, s being short has 2  and i being int has 4
**External Fragmentation**
def: additional padding is added, if necessary, to the "en" of the struct to make the size of the struct a multiple of K_max. The unused space between struct instances is knwon as external fragmentation
```
struct frag {
  char  c;
  int   i[3];
  struct frag *p;
  short s;
} f, *fp = &f;  // pointer fp holds the starting address of instance f
```

Question: How many bytes of space does an instance of the following strucut take up?
```
struct q1 {
  int   i;
  short s[3];
  char* c;
  float f;
};
```
- Given K_i = 4 at offset at 0, K_s = 2(*3) offset at 4, K_c = 8 (pointer) offset at 16 (due to 6 bytes of internal fragmentation), K_f = 4 at offset 24, K_max = 8 so we pad out from 28 to 32 (4 bytes of external fragmentation)
- we detmein aligment requirement based on what comes first, which one should refernce to the K_{x} = # as the offerset to look at; the K_max gets updated after hte previous one is smaller
### Tyepdef in C
typedef (def): combined data type names of struct struct_tag
```
typedef unsgined int uint; // typedef <data type> <alist>;
```
For structs, a typedef statement can be used after or combined with the struct definition to make a more manageable data type:

```
// typedef after definition
struct point_st {
  int x;
  int y;
};
typedef struct point_st Point;
Point pt1;

// typedef combined with definition
typedef struct {  // tag now optional
  int x;
  int y;
} Point;
Point pt1;
```
### Structs in C
A struct in C is a user-defined, structured group of variables. A struct definition is formatted as:
```
struct struct_tag {
  type_1 field_1;
  ...
  type_N field_N;
};                                // define the struct type

struct struct_tag my_struct_var;  // declare a struct variable instance; struct datatype struct_var
```
- the struct name can only be used in code after the struct definition

The purpose of the struct definition is so that your compiler/program knows the size and layout of an instance of the struct. A struct holds an arbitrary collection of struct fields of different variable types.

Fields are accessed from an instance using the ‘.’ operator (e.g., pt.x) or from a pointer by either (1) dereferencing and using ‘.’ or (2) using the ‘->’ operator (i.e., ptr->y is equivalent to (*ptr).y).

Question: How many bytes will an instance of `struct rec` take
```
struct rec {
   int a[4];    // 4 int fields ontribute to 4*4 = 16 bytes
   long i;      // long i field contribute to 8 bytes
   struct rec* next; // pointer contirbute the 8 bytes
};
```
- Ans: struct rec will take 32 bytes