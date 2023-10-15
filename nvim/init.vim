set shell=/bin/bash

" Plug Start
call plug#begin('~/.config/nvim/bundle/')

" Faster startup
Plug 'lewis6991/impatient.nvim', {'branch': 'main'}

" Theme
Plug 'folke/tokyonight.nvim', {'branch': 'main'}

" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Chdir to root of project
Plug 'airblade/vim-rooter', {'branch' : 'master'}
 
" Fuzzy
Plug 'junegunn/fzf', {'branch': 'master'}
Plug 'junegunn/fzf.vim', {'branch': 'master'}

" EditorConfig
Plug 'editorconfig/editorconfig-vim', {'branch': 'master'}

" Markdown
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install', 'for': 'markdown'}

" File Manager
Plug 'luukvbaal/nnn.nvim'

" Wezterm
Plug 'numToStr/Navigator.nvim'

" Autopairs
Plug 'windwp/nvim-autopairs'
 
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocUpdate'}
Plug 'pangloss/vim-javascript', {'branch': 'master', 'for': 'javascript'}
Plug 'cakebaker/scss-syntax.vim', {'branch': 'master', 'for': 'sass'}
Plug 'HiPhish/rainbow-delimiters.nvim', {'branch': 'master'}
Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'master'}

" Fix class/function name at top
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'kiyoon/treesitter-indent-object.nvim'

" Git
Plug 'tpope/vim-fugitive', {'branch': 'master'}
Plug 'shumphrey/fugitive-gitlab.vim', {'branch': 'master', 'on': 'Gbrowse'}
Plug 'lewis6991/gitsigns.nvim', {'branch': 'main'}
Plug 'sindrets/diffview.nvim', {'branch': 'main'}

" Statusbar
Plug 'nvim-lualine/lualine.nvim', {'branch': 'master'}
Plug 'kyazdani42/nvim-web-devicons', {'branch': 'master'}

" Comment
Plug 'tomtom/tcomment_vim', {'branch': 'master'}

Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
Plug 'honza/vim-snippets'

Plug 'godlygeek/tabular', {'branch': 'master'}
Plug 'alvan/vim-closetag', {'branch': 'master', 'for': 'html'}
Plug 'terryma/vim-multiple-cursors', {'branch': 'master'}
Plug 'mostafaqanbaryan/vim-snippets', {'branch': 'master'}
Plug 'tpope/vim-surround', {'branch': 'master'}
Plug 'tpope/vim-unimpaired', {'branch': 'master'}
Plug 'norcalli/nvim-colorizer.lua', {'branch': 'master'}

" Hardtime
Plug 'm4xshen/hardtime.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'

" Welcome
Plug 'mhinz/vim-startify', {'branch': 'master'}

call plug#end()

" Cache plugins
lua require('impatient')

" <Leader> as <space>
let mapleader = ' '

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
set laststatus=3
set expandtab
set preserveindent
set scrolloff=7
set ruler

 " Maintain undo history between sessions
set undolevels=100
set undofile
set undodir=~/.config/nvim/undodir

set updatetime=400
set backspace=indent,eol,start
set timeout timeoutlen=1000 ttimeoutlen=100
set linebreak
set cindent!
set foldmethod=indent
set foldlevel=2
set wrap
set breakindent
set signcolumn=yes

" Case insensitive UNLESS using uppercase characters
set ignorecase
set smartcase

filetype plugin indent on
let g:startify_session_dir = '~/sessions'

:command! -nargs=0 Config :exe 'edit ' . stdpath('config') . '/init.vim'
:command! -nargs=0 Reload :exe 'source ' . stdpath('config') . '/init.vim'

" Wordpress
:command Sass :silent exe '!sass ' . expand('%:p') . ' ' . expand('%:p:r') . '.css'
:command Minify :silent exe '!echo "nothing exists yet '

" Clear and Redraw screen when an error happens
nnoremap <Leader>l :redraw!<cr>

" clear search
nnoremap <silent> <leader>\ :let @/=''<CR>:nohlsearch<CR>

" Copy/Paste outside vim
nnoremap <C-c><C-c> "+yiw
vnoremap <C-c><C-c> "+y
nnoremap <C-p><C-p> "+p
vnoremap <C-p><C-p> <Esc>o<Esc>"+p

" Add brace to current line
nnoremap <Leader>[ kA{<Esc>jo}<Esc>

" Copy full address
nnoremap <Leader>y :let @+=expand('%')<CR>

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
nnoremap <C-<> <C-W>> " Increase split size
nnoremap <C->> <C-W>< " Decrease split size
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

" Title as filename
autocmd BufEnter * let &titlestring = expand("%:t") . " (" . expand("%:~:h") . ") - Vim"
set title

" Open a file in the same directory as the current one
cnoreabbrev f find %:h

" Stop Rooter echoing the project directory
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '>Projects']
let g:rooter_buftypes = ['']

" Search in VisualMode
vnoremap // y/<C-R>"<CR>
vnoremap // y/<C-R>"<CR>

" Replace word under cursor
nnoremap cu :%s/<C-R><C-W>//cg<Left><Left><Left>

" Close sentence with ;
nnoremap <Leader>; mqA;<Esc>`q

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

" Go to last buffer and delete the current one
nnoremap <silent> <Leader>bd :bnext<CR>:bd#<CR>

" File manager
nnoremap <Leader>r :NnnPicker -deoH %:p:h<CR>

" Fold/Unfold saving
augroup AutoSaveFolds
    autocmd!
    au BufWinLeave *.* mkview 1
    au BufWinEnter *.* silent! loadview 1
augroup END

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" Tabular
nnoremap <Leader>= :Tab /=<CR> :%retab!<CR>
nnoremap <Leader>: :Tab /:<CR> :%retab!<CR>
nnoremap <Leader>, :Tab /,<CR> :%retab!<CR>

" JSX Syntax to JS
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Git Fugitive
let g:fugitive_gitlab_domains = ['https://my.gitlab.com']
nnoremap <Leader>g :Git<CR>
" Conflict
nnoremap g[ :diffget //2<CR>
vnoremap g[ :diffget //2<CR>
nnoremap g] :diffget //3<CR>
vnoremap g] :diffget //3<CR>

" ReRender syntax highlights
nnoremap <F12> :syntax sync fromstart<CR>
inoremap <F12> <ESC>:syntax sync fromstart<CR>a

" COC mapping
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>cu <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd :call CocAction('jumpDefinition')<CR>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-phpls', 'coc-html', 'coc-prettier', 'coc-css', 'coc-eslint', 'coc-svg', 'coc-sql', 'coc-snippets', '@yaegassy/coc-tailwindcss3']
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Prettier on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
autocmd BufWritePre *.php execute "Prettier"

" Select suggestion using Enter
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Terminal mapping
nnoremap \` :term<CR>

" Words with - should be treated as 2 words
set iskeyword-=-

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

" Fuzzy
let g:fzf_preview_window = ['up,50%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.95 } }
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>, 1), 1, fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}), <bang>0)

inoremap <c-x><c-l> <plug>(fzf-complete-line)
command! -bang PFiles call fzf#vim#files('~/Projects', <bang>0)
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>z :PFiles<CR>
nnoremap <Leader>bf :Buffers<CR>
nnoremap <leader>p :exec ":PRg " . escape(input("Search in files: "), "()[]{}$")<CR>
vnoremap <leader>p "cy :exec ":PRg " . escape(getreg("c"), "()[]{}$")<CR>
nnoremap <leader>/ :call fzf#vim#grep("grep function -r " . expand("%"), 0)<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
imap <c-x><c-f> <plug>(fzf-complete-path)

" Markdown
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_port = 9981

lua require 'init'
