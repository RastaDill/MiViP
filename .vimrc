" For NEOVIM
if has('nvim')
    " Neovim plugged directory
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
        Plug 'preservim/tagbar'
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
    let g:airline_powerline_fonts = 1				" enable powerline glyphs
    let g:airline_theme = 'jellybeans'				" set theme
    let g:airline#extensions#tabline#enabled =			" enable the line of buffers
    let g:airline#extensions#tabline#fnamemod = ':t'		" show only filename
    let g:airline#extensions#tabline#tab_nr_type = 1		" show tab number

    " NERDTree
    map <F3> :NERDTreeToggle<CR>				" toggle nerdtree display
    let g:NERDTreeChDirMode=2					" remember last place
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$']			" don't show these file types
    " close vim/nvim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " NERDCommenter'
    let g:NERDDefaultAlign = 'left'				" align commenter to left side

    " Tag bar
    map <F4> :TagbarToggle<CR>					" toggle tagbar display
    let g:tagbar_autofocus = 1					" autofocus on tagbar after he opened

    " Linter
    " settings for flake8
    let g:neomake_python_flake8_maker = {
        \ 'args': ['--ignore=E701',  '--format=default'],
    \ }
    let g:neomake_python_enabled_makers = ['flake8']		" enable flake8
    call neomake#configure#automake('w')			" scan code after write
    nmap <Leader>lo :lopen<CR>					" open location window
    nmap <Leader>lc :lclose<CR>					" close location window
    nmap <Leader>ln :lnext<CR>					" next error/warning
    nmap <Leader>lp :lprev<CR>					" previous error/warning"
    nmap <Leader>ll :ll<CR>					" go to current error/warning

    " Autocomplete
    let g:deoplete#enable_at_startup = 1			" enable start up
    let g:deoplete#disable_auto_complete = 1			" disable autocomplete
    inoremap <expr> <C-Space> deoplete#manual_complete()	" add hot key for open autocomplete
    " sort matches alphabetically
    call deoplete#custom#source('_', 'sorters', ['sorter_word'])
    set completeopt+=noinsert					" auto select first line (like as jedi)
    "set completeopt-=preview					" disable the preview window feature
    set splitbelow						" show preview below
    " auto close preview
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    let g:deoplete#sources#jedi#enable_typeinfo = 0		" disable type information of completions
    let g:deoplete#sources#jedi#show_docstring = 1		" show docstring
    " navigate through the auto-completion list with Tab
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Bracket completions
    "let g:AutoPairsMapCR = 0					" disabled to insert a new indented after <CR> in bracket
    au Filetype vim let b:AutoPairs = {"(": ")", "[": "]"}	" auto pair for only vim-files

    " Colorscheme
    " Unified color scheme (default: dark)
    "   Range:   233 (darkest) ~ 239 (lightest)
    "   Default: 237
    let g:seoul256_background = 235
    colo seoul256
    set background=dark

    " nvim configuration
    set number							" set line number
    set cursorline						" highlight cursor line
    set cursorcolumn						" highlight column line
    set colorcolumn=80						" highlight column 80
    set tabstop=4						" max lenght tab
    "set relativenumber						" set relativenumber
    set mouse=a							" set mode mouse 'all'
    set smartcase						" automatically switch to a case-sensitive search if you use any capital letters
    autocmd BufWritePre *.py :%s/\s\+$//e			" clear empty spaces at the end of lines on save of python files

    ""let g:pyindent_disable_parentheses_indenting = 1
    ""let g:pyindent_open_paren = 0

    " Run Python script
    autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

    " Display all characters
    "set list							" show all characret by default
    if has('multi_byte')
        if version >= 700
            set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
        else
            set listchars=tab:»\ ,trail:·,eol:¶,extends:>,precedes:<,nbsp:_
        endif
    endif
    nmap <F10> :set list!<CR>

" For VIM
else
    " Vim plugged directory
    if has('win32') || has('win64')
        let g:plugged_home = '~/AppData/Local/vim/plugged'
    else
        let g:plugged_home = '~/.vim/plugged'
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

	" Python indention
	Plug 'Vimjas/vim-python-pep8-indent'
        " Bracket completion
        "Plug 'RastaDill/auto-pairs'
        " Python highlighter
	Plug 'vim-python/python-syntax'
        " Colorscheme
	Plug 'altercation/vim-colors-solarized'
	Plug 'joshdick/onedark.vim'

        " Linter and Autocomplete
        " Befo use COC commited neomake and vim-plug
        " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    call plug#end()

    " Highlight
    let g:python_highlight_all = 1

    " Colorsheme
    syntax on
    if (empty($TMUX))
      if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
      endif
      "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
      "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
      " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
      if (has("termguicolors"))
        set termguicolors
      endif
    endif
    colorscheme onedark

    " Airline
    let g:airline_powerline_fonts = 1				" enable powerline glyphs
    let g:airline_theme = 'onedark'				" set theme
    let g:airline#extensions#tabline#enabled = 1		" enable the line of buffers
    let g:airline#extensions#tabline#fnamemod = ':t'		" show only filename
    let g:airline#extensions#tabline#tab_nr_type = 1		" show tab number
    let g:airline_section_z = "%p%% %l:%L"			" customize Z section "%p%% : \ue0a1:%l/%L: Col:%c"

    " NERDTree
    map <F3> :NERDTreeToggle<CR>				" toggle nerdtree display
    let g:NERDTreeChDirMode=2					" remember last place
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$']			" don't show these file types
    " close vim/nvim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " NERDCommenter'
    let g:NERDDefaultAlign = 'left'				" align commenter to left side

    " Tag bar
    map <F4> :TagbarToggle<CR>					" toggle tagbar display
    let g:tagbar_autofocus = 1					" autofocus on tagbar after he opened

    " Linter
    " settings for flake8
    let g:neomake_python_flake8_maker = {
        \ 'args': ['--ignore=E701',  '--format=default'],
    \ }
    let g:neomake_python_enabled_makers = ['flake8']		" enable flake8
    call neomake#configure#automake('w')			" scan code after write
    nmap <silent> <C-M> :lopen<CR><C-W>W;			" open location window
    nmap <silent> <C-J> :lclose<CR>;				" close location window
    nmap <silent> <F8> :lnext<CR>;				" next error/warning
    nmap <silent> <S-F8> :lprev<CR>;				" previous error/warning"
    " nmap <Leader>ll :ll<CR>;					" go to current error/warning

    " COC linter and autocomplete
    " " Load coc-pyright extension
    " let g:coc_global_extensions = [
    "     \ 'coc-pyright',
    " \ ]
    " " disable completion suggestions
    " let b:coc_suggest_disable = 1
    " " Use <c-space> to trigger completion.
    " if has('nvim')
    "     inoremap <silent><expr> <c-space> coc#refresh()
    " else
    "     inoremap <silent><expr> <c-@> coc#refresh()
    " endif
    " " Make <CR> auto-select the first completion item and notify coc.nvim to
    " " format on enter, <cr> could be remapped by other vim plugin
    " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    "                             \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " nmap <silent> <F8> <Plug>(coc-diagnostic-next)          " jump to next message
    " nmap <silent> <S-F8> <Plug>(coc-diagnostic-prev)        " jump to previous message
    " nnoremap <silent> <C-S-M> :<C-u>CocList diagnostics<cr> " show all messages

    " Bracket completions
    "let g:AutoPairsMapCR = 0					" disabled to insert a new indented after <CR> in bracket
    "au Filetype vim let b:AutoPairs = {"(": ")", "[": "]"}	" auto pair for only vim-files

    " vim configuration
    set number							" set line number
    set cursorline						" highlight cursor line
    set cursorcolumn						" highlight column line
    set colorcolumn=80						" highlight column 80
    "set tabstop=4						" max lenght tab
    "set relativenumber						" set relativenumber
    set mouse=a							" set mode mouse 'all'
    set smartcase						" automatically switch to a case-sensitive search if you use any capital letters
    autocmd BufWritePre *.py :%s/\s\+$//e			" clear empty spaces at the end of lines on save of python files

    " Run Python script
    autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

    " Display all characters (spaces, tabs, etc.)
    " set list							" show all characret by default
    if has('multi_byte')
        if version >= 700
            set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
        else
            set listchars=tab:»\ ,trail:·,eol:¶,extends:>,precedes:<,nbsp:_
        endif
    endif
    nmap <F9> :set list!<CR>

     "vnoremap <silent> # :s/^/#/<cr>:noh<cr>
     "vnoremap <silent> -# :s/^#//<cr>:noh<cr>
endif

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
