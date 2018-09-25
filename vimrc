" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" For the pathogen plugin
execute pathogen#infect()

" Don't show the Vim startup message
"set shortmess+=I

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=200     " keep 200 lines of command line history
set ruler           " show the cursor position in lower right corner all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

set autoindent      " Copy indent from current line when starting a new line
set autoread        " Automatically update files if changed outside of Vim
set number          " Show line numbers
"set cursorline      " Highlight the current line
set nowrap          " Don't wrap lines at the edge of the screen

set tabstop=4       " Tabs are 4 spaces each
set expandtab       " Type spaces when the Tab key is pressed
set shiftwidth=4    " Indent 4 spaces
set smarttab        " Treat shiftwidth spaces as a 'virtual tab' on empty lines.
                    " i.e. one backspace press will remove shiftwidth spaces and
                    " one tab press will insert shiftwidth spaces
set shiftround      " Round shift operators '>' and '<' to a multiple of shiftwidth
set cindent         " Use C indentation rules

"Rules for indenting according to C coding standard
"
" s -   means 1 shift width, defined above (4)
" f0 -  Place the first opening brace of a function or other block in column 0.
" {s -  Place opening braces "shift width" (4) characters from the prevailing indent.
" (s -  When in unclosed parentheses, indent "shift width" (4) characters from the line
"       with the unclosed parentheses.  Add a 'shiftwidth' for every
"       unclosed parentheses.  When N is 0 or the unclosed parentheses
"       is the first non-white character in its line, line up with the
"       next non-white character after the unclosed parentheses.
" >s -  Amount added for "normal" indent.  Used after a line that should
"       increase the indent (lines starting with "if", an opening brace,
"       etc.).
" ^-s - Add N to the prevailing indent inside a set of braces if the
"       opening brace is in column 0.  This can specify a different
"       indent for whole of a function (some may like to set it to a
"       negative number).  This outdents the main body of the function "shift
"       width" (4) characters, such that the body of a procedure is aligned
"       with the opening brace (column 0).
" U1 -  When N is non-zero, do not ignore the indenting specified by
"       ( or u in case that the unclosed parentheses is the first
"       non-white character in its line.
"
" Column 0
" |
" void func()
" {                     // location of this brace controleld by f0
" int   i;              // ^-s makes us align the main body in column 0
"
" for( i = 0; i < 10; i++ )
"     {                         // {s makes us indent the brace 4 spaces
"     }
"
" if( foo )
"     do_something();           // >s makes us indent after a line that should
"                               // increase the indent
"
" if( foo &&
"       bar )                   // (s indents for each unclosed paren
"     {
"     do_something();
"     }
"
" if( foo && ( bar &&
"            baz ))             // (s indents for each unclosed paren
"     {
"     do_something();
"     }
"
" c = c1 &&
"     (
"         c2 ||                 // (s,U1 - indent for each unclosed paren
"         c3
"     ) && c4;
"
" } /* func() */
set cinoptions=f0,{s,(s,>s,^-s,U1   " Rules for indenting according to the Garmin C
                                    " coding standard

set hlsearch        " Highlight matching search terms
set showmode        " Show the mode we are using if not normal mode (e.g. -- INSERT -- )
syntax enable       " Enable syntax highlighting

filetype plugin on
filetype indent on

autocmd! BufRead,BufNewFile *.ino setlocal ft=arduino

" This was stolen from the asciidoc website here:
" http://www.methods.co.nz/asciidoc/chunked/ch36.html
autocmd BufRead,BufNewFile *.txt,*.asciidoc,*.adoc,README,TODO,CHANGELOG,NOTES,ABOUT
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
        \ textwidth=70 wrap formatoptions=tcqn
        \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

if has( "gui_running" )
    colorscheme hain-default
else
    colorscheme hain-default
endif

" Don't worry about the name (hidden). What this does is allow Vim to manage multiple buffers
" effectively.  The current buffer can be put to the background without writing to
" disk.  When a background buffer becomes current again, marks and undo-history are
" remembered.
set hidden

" By default, pressing <TAB> in command mode will choose the first possible
" completion with no indication of how many others there might be. The following
" configuration lets you see what your other options are, uncomment the
" following line:
set wildmenu
" To have the completion behave similarly to a shell, i.e. complete only up to
" the point of ambiguity (while still showing you what your options are), also
" add the following:
set wildmode=list:longest

" We want to see at least 81 text columns but we need a few
" extra for showing line numbers.  Setting lines to 999 will
" start with the height maximized.
if has( "gui_running" )
    set lines=999 columns=90
endif

" When the cursor moves outside the viewport of the current window, the buffer
" scrolls a single line to keep the cursor in view. Setting the option below
" will start the scrolling three lines before the border, keeping more context
" around where you're working.
set scrolloff=3

" Plugin Configuration - airline
set laststatus=2    "always show the airline status bar

" Plugin Configuration - CtrlP

" begin finding a root from the current working directory outside of CtrlP
" instead of from the directory of the current file (default).
let g:ctrlp_working_path_mode = 'rw'

" Plugin Configuration - grep
:let Grep_Default_Filelist = '*.c *.h'

" Plugin Configuration - minibufexpl
" let g:miniBufExplVSplit = 25
" let g:miniBufExplMapCTabSwitchBufs = 1 " doesn't appear to work

" Plugin Configuration - rainbow
" let g:rainbow_active = 1
" let g:rainbow_operators = 1

" Set default compiler
" compiler! gcc

" Key map for displaying make error log - Courtesy of Josh Watt
" F11 will process make.log and display the error list
" Shift-F11 will do the same and jump to the first error
map <F11> :cgetfile make.log<CR>:cw<CR>
map <S-F11> :cfile make.log<CR>:cw<CR>

" Leader Key Remapping
let mapleader = ","     " change the leader key to ,

" Test
nnoremap <leader>ml :cgetfile make.log<CR>:cw<CR>

" Leader Shortcut(s) - General
nnoremap <leader>ww :wincmd w<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wj :wincmd j<CR>
nmap <leader>d :bprevious<CR>:bdelete #<CR> " delete a buffer

" Leader Shortcut(s) - grep plugin
nnoremap <leader>rg :Rgrep

" Leader Shortcut(s) - taglist plugin
nnoremap <leader>tl :TlistToggle<CR>

" Leader Shortcut(s) - minibufexpl plugin
nnoremap <leader>mb :MBEToggle<CR>

" Leader Shortcut(s) - ack plugin
nnoremap <leader>ac :Ack!

" Leader Shortcut(s) - commenting plugin
nnoremap <leader>f1 :call FileHeading()<CR>
nnoremap <leader>f2 :call FunctionHeading()<CR>
nnoremap <leader>bc :call BlockComment()<CR>

" By default, Vimwiki maps ww to VimwikiIndex
" Since I have ww mapped to something else,
" remap it here so we don't have a conflict
nmap <leader>vw <Plug>VimwikiIndex


