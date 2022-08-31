set shell=/bin/bash

" Plug Start
call plug#begin('~/.config/nvim/bundle/')

" Theme
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Fuzzy
Plug 'junegunn/fzf', {'branch': 'master'}
Plug 'junegunn/fzf.vim', {'branch': 'master'}

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript', {'branch': 'master', 'for': 'javascript'}
Plug 'cakebaker/scss-syntax.vim', {'branch': 'master', 'for': 'sass'}

" Fix class/function name at top
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" Git
Plug 'tpope/vim-fugitive', {'branch': 'master'}
Plug 'shumphrey/fugitive-gitlab.vim', {'branch': 'master', 'on': 'Gbrowse'}
Plug 'airblade/vim-gitgutter', {'branch': 'master'}

" Statusbar
Plug 'vim-airline/vim-airline', {'branch': 'master'}
Plug 'vim-airline/vim-airline-themes', {'branch': 'master'}

Plug 'preservim/nerdtree', {'branch': 'master'}
Plug 'scrooloose/nerdcommenter', {'branch': 'master'}
Plug 'mhartington/oceanic-next', {'branch': 'master'}
Plug 'godlygeek/tabular', {'branch': 'master'}
Plug 'SirVer/ultisnips', {'branch': 'master'}
Plug 'alvan/vim-closetag', {'branch': 'master', 'for': 'html'}
Plug 'terryma/vim-multiple-cursors', {'branch': 'master'}
Plug 'honza/vim-snippets', {'branch': 'master'}
Plug 'tpope/vim-surround', {'branch': 'master'}
Plug 'ryanoasis/vim-devicons', {'branch': 'master'}
Plug 'tpope/vim-unimpaired', {'branch': 'master'}
Plug 'norcalli/nvim-colorizer.lua', {'branch': 'master'}

" Welcome
Plug 'mhinz/vim-startify'
let g:startify_session_dir = '~/sessions'

call plug#end()

" RTL
set termbidi
set mouse=a
set number
set relativenumber
set encoding=utf-8
set shiftwidth=4
set showmatch
set showmode
set showcmd
set hidden
set hlsearch
set incsearch
set smartindent
set autoindent
set smarttab
set softtabstop=4
set tabstop=4
set laststatus=2
set wildmenu
set wildmode=list:longest,full
set expandtab
set preserveindent
set list
set lcs=tab:\ \ 
set scrolloff=4
set ruler
set undolevels=100
set undofile " Maintain undo history between sessions
set undodir=~/.config/nvim/undodir
set updatetime=400
set backspace=indent,eol,start
set timeout timeoutlen=1000 ttimeoutlen=100
set linebreak
set cindent!
set foldmethod=indent
set foldlevel=2
set wrap
filetype plugin indent on

:command! -nargs=0 Config :exe 'edit ' . stdpath('config') . '/init.vim'
:command! -nargs=0 Reload :exe 'source ' . stdpath('config') . '/init.vim'


" Save session on close
autocmd VimLeavePre * call SaveSessionOnLeave()
function SaveSessionOnLeave()
    :NERDTreeClose
    if v:this_session != "" && v:this_session != expand('~/sessions/latest.vim')
        execute "mksession! " . v:this_session
    else
        let branchName = trim(substitute(system("git rev-parse --abbrev-ref HEAD"), "^[^/]*/", "", ""))
		if branchName != ""
			execute "mksession! ~/sessions/" . branchName . ".vim"
        else 
		    let SNX = input("Input a name for session? ")
		    if SNX != ""
			    execute "mksession! ~/sessions/" . SNX . ".vim"
            else
			    execute "mksession! ~/sessions/latest.vim"
		    endif
		endif
	endif
endfunction

" HighlightWordUnderCursor
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]' 
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/' 
    else 
        match none 
    endif
endfunction
autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" Clear and Redraw screen when an error happens
nnoremap <Leader>l :redraw!<cr>

" clear search
nnoremap <silent> <leader><space> :let @/=''<CR>:nohlsearch<CR>

" Cut/Copy/Paste outside vim
nnoremap <C-x><C-x> "+dd
nnoremap <C-c><C-c> "+yiw
vnoremap <C-c><C-c> "+y
nnoremap <C-p><C-p> "+p
vnoremap <C-p><C-p> <Esc>o<Esc>"+p

" Begin/End line
nnoremap H _
nnoremap L $

" Add brace to current line
nnoremap <Leader>[ kA<Space>{<Esc>jo}<Esc>

" Copy full address
nnoremap <Leader>y :let @+=expand('%:p')<CR>

" Add indent for p/li in html
let g:html_indent_tags = 'li\│p'

" Toggle between 2 last files
nnoremap <Leader><Leader> <C-^>

" Max height when opening files
autocmd BufNewFile,BufRead,BufEnter * resize

" Working with split
nnoremap <C-j> <C-W>j<C-W>_zz
nnoremap <C-k> <C-W>k<C-W>_zz
nnoremap <C-l> <C-W>l<C-W>_zz
nnoremap <C-h> <C-W>h<C-W>_zz
nnoremap <C-x> <C-W>x " Moving to nth
nnoremap <C-q> <C-W>> " Increase split size
nnoremap <C-a> <C-W>< " Decrease split size
set wmh=0
set splitbelow
set splitright

" remap movement to move by column layout
nnoremap j gj
nnoremap k gk

" Aliases for different file types
:command JSX :set ft=javascript.jsx
:command JS :set ft=javascript
:command HTML :set ft=html
:command PHP :set ft=php
:command SQL :set ft=sql

" Theme
syntax on
set t_Co=256
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let g:airline_theme='deus'

let g:catppuccin_flavour = "frappe" " latte, frappe, macchiato, mocha
colorscheme catppuccin
hi TreesitterContext guibg=#2C314C
hi TreesitterContextLineNumber guifg=#98C379

" Using Catppuccin colors
hi Folded guibg=NONE
hi Folded guifg=#7a6750
hi Folded ctermbg=NONE
hi Search guibg=#404456  
hi Search guifg=#ff6000

" Airplane Theme
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_extensions = ['fugitiveline', 'branch']
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled=1
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0BA"
let g:airline_skip_empty_sections = 1
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" Title as filename
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" Search in VisualMode
vnoremap // y/<C-R>"<CR>

" Close sentence with ;
inoremap <Leader>; <Esc>mqA;<Esc>`qli
nnoremap <Leader>; mqA;<Esc>`q

" echo paching pair
inoremap ({<CR> ({<CR><C-d>});<Esc>O
inoremap ([ ([])<Esc>hi
inoremap (<CR> (<CR><C-d>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR><C-d>]<Esc>O

" Args mapping
nnoremap <Leader>ad :argdelete %<CR>
nnoremap <Leader>ac :argdo argdelete %<CR>
nnoremap <Leader>aa :call DuplicateAddToArgs()<CR>
function DuplicateAddToArgs()
    let already_added = 0
    for ar in argv() 
        if expand('%') == ar
            let already_added = 1
        endif
    endfor
    if already_added == 0
        :argadd %
        :echo expand('%')
    else
        :echo 'Already added to args'
    endif
endfunction

" Comment/Uncomment
let g:NERDSpaceDelims=1
let g:NERDDefaultNesting=0
let g:NERDRemoveExtraSpaces=1

" NERDTree
autocmd VimEnter * NERDTreeVCS | wincmd p
function IsNERDTreeFocused()
    return exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) == winnr()
endfunction
let NERDTreeShowHidden=0
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=35
map <C-q> :NERDTreeToggleVCS<CR>

" Switch between NERDTree and current buffer
map <expr> ff IsNERDTreeFocused() ? ':wincmd p<CR>' : ':NERDTreeFind<CR>'

" Change PWD to current folder (For NERDTree and autochdir to work)
autocmd BufEnter *  silent! call timer_start(100, {-> call(function('ChangePwdToCurrentFile'), [])})
function! ChangePwdToCurrentFile()
    if filereadable(expand("%")) 
        execute("cd %:p:h")
    endif
endfunction

" Close NERDTree if it's last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Fold/Unfold saving
augroup AutoSaveFolds
    autocmd!
    au BufWinLeave *.* mkview 1
    au BufWinEnter *.* silent! loadview 1
augroup END

" Tabular
nnoremap <Leader>= :Tab /=<CR> :%retab!<CR>
nnoremap <Leader>: :Tab /:<CR> :%retab!<CR>
nnoremap <Leader>, :Tab /,<CR> :%retab!<CR>

" JSX Syntax to JS
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" Git Fugitive
let g:fugitive_gitlab_domains = ['https://my.gitlab.com']
nnoremap <Leader>g :Git<CR>

" ReRender syntax highlights
nnoremap <F12> :syntax sync fromstart<CR>
inoremap <F12> <ESC>:syntax sync fromstart<CR>a

" COC mapping
nmap <silent> <Leader>e <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>q <Plug>(coc-diagnostic-prev)
nmap <silent> gd :call CocAction('jumpDefinition')<CR>
nmap <silent> gr <Plug>(coc-references)
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-phpls', 'coc-vetur', 'coc-html', 'coc-prettier', 'coc-css', 'coc-eslint', 'coc-svg', 'coc-sql', 'coc-flutter', 'coc-snippets']


" Select suggestion using Enter
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Terminal mapping
nnoremap \` :term<CR>

" Words with - should be treated as 2 words
set iskeyword-=-

" Snippets Trigger configuration
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

" Fuzzy
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.95 } }
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}), <bang>0)
command! -bang PFiles call fzf#vim#files('~/Projects', <bang>0)
nnoremap <Leader>ff :GFiles<CR>
nnoremap <Leader>fz :PFiles<CR>
nnoremap <Leader>fl :BLines<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <leader>fr :PRg<space>
vnoremap <leader>fr y:PRg <C-r>"<CR>
nnoremap <F2> :BLines function <CR>
imap <c-x><c-f> <plug>(fzf-complete-path)

lua <<EOF
    require'treesitter-context'.setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            default = {
                'class',
                'function',
                'method',
                'for',
                'if',
            },
        },
        zindex = 20, -- The Z-index of the context window
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    }

    require 'colorizer'.setup()
EOF
