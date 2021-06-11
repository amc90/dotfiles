" execute pathogen#infect()

set nocompatible
set backspace=indent,eol,start
set backup
set history=50
set ruler
set showcmd
set incsearch
syntax enable
set hlsearch
set laststatus=2
set mouse=
set ruler
set wildmenu

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

