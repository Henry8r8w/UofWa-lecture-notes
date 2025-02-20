
## Character sets and backreferences
```
grep iE [abcde] password.txt // [] performs same as using |
grep iE [a-z] password.txt // ask a to z character, 0 - 9; applies also on upper case

grep iE [a-z]{3} password.txt // ask a to z character but only match with 3 of the char

grep iE [a-z]{,3} password.txt // ask a to z character but only match up to 3 of the char


grep iE [^0-9]{,3} password.txt //match anything that is not 0-9
grep iE [a-zA-Z]password.txt //match anything that is in alphabetiacl character

note: with [], dollar sign is treated as literal
```

```
echo "abab" | greo -E "(..)/1" // match exactly abab and avoid abba given (..)(..) that you might think a two char pattern repeats itself


note:/1 repat the 'first' capture group
```

^ and $: Anchors to match the start and end of a line.

[A-Za-z]: Matches any uppercase or lowercase letter.

[0-9]: Matches any digit.

{n,m}: Matches between n and m occurrences of the preceding pattern.

+: Matches one or more occurrences of the preceding pattern.

*: Matches zero or more occurrences of the preceding pattern.

?: Matches zero or one occurrence of the preceding pattern.

(): Groups patterns together.

|: Acts as an OR operator.

\: Escapes special characters (e.g., . matches a literal period).
## Alternating and repeating characters
```
grep - E "e|a" candies.txt // match e or a in candies
grep - E "(e|a)t candies.txt // match e or a in association with t in candies
grep - E "(e|a)+t candies.txt // match e or a that comes before  t in candies
grep - E "e*t" candies.txt // match e with anything between t
grep - E "e?"t" candies.txt // match e 0 or 1 e with any amount of t

grep - E "e*" candies.txt // match e 0 of more e; overmatch

note: c?  will ask for 0 or 1 occurences of c, (bc)? will match for 0 or 1 occurences of bc' ? should place before the asked character
    ex. ls | grep -E 'report\.txt(\.bak)?' // Matches: "report.txt" and "report.txt.bak"

```
## Intro to regular expressions
```
grep -i "." candies.txt // you don't get the literal result but any character at all


grep -i "\." candies.txt // slash escape the syntax

grep -i "a." candies.txt // you grep for a followed by any character


note: -i denotes insensitive to the case of our string
---
grep -Ei "^T" candies.txt // ^ match anything begins the line of character T

grep -Ei "s$" candies.txt // ^ match anything end the line of character s

grep -Ei "^hs$" candies.txt // ^ match anything being with hs$, not begin with h and end with s of hs...hs
---
grep -Ei "\<t" candies.txt // grep "any" words that start with 
grep -Ei "s\>" candies.txt // grep "any" words that end with s

grep -Ei "\<Tho>\" candies.txt // grep "any" words that start with Th and end with o; the return would be fuzzy, but your terminal should still output somehing
---
grep -Ei "..." candies.txt // grep with 3 characters; you should see a result of string highlight of 3 char*

grep -Ei "\<...>\" candies.txt // grep "any" 3 char words; more specific, resulting only characters with 3 char are highlighted, no continum highlighting, priotize alphaNum character over space
```
Why regulart expression
- in short: a lot of swe porblem are pattern mathcing and string search; regex help avoiding reinvintign the wheel

Regexes are every where. Some common applications:
- search for text in a file/input stream (curent lecgure)
- validate text to match a specific format (upcoming homework)
- find and replace text (upcoming lecture + homewokr)



What are regular expression?
- depend on who you ask
    - theoreical cs and linguistics have some format deinftion for it
    - in software enigenenrg, it is more loosely defined
- In programming languages, regular expression are implemented in the language:
    - Java: split() via Pattern class
    - Python: re library
    - JavaScript: RegExp object