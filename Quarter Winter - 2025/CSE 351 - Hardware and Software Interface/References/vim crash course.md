### Basic Commands
i
- Enter 'input mode', allows you to edit text but you can't run commands

Esc
- Exit 'input mode'/'selection mode' (see v)

:w
- Save the changes you have on the current file

:q
- Close the current editor window (see the sections below)

:wq or ZZ
- Save the changes you have on the current file and close the editor window

:q!
- Close the current editor window without saving the open file

:! <command> 
- Run <command> in your current shell (e.g., !make)

:<number> or <number>
- go to line <number>

u 
- Undo the last change

ctr+r 
- Redo the last change the last undo

v 
- Start highlighting by character ('selection mode')

V 
- Start highlighting by line

y 
- Copy current selection

yy 
- Copy current line

d 
- Delete/Cut current selection

dd 
- Delete/Cut current line

p 
- Paste the last thing that was cut/copied

P 
- Paste the last thing that was cut/copied before the cursor

### Moving Between Widows
ctr+w ctr+w 
- Move clockwise to the next window

ctr+w → or ctr+w l 
- Move to the window to the right of the current one

ctr+w ↑ or ctr+w k 
- Move to the window above the current one

ctr+w ← or ctr+w h 
- Move to the window to the left of the current one

ctr+w ↓ or ctr+w j 
- Move to the window below the current one

### Rearranging Windows
ctr+w x 
- Exchange the current window with the next one in the current row/column

ctr+w L 
- Move the current window to occupy the right side of the screen

ctr+w K 
- Move the current window to occuppy the top of the screen

ctr+w H 
- Move the current window to occupy the left side of the screen

ctr+w J 
- Move the current window to occupy the bottom of the screen

### Resizing Windows
ctr+w = 
- Have all windows take up an equal space of their row/column

<number> ctr+w + 
- Increase window height by <number>

<number> ctr+w — 
- Decrease window height by <number>

<number> ctr+w > 
- Increase window width by <number>

<number> ctr+w < 
- Decrease window width by <number>