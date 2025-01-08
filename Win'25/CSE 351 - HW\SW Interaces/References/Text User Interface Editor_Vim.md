### CSE 351 Vim Configuration
use vim ~/.vimrc to check for your configuration
- the command that will setup for the the vim of the class
    - curl -Lo ~/.vimrc https://cs.uw.edu/351/editors/vimrc.txt
```
  1 "Turn on syntax highlighting"                                                       
  2 syntax on
  3 
  4 " Turn on line numbers
  5 set nu
  6 
  7 " Highlight line number
  8 hi CursorLine cterm=NONE
  9 hi CursorLineNR cterm=NONE ctermbg=15 ctermfg=8
 10 set cursorline
 11 
 12 " Set up make file integration
 13 " Use :copen to view makefile output and :cclose to close
 14 map <F9> :make
 15 
 16 " When doing split and vsplit, automatically move the cursor to the new split
 17 set splitright
 18 set splitbelow
 19 
 20 " Set tab width + automatic tab after {
 21 filetype plugin indent on
 22 set tabstop=2
 23 set shiftwidth=2
 24 set expandtab
 25 
 26 " Highlight all search matches
 27 " Can be disabled temporarily using :nohlsearch (or just :noh)
 28 " or permanently by :set nohlsearch
 29 set hlsearch 
```
### Getting Started
- type vim<filename> or vim to activate the text editor
    - cheatsheet: https://vim.rtorr.com/
- :q to exit (or :q! to exit and discard changes)

