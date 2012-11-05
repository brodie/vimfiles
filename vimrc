" Pathogen
let g:pathogen_disabled = ['pathogen']
call pathogen#infect()
call pathogen#helptags()

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
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
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
set formatoptions=qrn1
set shiftround " Indent to multiples of shiftwidth
set shiftwidth=4
set smarttab
set softtabstop=4
set textwidth=78

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

" Enable automatic filetype and ft plugins
filetype on
filetype plugin on
filetype indent on

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
    " Highlight VCS conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
endif

" Auto-commands
if has("autocmd")
    " Tabbing settings
    autocmd FileType ant,dtml,genshi,html,htmlcheetah,htmldjango,kid,mako,
                    \php,sgml,smarty,xhtml,xml,xslt
                   \ setlocal autoindent expandtab smarttab shiftwidth=2
                            \ softtabstop=2
    autocmd FileType python highlight PyFlakes gui=bold guibg=#aa2222
    " Resize splits when the window is resized
    autocmd VimResized * :wincmd =

    " Set the cursor line in the active window
    if has("gui")
        augroup cline
            autocmd!
            autocmd WinLeave,InsertEnter * set nocursorline
            autocmd WinEnter,InsertLeave * set cursorline
        augroup END
    endif

    " Restore the line the cursor was on when reloading a file
    augroup line_return
        autocmd!
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     execute 'normal! g`"zvzz' |
            \ endif
    augroup END
endif

" Undo python-mode brain damage
let g:pymode_lint_checker = "pyflakes,mccabe"
let g:pymode_lint_onfly = 1
let g:pymode_lint_cwindow = 0
let g:pymode_utils_whitespaces = 0
let g:pymode_folding = 0
let g:pymode_options_other = 0

let mapleader = ","
let maplocalleader = "\\"
nnoremap ; :

" Ctrl-P bindings
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_jump_to_buffer = 0
"let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_max_height = 20
let g:ctrlp_extensions = ['tag']
nnoremap <silent> <Leader>b <Esc>:CtrlPMRU<CR>

let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ ".git/|.hg/|.svn/" .
    \ ")'"

let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
    \ ctrlp_filter_greps

let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files --exclude-standard -co | " .
    \ ctrlp_filter_greps

let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]

" Window/buffer management
nnoremap <silent> <Leader>c <Esc>:bd<CR>
nnoremap <silent> <Leader>q <Esc>:q<CR>
nnoremap <silent> <Leader>Q <Esc>:qa<CR>
nnoremap <silent> <Leader>1 <C-w>o<Esc>:set columns=80<CR>
nnoremap <silent> <Leader>2 <Esc>:set columns=160<CR>
nnoremap <silent> <Leader>3 <Esc>:set columns=240<CR>
nnoremap <Leader>w <C-w>w
nnoremap <Leader>s <C-w>s
nnoremap <Leader>v <C-w>v
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlighting
nnoremap <silent> <Leader><Space> <Esc>:noh<CR>

" Miscellaneous
nnoremap <Leader>u <Esc>:GundoToggle<CR>
nnoremap <Leader>a <Esc>:Ack!<Space>
nnoremap <Leader>n <Esc>:setlocal number!<CR>

" More forgiving line movement
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Select (charwise) the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" Reformat line.
nnoremap ql ^vg_gq

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<CR>a

" System clipboard interaction.
nnoremap <Leader>y "*y
nnoremap <Leader>p <Esc>:set paste<CR>"*p<CR>:set nopaste<CR>
nnoremap <Leader>P <Esc>:set paste<CR>"*P<CR>:set nopaste<CR>
vnoremap <Leader>y "*ygv

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Emacs bindings in command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Insert mode completion
inoremap <C-f> <C-x><C-f>
inoremap <C-]> <C-x><C-]>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Ack for the last search.
nnoremap <silent> <Leader>/ <Esc>:execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" Heresy
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" Sudo to write
cmap w!! w !sudo tee % > /dev/null

" Set color scheme
set background=dark
if has("gui")
    colorscheme molokai
endif

" Enable spell checking (vim7 only)
if has("spell")
    set spelllang=en_us " Global spell checking
    set spellfile=~/.vim/custom-dictionary.utf-8.add
    set spell
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=Red term=underline
                     \ cterm=underline gui=underline guisp=#883300
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline gui=underline
                     \ guisp=#7070f0
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline gui=underline
                       \ guisp=#70f0f0
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline gui=underline
                      \ guisp=#ffffff
endif

" TextMate-style display of invisible characters
set listchars=tab:⇥\ ,eol:¬,trail:·,extends:❯,precedes:❮
set list
highlight clear NonText
highlight NonText ctermfg=DarkGrey guifg=#404040
highlight clear SpecialKey
highlight SpecialKey ctermfg=DarkGrey guifg=#505050
if &t_Co == 256
    highlight NonText ctermfg=232 guifg=#404040
    highlight SpecialKey ctermfg=232 guifg=#505050 guibg=NONE
    highlight ColorColumn ctermbg=232
endif

let g:vimroom_guibackground='#1B1E1F'
let g:vimroom_width=79

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
    augroup ccol
        autocmd!
        autocmd WinLeave * setlocal colorcolumn=0
        autocmd WinEnter * call SmartColorColumn()
        autocmd VimEnter * call SmartColorColumn()
        autocmd VimResized * call SmartColorColumn()
    augroup END
endif

" MacVim settings
if has("gui_macvim")
    set guifont=Menlo:h12
    set linespace=2
    set guioptions-=T " Disable toolbar
    set guioptions-=r " Disable scrollbar
    set guioptions-=L " Disable left-hand scrollbar
    map <silent> <Leader>t <Esc>:silent !open -a Terminal<CR>
    set columns=80 lines=50 " Set default window size
endif
