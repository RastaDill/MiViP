if has('nvim')
	" Neovim specific commands
	if has('win32') || has('win64')
		let g:plugged_home = '~/AppData/Local/nvim/plugged'
	else
		let g:plugged_home = '~/.config/nvim/plugged'
	endif

	" Plugins List
	call plug#begin(g:plugged_home)
		" Airline
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		" Better file browser
		Plug 'preservim/nerdtree'
		Plug 'preservim/nerdcommenter'
		" Tag bar
		Plug 'majutsushi/tagbar'
		" Linter
		Plug 'neomake/neomake'
		" Autocomplete
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
		Plug 'deoplete-plugins/deoplete-jedi'
		" Bracket completion
		Plug 'jiangmiao/auto-pairs'
		" Python highlighter
		Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
		" Colorscheme
		Plug 'junegunn/seoul256.vim'
	call plug#end()
	
	" Airline
	let g:airline_powerline_fonts = 1						" enable powerline glyphs
	let g:airline_theme = 'jellybeans'						" set theme
	let g:airline#extensions#tabline#enabled = 1			" enable the line of buffers
	let g:airline#extensions#tabline#fnamemod = ':t'		" show only filename
	let g:airline#extensions#tabline#tab_nr_type = 1		" show tab number
	
	" NERDTree
	map <F3> :NERDTreeToggle<CR>							" toggle nerdtree display
	let g:NERDTreeChDirMode=2								" remember last place
	let NERDTreeIgnore = ['\.pyc$', '\.pyo$']				" don't show these file types
	" close vim/nvim if the only window left open is a NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	" NERDCommenter'
	let g:NERDDefaultAlign = 'left'							" align commenter to left side

	" Tag bar
	map <F4> :TagbarToggle<CR>								" toggle tagbar display
	let g:tagbar_autofocus = 1								" autofocus on tagbar after he opened

	" Linter
	" settings for flake8
	let g:neomake_python_flake8_maker = {
		\ 'args': ['--ignore=E701',  '--format=default'],
	\ }
	let g:neomake_python_enabled_makers = ['flake8']		" enable flake8
	call neomake#configure#automake('w')					" scan code after write
	nmap <Leader>lo :lopen<CR>								" open location window
	nmap <Leader>lc :lclose<CR>								" close location window
	nmap <Leader>ln :lnext<CR>								" next error/warning
	nmap <Leader>lp :lprev<CR>								" previous error/warning"
	nmap <Leader>ll :ll<CR>									" go to current error/warning

	" Autocomplete
	let g:deoplete#enable_at_startup = 1					" enable start up
	let g:deoplete#disable_auto_complete = 1				" disable autocomplete
	inoremap <expr> <C-Space> deoplete#manual_complete()	" add hot key for open autocomplete
	" sort matches alphabetically
	call deoplete#custom#source('_', 'sorters', ['sorter_word'])
	set completeopt+=noinsert								" auto select first line (like as jedi)
	"set completeopt-=preview								" disable the preview window feature
	set splitbelow											" show preview below
	" auto close preview
	autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
	let g:deoplete#sources#jedi#enable_typeinfo = 0			" disable type information of completions
	let g:deoplete#sources#jedi#show_docstring = 1			" show docstring
	" navigate through the auto-completion list with Tab
	inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

	" Bracket completions
	"let g:AutoPairsMapCR = 0								" disabled to insert a new indented after <CR> in bracket
	au Filetype vim let b:AutoPairs = {"(": ")", "[": "]"}	" auto pair for only vim-files
	
	" Colorscheme
	" Unified color scheme (default: dark)
	"   Range:   233 (darkest) ~ 239 (lightest)
	"   Default: 237
	let g:seoul256_background = 235
	colo seoul256
	set background=dark

	" nvim configuration
	set number												" set line number
	set cursorline											" highlight cursor line
	set cursorcolumn										" highlight column line
	set colorcolumn=80										" highlight column 80
	set tabstop=4											" max lenght tab
	"set relativenumber										" set relativenumber
	set mouse=a												" set mode mouse 'all'
	set smartcase											" automatically switch to a case-sensitive search if you use any capital letters
	autocmd BufWritePre *.py :%s/\s\+$//e					" clear empty spaces at the end of lines on save of python files
	
	""let g:pyindent_disable_parentheses_indenting = 1
	""let g:pyindent_open_paren = 0

	" Run Python script
	autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
	autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

	" Display all characters
	"set list												" show all characret by default
	if has('multi_byte')
		if version >= 700
			set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
		else
			set listchars=tab:»\ ,trail:·,eol:¶,extends:>,precedes:<,nbsp:_
		endif
	endif
	nmap <F10> :set list!<CR>
else
	" Standard vim specific commands
	" Vundle initialization
	" ============================================================================
	" Avoid modify this section, unless you are very sure of what you are doing

	" no vi-compatible, if set - now show enterd key in right down corner
	" set nocompatible

	" Setting up Vundle - the best vim plugin manager
	let iCanHazVundle=1
	let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
	if !filereadable(vundle_readme)
	    echo "Installing Vundle..."
	    echo ""
	    silent !mkdir -p ~/.vim/bundle
	    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
	    let iCanHazVundle=0
	endif

	filetype off

	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()

	" let Vundle manage Plugins
	Plugin 'VundleVim/Vundle.vim'

	" ============================================================================

	" Airline
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'

	" Airline
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'jellybeans'
	let g:airline#extensions#whitespace#enabled = 0
	" enable the list of buffers
	let g:airline#extensions#tabline#enabled = 1
	" show just the filename
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline#extensions#tabline#show_splits = 0
	" tab number
	let g:airline#extensions#tabline#tab_nr_type = 1



	" Better file browser
	"Plugin 'preservim/nerdtree'

	" NERDTree 

	" toggle nerdtree display
	map <F3> :NERDTreeToggle<CR>
	" open nerdtree with the current file selected
	nmap ,t :NERDTreeFind<CR>
	" don;t show these file types
	let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
	" auto open or close NERDTree
	autocmd vimenter * if !argc() | NERDTree | endif
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	" Code commenter
	Plugin 'preservim/nerdcommenter'
	" \\\ con/uncom line \\ com/uncom block \cc com \cu uncom
	" Align line-wise comment delimiters flush left instead of following code indentation
	let g:NERDDefaultAlign = 'left'

	" Indent text object
	" Visual selected block to indent Vii example
	Plugin 'michaeljsmith/vim-indent-object'


	" --- Very slow
	" " Code highlighting
	" Plugin 'sheerun/vim-polyglot'
	" syntax on
	" let g:python_highlight_all = 1

	" " Linting
	" Plugin 'dense-analysis/ale'
	" let g:ale_linters = {
	"       \   'python': ['flake8', 'pylint'],
	"       \   'ruby': ['standardrb', 'rubocop'],
	"       \   'javascript': ['eslint'],
	"       \}
	" " let g:ale_fixers = {
	" "       \    'python': ['yapf'],
	" "       \}
	" " nmap <F10> :ALEFix<CR>
	" " let g:ale_fix_on_save = 1
	" --- Very slow

	" Show number line
	set number

	" Run Python script
	autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
	autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

	" Python style

	syntax on
	let g:syntastic_python_flake8_post_args='--ignore=E701'

	" clear empty spaces at the end of lines on save of python files
	autocmd BufWritePre *.py :%s/\s\+$//e
	" indent - used spaces
	" shiftwidth - create indent (hotkeys << >>)
	au BufNewFile,BufRead *.py
	    \ set tabstop=4 |
	    \ set softtabstop=4 |
	    \ set shiftwidth=4 |
	    \ set textwidth=79 |
	    \ set expandtab |
	    \ set autoindent |
	    \ set fileformat=unix |

	au BufNewFile,BufRead *.js, *.html, *.css
	    \ set tabstop=2 |
	    \ set softtabstop=2 |
	    \ set shiftwidth=2 |

	set backspace=2 " make backspace work like most other apps
	set backspace=indent,eol,start

	" Python colorsheme
	set background=dark 
	colorscheme gruvbox
	nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
	nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
	nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
	nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
	nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
	nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

	" Highlight cursor line and column
	set cursorline
	set cursorcolumn

	" Show spaces
	set list
	if has('multi_byte')
	    if version >= 700
		set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
	    else
		set listchars=tab:»\ ,trail:·,eol:¶,extends:>,precedes:<,nbsp:_
	    endif
	endif
	nmap <leader>l :set list!<CR>

	" Syntastic
	" Recommended settings
	" set statusline+=%#warningmsg#
	" set statusline+=%{SyntasticStatuslineFlag()}
	" set statusline+=%*
	" let g:syntastic_always_populate_loc_list = 1
	" let g:syntastic_auto_loc_list = 1
	" let g:syntastic_check_on_open = 1
	" " Display checker-name for that error-message
	" let g:syntastic_aggregate_errors = 1
	" " I use the brew to install flake8
	" let g:syntastic_python_checkers_args=['flake8', 'python3']
	" let g:syntastic_python_flake8_post_args='--ignore=E265,W191'

	" vnoremap <silent> # :s/^/#/<cr>:noh<cr>
	" vnoremap <silent> -# :s/^#//<cr>:noh<cr>


	" new file set title and turn to endline
	autocmd BufNewFile *.sh,*.py,*.rb exec ":call SetTitle()"
	function SetTitle()
	    if &filetype == 'sh'
		call setline(1,"\#!/bin/bash")
		call append(line("."), "")

	    elseif &filetype == 'python'
		call setline(1,"#!/usr/bin/env python")
		call append(line("."),"# coding=utf-8")
		    call append(line(".")+1, "") 

	    elseif &filetype == 'ruby'
		call setline(1,"#!/usr/bin/env ruby")
		call append(line("."),"# encoding: utf-8")
		    call append(line(".")+1, "")
	    endif
	endfunction
	autocmd BufNewFile * normal G
endif
