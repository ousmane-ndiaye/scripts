filetype plugin indent on
execute pathogen#infect()
execute pathogen#helptags()
set nocompatible
set tabstop=4
set softtabstop=4
set shiftwidth=4
set hlsearch
set ruler
set number
set ignorecase
set smartcase
set title
set autoindent
set smartindent
set nocindent
set expandtab
au FileType helpfile set nonumber      " no line numbers when viewing help
au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
au FileType cpp,c,java,sh,pl,php,phtml,asp,xml,javascript  set smartindent
nnoremap <F12> :set invpaste paste?<CR>
set pastetoggle=<F12>
set showmode
au BufWritePost *.sh !chmod +x %
au BufWritePost *.pl !chmod +x %

au BufNewFile,BufRead  *.pls    set syntax=dosini
au BufNewFile,BufRead  *.scss    set ft=scss.css
:au! BufWritePost $MYVIMRC source $MYVIMRC

au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType c set omnifunc=ccomplete#Complete

au FileType php noremap <C-L> :!php -l %<CR>
" au Filetype html,xml,xsl source ~/.vim/closetag.vim

" phpchecks
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['php', 'javascript',
                           \ 'cucumber', 'html', 'sh', 'scss', 'css', 'json',
                           \ 'yaml'],
                           \ 'passive_filetypes': ['html'] }

let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args='--report=csv --standard=zend '
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1



highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

inoremap <C-C> <ESC>:quit<CR>
nnoremap <C-C> :quit<CR>
vnoremap <C-C> :quit<CR>

nnoremap <silent> <F3> :call <SID>StripTrailingWhitespaces()<CR>

inoremap <C-B> <DSE>:BehatCmdToClipBoard<CR>
nnoremap <C-B> :BehatCmdToClipBoard<CR>
vnoremap <C-B> :BehatCmdToClipBoard<CR>

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
" cscope add ~/.vim/cscope/currentdb.out /www/vhosts/
"
set mouse=a
set cursorline
set virtualedit=onemore
set nospell
set history=1000
set nocursorline
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

" Buffer Switching:
"   F5 = previous buffer
"   F6 = next buffer
"   Ctrl + K = kill buffer
inoremap <F5> <Esc>:bp<CR>
inoremap <F6> <Esc>:bn<CR>
inoremap <C-K> <Esc>:bd<CR>
noremap <F5> <Esc>:bp<CR>
noremap <F6> <Esc>:bn<CR>
noremap <C-K> <Esc>:bd<CR>

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

set laststatus=2

" Broken down into easily includeable segments
set statusline=%<%f\ " Filename
set statusline+=%w%h%m%r " Options
" set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y] " filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info

if has('gui_running')
    colorscheme solarized
else
    set background=dark
endif


nnoremap <F2> :NERDTreeToggle<CR>

let feature_filetype='behat'

" Tidier backups
set backupdir=~/.vim/tmp/backup/
set backup

if has("autocmd")
  autocmd BufWritePre * let &backupext = substitute(expand('%:p:h'), '/', '%', 'g') . '~'
  autocmd BufWritePre *models/*.php,*services/*.php :call <SID>StripTrailingWhitespaces()
endif

set directory=~/.vim/tmp/swap//
set directory+=.

set viminfo+=n~/.vim/viminfo

set undodir=~/.vim/tmp/undo//
set undofile
set undolevels=1000
set undoreload=10000

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
endif
