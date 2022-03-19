call plug#begin()           
  Plug 'bilalq/lite-dfm'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  Plug 'unblevable/quick-scope'
  Plug 'justinmk/vim-sneak'
  Plug 'reedes/vim-pencil'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'psliwka/vim-smoothie'
  Plug 'xolox/vim-notes'
  Plug 'xolox/vim-misc'
call plug#end()
let g:lite_dfm_left_offset = 1
let mapleader = ','
set background=light
colorscheme PaperColor
set hidden
set tabstop=2
set shiftwidth=2
set expandtab "табы пробеламим
set softtabstop=2 "2 пробела в табе
set wrap linebreak
"set autoindent
" ignore text case when search
set ignorecase
set smartcase
" search when you type
set incsearch
syntax on "syntax higligth
set mousehide "hide coursore when type text
set mouse=a "mouse поддержка
set termencoding=utf-8 
set encoding=utf-8 " Кодировка файлов по умолчанию
" for system clipboard "+y copy to global 
" +p paste 
set clipboard+=unnamed
" insert blank line shift enter before current line enter 
nmap <CR> o<Esc>
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set langmap+=ЖжЭэХхЪъ;\:\;\"\'{[}]
nnoremap j gj 
nnoremap k gk
nnoremap о gj
nnoremap л gk
nnoremap ю .
nnoremap . /
set noshowmode
set noswapfile
set nobackup
set noerrorbells
set belloff=all
augroup Textgroup
	autocmd!
	autocmd BufEnter * :SoftPencil
	autocmd BufEnter * :LiteDFM
augroup END
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

map а f
map А F
map е t
map Е T
map ж ;
map б ,
map Ї }
let g:qs_max_chars=20000
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_accepted_chars = ['ф','и','с','в','у','а','п','р','ш','о','л','д','ь','т','щ','з','й','к','ы','е','г','м','ц','ч','я']
highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#90c25f' gui=underline ctermfg=81 cterm=underline
highlight Sneak guifg='#afff5f'gui=underline ctermfg=155 cterm=underline
highlight SneakScope guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
hi! link Sneak Search
let g:sneak#label = 1   
" case insensitive sneak
let g:sneak#use_ic_scs = 1
" immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1
let g:sneak#target_labels = 'фіваолджсчятиуцгнщйш'
" 2-character Sneak (default)
nmap і <Plug>Sneak_s
nmap І <Plug>Sneak_S
" visual-mode
xmap і <Plug>Sneak_s
xmap І <Plug>Sneak_S
" operator-pending-mode
omap і <Plug>Sneak_s
omap І <Plug>Sneak_S

" repeat motion
" gS
map пІ <Plug>Sneak_,
map пі <Plug>Sneak_;

" label-mode
nmap і <Plug>SneakLabel_s
nmap І <Plug>SneakLabel_S

nnoremap \ :noh<return>
" Clear cmd line message
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

augroup cmd_msg_cls
    autocmd!
    autocmd CmdlineLeave :  call timer_start(2000, funcref('s:empty_message'))
augroup END

map Ґ ~

let g:notes_directories = ['~/notes']
let g:notes_suffix = '.txt'
nnoremap <Leader>z :LiteDFMToggle<CR>i<Esc>`^

