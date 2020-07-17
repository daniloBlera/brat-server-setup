" --VISUAL--
set number                  " Set line numbering on
colorscheme koehler
set scrolloff=10            " Number of lines to keep above and below the cursor

" --INDENT AND SEARCH--
set tabstop=4               " Number of spaces a TAB counts for
set shiftwidth=4            " Number of spaces to use for each step of (auto)indent.
set softtabstop=4           " Number of spaces a TAB counts on edit operations
" set expandtab               " Insert whitespaces when pressing TAB
set shiftround              " Round indent to a multiple of 'shiftwidth'
set autoindent              " Copy current indent level into the next line
set linebreak               " Wrap long lines
set ignorecase              " Ignore case on search patterns
filetype plugin indent on   " Rely on file plugins to handle indenting

" --KEYMAPS--
" Map (capital) 'J' and 'K' to 'Next' and 'Previous' tab
nnoremap J gt
nnoremap K gT

" Toggle line numbering
nnoremap <F3> :set nonumber!<CR>

" Text selection
" Map '\' and 'p' to paste X11's clipboard into selection
" Map '\' and 'y' to yank selection into X11's clipboard
noremap <Leader>p "+p
noremap <Leader>y "+y

" Copy the current line to selection then go to next line
" Useful to send sequence of lines to clipboard managers
noremap Y V"+yj

" Map '\' and 'n' to open 'new tab' prompt
noremap <Leader>n :tabnew 
noremap <Leader>w :vsplit 

" Map 'j' and 'k' to move to 'Next' and 'Previous' wrapped lines
nnoremap j gj
nnoremap k gk

" Line highlight
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" set cursorline
nnoremap <F4> :set cursorline!<CR>

" Disable last search results hightlight
nnoremap <M-/> :noh<CR>

" Splits navigation
nnoremap <M-h> <C-W><C-H>
nnoremap <M-j> <C-W><C-J>
nnoremap <M-k> <C-W><C-K>
nnoremap <M-l> <C-W><C-L>

" Visualizing special characters
set listchars=eol:$,tab:<-,trail:~,extends:>,precedes:<
set list
nnoremap <F5> :set list!<CR>
