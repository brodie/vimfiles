" Pathogen
let g:pathogen_disabled = ['pathogen']
call pathogen#infect()
filetype plugin indent on

" General settings
set autoread
set autowrite
set hidden
set history=1000 " Keep command line history
set laststatus=2
set modelines=0
if has("mouse")
    set mouse=a " Enable the mouse
endif
set ruler " Show cursor information
set scrolloff=1
set sidescroll=1
set sidescrolloff=5
if has("showcmd")
    set showcmd
endif
set showmatch " Show matching brackets
if has("title")
    set title " Set the terminal title
endif
set viminfo=\"50,'20 " Store session info in ~/.viminfo
if has("virtualedit")
    set virtualedit+=block
endif

" Indentation/formatting
set autoindent
set backspace=indent,eol,start " Smarter backspacing
set expandtab
set formatoptions-=o
set formatoptions-=t
set formatoptions+=n1
try
    set formatoptions+=j
catch /^Vim(set):E539/
endtry
if has("autocmd")
    autocmd FileType * setlocal formatoptions-=o
endif
" FIXME: This option resets indentation inside blocks in visual mode.
"        It'd be nice if it only rounded indentation for the entire block.
"        (I.e., indent the first line based on shiftround, and indent every
"        following line based on how much indentation was added to just the
"        first line.)
"set shiftround " Indent to multiples of shiftwidth
set shiftwidth=4
set smarttab
set softtabstop=4
set textwidth=78
if has("autocmd")
    autocmd FileType css,html,htmldjango,xhtml,xml
                   \ setlocal formatoptions-=t shiftwidth=2 softtabstop=2
    autocmd FileType go,make setlocal noexpandtab shiftwidth=8 softtabstop=0
    autocmd FileType go,make let b:yaifa_disabled=1
    autocmd FileType gitcommit,hgcommit,markdown,rst,text
                   \ setlocal formatoptions+=t
    autocmd FileType gitcommit,hgcommit setlocal textwidth=72
endif
let g:yaifa_tab_tab_width=8
let g:yaifa_max_lines=128

" Search
set hlsearch
set incsearch
set ignorecase " Case-insensitive searching
set smartcase " Case-sensitive searching for searches with uppercase letters

" Completion
set completeopt=longest,menuone,preview
set wildmenu
set wildmode=list:longest
set wildignore=*.orig,*~,*.o,*.so,*.py[cdo],*.swp,*.prof,.DS_Store,
              \*/.git/*,*/.hg/*,*/.svn/*,.hgsubstate
let g:netrw_list_hide='\.orig$,\.~$,\.s?o$,\.py[cdo]$,\.swp$,\.prof$'

" Backups
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set backupskip=/tmp/*,/private/tmp/*
set noswapfile
set undofile
set undoreload=10000

" Syntax highlighting settings
if has("syntax")
    syntax enable " Automatic syntax highlighting
endif
if has("autocmd")
    autocmd BufNewFile,BufRead *.t set filetype=cram
endif
let g:syntastic_python_checkers = ['python', 'pyflakes']

" YouCompleteMe settings
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_autoclose_preview_window_after_insertion = 1
nnoremap <silent> <Leader>g
                \ <Esc>:YcmCompleter GoToDefinitionElseDeclaration<CR>

" Leader bindings
let mapleader = ","
let maplocalleader = "\\"

" Ctrl-P bindings
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_switch_buffer = ''
nnoremap <silent> <Leader>b <Esc>:CtrlPMRU<CR>

" Window/buffer management
function! SmartSplit()
    vsplit
    if winwidth(0) <= &columns
        set columns+=80
    endif
endfunction

nnoremap <silent> <Leader>c <Esc>:bd<CR>
nnoremap <silent> <Leader>q <Esc>:q<CR>
nnoremap <silent> <Leader>Q <Esc>:qa<CR>
nnoremap <Leader>w <C-w>w
nnoremap <Leader>s <C-w>s
nnoremap <silent> <Leader>1 <C-w>o<Esc>:set columns=80<CR>
nnoremap <silent> <Leader>2 <Esc>:set columns=160<CR>
nnoremap <silent> <Leader>3 <Esc>:set columns=240<CR>
if has("gui")
    nnoremap <silent> <Leader>v <Esc>:call SmartSplit()<CR>
else
    nnoremap <Leader>v <C-w>v
endif
nnoremap <silent> <Leader>V <C-w>v

if has("autocmd")
    " Resize splits when the window is resized
    autocmd VimResized * :wincmd =

    " Restore the line the cursor was on when reloading a file
    augroup RestoreCursor
        autocmd!
        autocmd BufWinEnter *
            \ if line("'\"") <= line("$") |
            \     execute 'normal! g`"' |
            \ endif
    augroup END
endif

" Clear search highlighting
nnoremap <silent> <Leader><Space> <Esc>:noh<CR>

" Miscellaneous
nnoremap <Leader>u <Esc>:GundoToggle<CR>
nnoremap <Leader>a <Esc>:Ack!<Space>

" System clipboard interaction.
nnoremap <Leader>y "*y
nnoremap <Leader>p <Esc>:set paste<CR>"*p<CR>:set nopaste<CR>
nnoremap <Leader>P <Esc>:set paste<CR>"*P<CR>:set nopaste<CR>
vnoremap <Leader>y "*ygv

" Emacs bindings in command line mode
cnoremap <C-a> <Home>
cnoremap <M-b> <S-Left>
cnoremap <Esc>b <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <Esc>f <S-Right>
cnoremap <M-BS> <C-w>
cnoremap <Esc><BS> <C-w>

" Insert mode completion
inoremap <C-f> <C-x><C-f>
inoremap <C-]> <C-x><C-]>

" Sudo to write
cmap w!! w !sudo tee % > /dev/null

" Set color scheme
set background=dark
colorscheme molokai

" Enable spell checking
if has("spell")
    set spelllang=en_us " Global spell checking
    set spellfile=~/.vim/spellfile.utf-8.add
    set spell
endif

" TextMate-style display of invisible characters
set listchars=tab:⇥\ ,eol:¬,trail:·,extends:❯,precedes:❮
set list

" Highlight the 80th column
if has("autocmd") && (has("gui") || &t_Co == 256)
    function! SmartColorColumn()
        if winwidth(0) <= &textwidth + 2
            setlocal colorcolumn=0
        else
            setlocal colorcolumn=+1
        endif
    endfunction

    " Only show colorcolumn in the current window.
    call SmartColorColumn()
    augroup SmartColorColumn
        autocmd!
        autocmd WinLeave * setlocal colorcolumn=0
        autocmd WinEnter * call SmartColorColumn()
        autocmd VimEnter * call SmartColorColumn()
        autocmd VimResized * call SmartColorColumn()
    augroup END
endif

" GUI settings
if has("gui")
    set guioptions-=T " Disable toolbar
    set guioptions-=r " Disable scrollbar
    set guioptions-=L " Disable left-hand scrollbar
    set columns=80 lines=50 " Set default window size
endif

if has("gui_macvim")
    set guifont=Menlo:h12
    set linespace=2
endif
