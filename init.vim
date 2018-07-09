" Pathogen
let g:pathogen_disabled = ['pathogen']
call pathogen#infect()
filetype plugin indent on

" General settings
set autoread
set autowrite
if has("clipboard")
    set clipboard=unnamed " Use system clipboard
endif
set hidden
set history=10000 " Keep command line history
if has("langmap")
    set langnoremap " (nvim default)
endif
set laststatus=2
set nrformats-=octal " (nvim default)
set modelines=0
if has("mouse")
    set mouse=a " Enable the mouse
endif
set ruler " Show cursor information
set scrolloff=1
set sessionoptions-=options " (nvim default)
set sidescroll=1
set sidescrolloff=5
if has("showcmd")
    set showcmd
endif
set showmatch " Show matching brackets
set tabpagemax=50 " (nvim default)
set tags=./tags;,tags " (nvim default)
set ttimeout " (nvim default)
set ttimeoutlen=50 " (nvim default)
if has("title")
    set title " Set the terminal title
endif
set viminfo='100,<50,s10,h " Store session info in ~/.viminfo
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
let g:rustfmt_autosave = 1

" Search
set hlsearch
set incsearch
set ignorecase " Case-insensitive searching
set smartcase " Case-sensitive searching for searches with uppercase letters

" Completion
set complete-=i " (nvim default)
set completeopt=longest,menuone,preview
set wildmenu
set wildmode=list:longest
set wildignore=*.orig,*~,*.o,*.so,*.py[cdo],*.swp,*.prof,.DS_Store,
              \*/.git/*,*/.hg/*,*/.svn/*,.hgsubstate
let g:netrw_list_hide='\.orig$,\.~$,\.s?o$,\.py[cdo]$,\.swp$,\.prof$'

" Backups
set undodir=~/.local/share/nvim/undo
set backupdir=~/.local/share/nvim/backup
set directory=~/.local/share/nvim/swap//
set backup
set backupskip+=/private/tmp/*
set noswapfile
set undofile

" Syntax highlighting settings
if has("syntax")
    syntax enable " Automatic syntax highlighting
endif
if has("autocmd")
    autocmd BufNewFile,BufRead *.t set filetype=cram
endif
let g:syntastic_python_checkers = ['python', 'pyflakes']

" Leader bindings
let mapleader = ","
let maplocalleader = "\\"

" Ctrl-P settings
let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git',
                    \ 'git --git-dir=%s/.git ls-files -oc --exclude-standard'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f',
            \ }
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_max_files = 0
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
if has("gui")
    nnoremap <silent> <Leader>v <Esc>:call SmartSplit()<CR>
    nnoremap <silent> <Leader>1 <C-w>o<Esc>:set columns=80<CR>
    nnoremap <silent> <Leader>2 <Esc>:set columns=160<CR>
    nnoremap <silent> <Leader>3 <Esc>:set columns=240<CR>
else
    nnoremap <Leader>v <C-w>v
    nnoremap <silent> <Leader>1 <C-w>o
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

" Emacs bindings in command line mode
cnoremap <C-a> <Home>
" The following bindings are disabled so <Esc> doesn't trigger timeout
"cnoremap <M-b> <S-Left>
"cnoremap <Esc>b <S-Left>
"cnoremap <M-f> <S-Right>
"cnoremap <Esc>f <S-Right>
"cnoremap <M-BS> <C-w>
"cnoremap <Esc><BS> <C-w>

" Insert mode completion
inoremap <C-f> <C-x><C-f>
inoremap <C-]> <C-x><C-]>

" Sudo to write (currently disabled so typing w doesn't trigger timeout)
"cmap w!! w !sudo tee % > /dev/null

" Set color scheme
set background=light
colorscheme github

" Enable spell checking
if has("spell")
    set spelllang=en_us " Global spell checking
    set spellfile=~/.config/nvim/spellfile.utf-8.add
    if has("gui")
        set spell
    endif
endif

" TextMate-style display of invisible characters
set listchars=tab:⇥\ ,eol:¬,trail:·,extends:❯,precedes:❮
if has("gui")
    set list
endif

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
