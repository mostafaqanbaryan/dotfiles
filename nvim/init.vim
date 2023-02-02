set shell=/bin/bash

" Plug Start
call plug#begin('~/.config/nvim/bundle/')

Plug 'xiyaowong/nvim-transparent'

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

" Note
Plug 'xolox/vim-misc', {'branch': 'master'}
Plug 'xolox/vim-notes', {'branch': 'master'}

" Ranger
Plug 'kevinhwang91/rnvimr'

" Wezterm
Plug 'numToStr/Navigator.nvim'

" Scroll
Plug 'karb94/neoscroll.nvim'

" Autopairs
Plug 'windwp/nvim-autopairs'
 
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript', {'branch': 'master', 'for': 'javascript'}
Plug 'cakebaker/scss-syntax.vim', {'branch': 'master', 'for': 'sass'}

" Fix class/function name at top
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'neovim/nvim-lspconfig', {'branch': 'master'}
" Plug 'SmiteshP/nvim-navic', {'branch': 'master'}

" Git
Plug 'tpope/vim-fugitive', {'branch': 'master'}
Plug 'shumphrey/fugitive-gitlab.vim', {'branch': 'master', 'on': 'Gbrowse'}
Plug 'lewis6991/gitsigns.nvim', {'branch': 'main'}

" Statusbar
Plug 'nvim-lualine/lualine.nvim', {'branch': 'master'}
Plug 'kyazdani42/nvim-web-devicons', {'branch': 'master'}

" Comment
Plug 'tomtom/tcomment_vim', {'branch': 'master'}

Plug 'godlygeek/tabular', {'branch': 'master'}
Plug 'SirVer/ultisnips', {'branch': 'master'}
Plug 'alvan/vim-closetag', {'branch': 'master', 'for': 'html'}
Plug 'terryma/vim-multiple-cursors', {'branch': 'master'}
Plug 'mostafaqanbaryan/vim-snippets', {'branch': 'master'}
Plug 'tpope/vim-surround', {'branch': 'master'}
Plug 'tpope/vim-unimpaired', {'branch': 'master'}
Plug 'norcalli/nvim-colorizer.lua', {'branch': 'master'}

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
let g:startify_session_dir = '~/sessions'

:command! -nargs=0 Config :exe 'edit ' . stdpath('config') . '/init.vim'
:command! -nargs=0 Reload :exe 'source ' . stdpath('config') . '/init.vim'

" Save session on close
autocmd VimLeavePre * call SaveSessionOnLeave()
function SaveSessionOnLeave()
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
nnoremap <silent> <leader>\ :let @/=''<CR>:nohlsearch<CR>

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
nnoremap <Leader>[ kA{<Esc>jo}<Esc>

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
" let g:airline_theme='deus'

lua require 'me.tokyonight'

colorscheme tokyonight-night
hi TreesitterContext guibg=#2C314C
hi TreesitterContextLineNumber guifg=#98C379

" Using Catppuccin colors
hi Folded guibg=NONE
hi Folded guifg=#7a6750
hi Folded ctermbg=NONE
hi Search guibg=#404456  
hi Search guifg=#ff6000

" Title as filename
autocmd BufEnter * let &titlestring = expand("%:t") . " (" . expand("%:~:h") . ") - Vim"
set title

" Open a file in the same directory as the current one
cnoreabbrev f find %:h

" Stop Rooter echoing the project directory
let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '>Projects']
let g:rooter_buftypes = ['']

" Search in VisualMode
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

" Ranger
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 0
" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1
" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 70
nnoremap <Leader>r :RnvimrToggle<CR>

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

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Git Fugitive
let g:fugitive_gitlab_domains = ['https://my.gitlab.com']
nnoremap <Leader>g :Git<CR>

" ReRender syntax highlights
nnoremap <F12> :syntax sync fromstart<CR>
inoremap <F12> <ESC>:syntax sync fromstart<CR>a

" COC mapping
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> gd :call CocAction('jumpDefinition')<CR>
nmap <silent> gr <Plug>(coc-references)
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-phpls', 'coc-html', 'coc-prettier', 'coc-css', 'coc-eslint', 'coc-svg', 'coc-sql', 'coc-snippets', '@yaegassy/coc-tailwindcss3']

" Prettier on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

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
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 0, fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel')[:-2]}), <bang>0)
command! -bang PFiles call fzf#vim#files('~/Projects', <bang>0)
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>z :PFiles<CR>
nnoremap <Leader>bf :Buffers<CR>
nnoremap <leader>p :PRg<space>
vnoremap <leader>p y:PRg <C-r>"<CR>
nnoremap <leader>/ :call fzf#vim#grep("grep function -r " . expand("%"), 0)<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
imap <c-x><c-f> <plug>(fzf-complete-path)

lua require 'colorizer'.setup()
lua require 'neoscroll'.setup()
lua require 'nvim-autopairs'.setup()
lua require 'me.toggleterm'
lua require 'me.gitsigns'
lua require 'me.treesitter'
lua require 'me.statusbar'
lua require 'me.navigator'
lua <<END
require("transparent").setup({
  enable = true
})
END
