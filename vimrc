"                     {/ ． ．\}
"                     ( (oo)   )
" +-------------oOOo---︶︶︶︶---oOOo-------------+
"                                      _  ___
"                                       \/ _/
"                                      _/ /ian__
"                                     /__/\ \/ /
"                                          \  /
"                                          /_/un
"
"
"                                   闲耘™ (@hotoo)
"                             hotoo.cn[AT]gmail.com
"
" +---------------------------------Oooo-----------+
"
" @see http://vim.wikia.com/wiki/Version_Control_for_Vimfiles



" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'


Plugin 'ryanoasis/vim-devicons'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'bling/vim-airline'
"Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDTreeShowLineNumbers=1

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'hotoo/NERD_tree-Project'

" Plugin 'scrooloose/syntastic'
Plugin 'dense-analysis/ale' " 异步 Lint 引擎

Plugin 'lovehub/noteplan-vim'
let g:calendar_weeknm = 5 " 1
let g:calendar_number_of_months = 2
let g:calendar_diary=$HOME.'/Library/Containers/co.noteplan.NotePlan3/Data/Library/Application Support/co.noteplan.NotePlan3/Calendar'
let g:calendar_diary_extension = '.md'
let g:calendar_filetype = 'vimwiki'

" Calendar
" @see http://www.gracecode.com/archives/674/
let g:calendar_smnd = 1
let g:calendar_monday = 1                   " week start with monday.
let g:calendar_mark = 'left-fit'            " let plus(+) near the date, like +8.
"let g:calendar_mruler = '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月'
let g:calendar_wruler = '日 一 二 三 四 五 六'
"let g:calendar_navi_label = '上月,本月,下月'

" Plugin 'hotoo/calendar-vim'
Plugin 'hotoo/pangu.vim'
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
Plugin 'ap/vim-css-color'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vimcn/matchit.vim.cnx'
" Plugin 'inkarkat/vim-mark'

Plugin 'hotoo/highlight-cursor-word.vim'

" DOCUMENT ================================================================{{{
Plugin 'vimcn/vimcdoc'
" }}}

" PROJECT MANAGER ========================================================={{{
Plugin 'TaskList.vim'
" Plugin 'taglist.vim'
" Plugin 'tagbar'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)',
  \ 'file': '\v\.(exe|so|dll|dat|pdf|sketch|doc|docx|pages|numbers|key)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

Plugin 'mru.vim'
" }}}

" == COMPLETION ==========================================================={{{
Plugin 'ternjs/tern_for_vim'
Plugin 'msanders/snipmate.vim'
Plugin 'vimcn/snipMate.vim.cnx'
Plugin 'hotoo/snippets'
let g:snippets_dir = '~/.vim/bundle/snippets'
" Plugin 'AutoComplPop'
Plugin 'ZenCoding.vim'
Plugin 'hotoo/template.vim'
let g:template_author = '冒顿'
" Plugin 'Valloric/YouCompleteMe' " Very good.
let g:ycm_semantic_triggers = {
   \   'css': [ 're!^\s{2,}', 're!:\s+' ],
   \   'less': [ 're!^\s{2,}', 're!:\s+' ],
   \   'sass': [ 're!^\s{2,}', 're!:\s+' ],
   \   'scss': [ 're!^\s{2,}', 're!:\s+' ],
   \ }
Plugin 'zxqfl/tabnine-vim'
set complete=k
"Plugin 'Shougo/neocomplete.vim'
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" }}}

" SYNTAX ================================================================={{{
Plugin 'hotoo/vimwiki'
" Plugin 'vimwiki/vimwiki' " 回车时关闭中文输入法，没有高亮日记里的 Markdown
Plugin 'vimcn/vimwiki.vim.cnx'
Plugin 'tpope/vim-markdown'
Plugin 'digitaltoad/vim-jade'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'
" TypeScript
Plugin 'leafgarland/typescript-vim'
" Plugin 'peitalin/vim-jsx-typescript'
" let g:jsx_pragma_required = 1
" Plugin 'MaxMEllon/vim-jsx-pretty'

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact


"Plugin 'gabrielelana/vim-markdown' " 与 Vimwiki 配合不好。

Plugin 'elzr/vim-json'

" autocmd FileType json setlocal formatprg=js2json|jsonmatter " npm i @hotoo/js2json jsonmatter -g
autocmd FileType json setlocal formatprg=jsonmatter " npm i @hotoo/js2json jsonmatter -g
autocmd FileType javascript setlocal formatprg=js-beautify\ --stdin\ --indent-size\ 2 " npm i js-beautify -g, Support ES2015 but not good.
" autocmd FileType javascript setlocal formatprg=eslint\ --fix\ --stdin " npm i eslint -g, Not support --fix within --stdin.
Plugin 'velocity.vim'
Plugin 'hotoo/jsgf.vim'
let g:jsgf_option_open = 'vnew'

Plugin 'itspriddle/vim-marked'
let g:marked_app = "Marked"

Plugin 'vimcn/node-vimdoc'

Plugin 'aklt/plantuml-syntax' " puml
let g:plantuml_executable_script='~/.vim/bin/plantuml'

" 复制图片粘贴到 Markdown 文件中。
Plugin 'ferrine/md-img-paste.vim'
autocmd FileType markdown nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'assets'
let g:mdip_imgname = 'image'
Plugin 'wookayin/vim-typora'
" }}}


if has("win32") || has("win32unix")
  let g:OS#name = "win"
  let g:OS#win = 1
  let g:OS#mac = 0
  let g:OS#unix = 0
elseif has("mac")
  let g:OS#name = "mac"
  let g:OS#mac = 1
  let g:OS#win = 0
  let g:OS#unix = 0
elseif has("unix")
  let g:OS#name = "unix"
  let g:OS#unix = 1
  let g:OS#win = 0
  let g:OS#mac = 0
endif

if has("gui_running")
  let g:OS#gui = 1
else
  let g:OS#gui = 0
endif

if g:OS#win
  let VIM_HOME = $VIM . "\\"
  let TMP_POSTFIX = "_"
else
  let VIM_HOME = "~/.vim/"
  let TMP_POSTFIX = "."
endif

set nocompatible


" quick startup mode.
set shortmess=atI

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,utf-8,chinese,latin-1
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.UTF-8


filetype plugin on
filetype indent on
syntax on
filetype on


" 文件格式，默认 ffs=dos,unix
set fileformat=unix
set fileformats=unix,mac,dos

set noimd
set imi=2
set ims=2

" theme, skin, color
if g:OS#gui
  colorscheme hotoo_manuscript
else
  colorscheme default
endif


" @see :help mbyte-IME
if has('multi_byte_ime')
  highlight Cursor guibg=#F0E68C guifg=#708090
  highlight CursorIM guibg=Purple guifg=NONE
endif



" fonts
" @see http://support.microsoft.com/kb/306527/zh-cn
" @see http://www.gracecode.com/archives/1545/
" @see http://blog.xianyun.org/2009/09/14/vim-fonts.html
if g:OS#win
  set guifont=Courier_New:h12:cANSI
elseif g:OS#mac
  "set guifont=Courier_New:h16
  " set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
  "set guifont=Sauce\ Code\ Powerline:h14
  set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h14
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
  autocmd FileType diff set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h10
  " if &ft == "diff"
  " endif

  let g:airline_powerline_fonts = 1
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
endif

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1


" set max window size.
if g:OS#win && g:OS#gui
  au GUIEnter * simalt ~x
elseif g:OS#mac && g:OS#gui
  set transparency=5
  set columns=180
  set lines=99
elseif g:OS#unix
  " for Gnome.
  " $ sudo apt-get install wmctrl
  " http://fluxbox.sourceforge.net/docbook/zh_cn/html/ch03s05.html
  autocmd GUIEnter * silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
else
  set columns=180
  set lines=99
endif



" 加速光标闪烁。
" @see http://c9s.blogspot.com/2007/12/gvim.html
"set guicursor+=n-v-c:block-cursor-blinkwait300-blinkon90-blinkoff90
"set guicursor+=i:block-cursor-blinkwait200-blinkon110-blinkoff110
"set guicursor+=v:ver90-cursor-blinkwait200-blinkon150-blinkoff150

" Tabs
set softtabstop=2
set expandtab       " replace tab to whitespace.
set tabstop=2       " show tab indent word space.
set shiftwidth=2    " tab length

"autocmd FileType html,xhtml,velocity setl softtabstop=2 | setl tabstop=2 | setl shiftwidth=2
"
set linebreak       " break full word.
set autoindent      " new line indent same this line.
set smartindent

set hlsearch
set incsearch

set splitright
"set splitbelow

" Folds.
set foldmethod=syntax
set foldlevel=6
set foldcolumn=0
set foldtext=SimpleFoldText()

" 简明折叠文本
function SimpleFoldText()
  let firstLine = getline(v:foldstart)
  " let firstLine = substitute(firstLine, '/\*\|\*/\|{{{\d\=', '', 'g')
  let firstLine = substitute(firstSub, '^\s\+', '', 'g')

  let lastLine = getline(v:foldend)
  let lastLine = substitute(lastLine, '^\s\+', '', 'g')
  let lines = v:foldend - v:foldstart
  let space = repeat(' ', 120 - len(firstLine) - len(lastLine) - len(lines) - 11)
  return firstLine . '...' . lastLine . space . '[' . lines . ' lines]'
  " return v:folddashes . firstLine . '...' . lastLine . space . '[' . lines . ' lines]'
endfunction

Plugin 'masukomi/vim-markdown-folding'
autocmd FileType vimwiki set foldexpr=NestedMarkdownFolds()

set ignorecase
set smartcase
set number

" fixed.
set scrolloff=3

set autochdir
set colorcolumn=81,121
set synmaxcol=999

set keywordprg=:help


" 设置宽度不明的文字(如 “”①②→ )为双宽度文本。
" @see http://blog.sina.com.cn/s/blog_46dac66f010006db.html
"set ambiwidth=double " 设置该选项，会导致 airline/powerline 的右侧会出现脱节。


" share system clipboard.
"set clipboard+=unnamed


" Show tab number in your tab line
" @see http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
" :h tabline
if g:OS#gui
  " TODO: for MacVim.
  set guitablabel=%N.%t
endif


" swrap file, auto backup.
set nobackup
if g:OS#win
  set directory=$VIM\_tmp
else
  set directory=~/.vim/.tmp
endif


" fullscreen
let s:fullscreen = 0
function! FullScreenToggle()
  if g:OS#win
    if has("libcall")
      call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
    endif
  elseif g:OS#mac
    " 原生支持。
    if &fullscreen
      set nofullscreen
    else
      set fullscreen
    endif
  elseif g:OS#unix
    " 系统设置->键盘快捷键->窗口管理->切换全屏模式(F11)
    if executable("wmctrl")
      if s:fullscreen
        " FIXME.
        silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
        let s:fullscreen = 0
      else
        silent !wmctrl -r :ACTIVE: -b add,fullscreen
        let s:fullscreen = 1
      endif
    endif
  endif
endfunction
command -nargs=0 FullScreen :call FullScreenToggle()


" 快捷打开特定文件。
if g:OS#win
  au! bufwritepost hosts silent !start cmd /C ipconfig /flushdns
  " @see http://practice.chatserve.com/hosts.html
  command -nargs=0 Hosts silent tabnew c:\windows\system32\drivers\etc\hosts

  command -nargs=0 Vimrc silent tabnew $VIM/vimfiles/vimrc
  command -nargs=0 Sysrc silent tabnew $VIM/vimfiles/sysrc
else
  " readonly.
  command -nargs=0 Hosts :!sudo gvim /etc/hosts

  command -nargs=0 Vimrc :silent! tabnew ~/.vim/vimrc
  command -nargs=0 Sysrc :silent! tabnew ~/.vim/sysrc
endif


hi TabLine     cterm=none ctermfg=lightgrey ctermbg=lightblue guifg=gray guibg=black
hi TabLineSel  cterm=none ctermfg=lightgrey ctermbg=LightMagenta guifg=white guibg=black
hi TabLineFill cterm=none ctermfg=lightblue ctermbg=lightblue guifg=black guibg=black



set history=500


if has("persistent_undo")
  set undofile
  set undolevels=1000

  if g:OS#win
    set undodir=$VIM\_undodir
    au BufWritePre _undodir/* setlocal noundofile
  else
    set undodir=~/.vim/.undodir
    au BufWritePre ~/.vim/.undodir/* setlocal noundofile
  endif
endif



" User Defined Status Line.
" @see http://www.vim.org/scripts/script.php?script_id=8 for VimBuddy.
function! GetFileTime()
  " FIXME: get file name.
  let file = expand("%")
  if "" == file
    return ""
  endif
  let lastmodify = getftime(file)
  let str = strftime('%Y/%m/%d %H:%M:%S', lastmodify)
  let Y = strftime('%Y', lastmodify)
  let m = strftime('%m', lastmodify)
  let d = strftime('%d', lastmodify)
  let H = strftime('%H', lastmodify)
  let M = strftime('%M', lastmodify)
  let S = strftime('%S', lastmodify)

  echomsg str
  return str
endfunction
command -nargs=0 LastModify :call GetFileTime()



set laststatus=2
set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]
"let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
"hi User1 cterm=italic ctermfg=blue
"hi User2 cterm=bold


" =========== Mappings =============

" Normal Mode, Visual Mode, and Select Mode,
" use <Tab> and <Shift-Tab> to indent
" @see http://c9s.blogspot.com/2007/10/vim-tips.html
"nmap <tab> v>                  " :h ctrl-i :h <tab>
"nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" [fanyi](https://github.com/afc163/fanyi)
nnoremap <Leader>d :!fanyi <cword><CR>
vnoremap <Leader>d y:!fanyi <c-r>"<CR>

" 选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
" just for xml document, but need not for now.
"inoremap < <c-r>=OpenPair('<')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
  let PAIRs = {
        \ '{' : '}',
        \ '[' : ']',
        \ '(' : ')',
        \ '<' : '>'
        \}
  if line('$')>2000
    let line = getline('.')

    let txt = strpart(line, col('.')-1)
  else
    let lines = getline(1,line('$'))
    let line=""
    for str in lines
      let line = line . str . "\n"
    endfor

    let blines = getline(line('.')-1, line("$"))
    let txt = strpart(getline("."), col('.')-1)
    for str in blines
      let txt = txt . str . "\n"
    endfor
  endif
  let oL = len(split(line, a:char, 1))-1
  let cL = len(split(line, PAIRs[a:char], 1))-1

  let ol = len(split(txt, a:char, 1))-1
  let cl = len(split(txt, PAIRs[a:char], 1))-1

  if oL>=cL || (oL<cL && ol>=cl)
    return a:char . PAIRs[a:char] . "\<Left>"
  else
    return a:char
  endif
endfunction
function! ClosePair(char)
  if getline('.')[col('.')-1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
function! CompleteQuote(quote)
  if strlen(visualmode(1))
    return a:quote
  endif

  let ql = len(split(getline('.'), a:quote, 1))-1
  let slen = len(split(strpart(getline("."), 0, col(".")-1), a:quote, 1))-1
  let elen = len(split(strpart(getline("."), col(".")-1), a:quote, 1))-1
  let isBefreQuote = getline('.')[col('.') - 1] == a:quote

  if '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
    " for vim comment.
    return a:quote
  elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
    " for Name's Blog.
    return a:quote
  elseif (ql%2)==1
    " a:quote length is odd.
    return a:quote
  elseif ((slen%2)==1 && (elen%2)==1 && !isBefreQuote) || ((slen%2)==0 && (elen%2)==0)
    return a:quote . a:quote . "\<Left>"
  elseif isBefreQuote
    return "\<Right>"
  else
    return a:quote . a:quote . "\<Left>"
  endif
endfunction


" [count]<Space> key in normal model.
nmap <space> :<C-U>call NormalSpace()<cr>
function! NormalSpace()
  let col=col(".")-1
  let text=getline(".")
  call setline(line("."), strpart(text,0,col).repeat(" ", v:count1).strpart(text,col))
  exec "normal ".v:count1."l"
endfunction


" use Meta key(Windows:Alt) to move cursor in insert mode.
" Note: if system install "Lingoes Translator",
"   you will need change/disabled hot key.
if g:OS#mac
  noremap! <D-j> <Down>
  noremap! <D-k> <Up>
  "noremap! <D-h> <left>
  "noremap! <D-l> <Right>
  noremap! <A-j> <Down>
  noremap! <A-k> <Up>
  noremap! <A-h> <left>
  noremap! <A-l> <Right>
else
  noremap! <M-j> <Down>
  noremap! <M-k> <Up>
  noremap! <M-h> <left>
  noremap! <M-l> <Right>
endif

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

map <C-kPlus> <C-w>+
map <C-kMinus> <C-w>-
map <C-S-kPlus> <C-w>_
map <C-S-kMinus> <C-w>_


" Windows: Explorer.exe
" Linux:   nautilus $PWD
"          nautilus .
" Mac:     open .
" @see http://www.zhuoqun.net/html/y2010/1516.html
function! FileExplorer(path)
  if a:path == ""
    if has("win32")
      let p = expand("%:p")
    elseif has("mac")
      let p = expand("%:p:h")
    else
      echomsg "Not support."
      return
    endif
  else
    let p = a:path
  endif
  if g:OS#win && exists("+shellslash") && &shellslash
    let p = substitute(p, "/", "\\", "g")
  endif

  if executable("chcp")
    let code_page = 'cp' . matchstr(system("chcp"), "\\d\\+")
  else
    " If chcp doesn't work, set its value manually here.
    let code_page = 'cp936'
  endif
  if g:OS#win && !has('win32unix') && (&enc!=code_page)
    let p = iconv(p, &enc, code_page)
  endif

  if g:OS#win
    exec ":!start explorer /select, " . p
    " Open Explorer Tree.
    "exec ":!start explorer /e,/select, " . p
  elseif has("mac")
    exec ':!open "' . p . '"'
  endif
endfunction

" Open Windows Explorer and Fouse current file.
" or open Mac Finder.
"                                      %:p:h     " Just Folder Name.
command -nargs=0 FileExplorer :silent call FileExplorer("")
if g:OS#mac
  command -nargs=0 Finder :silent call FileExplorer("")
endif


let g:use_bash="zsh"

" 打开终端窗口。
" TODO: 默认打开指定的目录。
" TODO: MacVim 的等待提示。
" for MacOS
" /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
function! OpenBash(...)
  let bash=':!open /bin/bash'

  if g:OS#win
    let bash=':!start cmd'
  elseif "zsh" == g:use_bash
    let bash=':!open /bin/zsh'
  endif

  exec bash
endfunction
command -nargs=? Cmdhere silent call OpenBash(<f-args>)
command -nargs=? Bashere silent call OpenBash(<f-args>)
command -nargs=? Bashhere silent call OpenBash(<f-args>)
command SHELL silent cd %:p:h|silent exe "!start cmd"|silent cd -




" tab navigation & operation like tabs browser
" @see http://vimcdoc.sourceforge.net/doc/tabpage.html
" Note: cannot map <C-number> for gvim on window 7.
imap <C-t> <Esc>:tabnew<cr>
nmap <C-t> :tabnew<cr>
"imap <C-w> <Esc>:tabclose<cr> " window shortcut key.
"nmap <C-w> :tableclose<cr>
"imap <C-S-w> <Esc>:tabonly<cr>
"nmap <C-S-w> :tabonly<cr>
imap <C-tab> :tabnext<cr>
nmap <C-tab> :tabnext<cr>
imap <C-S-tab> :tabprevious<cr>
nmap <C-S-tab> :tabprevious<cr>
if g:OS#mac
  imap <D-1> <Esc>:tabfirst<cr>
  nmap <D-1> :tabfirst<cr>
  imap <D-2> <Esc>2gt
  nmap <D-2> 2gt
  imap <D-3> <Esc>3gt
  nmap <D-3> 3gt
  imap <D-4> <Esc>4gt
  nmap <D-4> 4gt
  imap <D-5> <Esc>5gt
  nmap <D-5> 5gt
  imap <D-6> <Esc>6gt
  nmap <D-6> 6gt
  imap <D-7> <Esc>7gt
  nmap <D-7> 7gt
  imap <D-8> <Esc>8gt
  nmap <D-8> 8gt
  imap <D-9> <Esc>9gt
  nmap <D-9> 9gt
  imap <D-0> <Esc>:tablast<cr>
  nmap <D-0> :tablast<cr>
else
  imap <M-1> <Esc>:tabfirst<cr>
  nmap <M-1> :tabfirst<cr>
  imap <M-2> <Esc>2gt
  nmap <M-2> 2gt
  imap <M-3> <Esc>3gt
  nmap <M-3> 3gt
  imap <M-4> <Esc>4gt
  nmap <M-4> 4gt
  imap <M-5> <Esc>5gt
  nmap <M-5> 5gt
  imap <M-6> <Esc>6gt
  nmap <M-6> 6gt
  imap <M-7> <Esc>7gt
  nmap <M-7> 7gt
  imap <M-8> <Esc>8gt
  nmap <M-8> 8gt
  imap <M-9> <Esc>9gt
  nmap <M-9> 9gt
  imap <M-0> <Esc>:tablast<cr>
  nmap <M-0> :tablast<cr>
endif


" Toggle Menu and Toolbar
" @see http://liyanrui.is-programmer.com/articles/1791/gvim-menu-and-toolbar-toggle.html
if g:OS#gui
  set guioptions-=m
  set guioptions-=T
  map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
      \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
      \endif<CR>
endif


" =========== Plugins ==============

" MRU.vim
" try for Terminal.
try
  let MRU_File=~/.vim/.vim_mru_files
catch /.*/
endtry
let MRU_Max_Entries = 1000


" Vimwiki.vim
let g:vimwiki_use_mouse = 1
let g:vimwiki_camel_case = 0
let g:vimwiki_CJK_length = 1
let g:vimwiki_use_calendar = 0
let g:vimwiki_timestamp_format='%Y年%m月%d日 %H:%M:%S'
let g:vimwiki_user_htmls = "search.html,404.html"

let g:snips_trigger_key = '<C-\>'

" autocomplpop.vim, acp.vim
"let g:loaded_acp = 0
" Auto Complete Pop Menu
" autocomplpop.vim
" @see http://www.vim.org/scripts/script.php?script_id=1879
" @see http://hi.baidu.com/timeless/blog/item/cb4478f09a1563ca7931aa5d.html
" Note: functions and key maps invalid.
"
"let g:acp_behaviorSnipmateLength = 1        " AutoComplete snippets for snipMate.
let g:acp_behaviorHtmlOmniLength = -1
let g:AutoComplPop_MappingDriven = 1        " Don't popup when move cursor.
let g:AutoComplPop_IgnoreCaseOption = 1
" @see http://d.hatena.ne.jp/cooldaemon/20071114/1195029893
autocmd FileType * set complete=.,w,b,u,t,i
let g:acp_behaviorSnipmateLength = 1
if g:OS#win
  "autocmd FileType perl let g:acp_completeOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
  "autocmd FileType ruby let g:acp_completeOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
  autocmd FileType javascript set complete=.,w,b,u,t,i,k$VIM/vimfiles/dict/javascript.dict
else
  autocmd FileType javascript set complete=.,w,b,u,t,i,k~/.vim/dict/javascript.dict
  autocmd FileType plantuml set complete=.,w,b,u,t,i,k~/.vim/dict/plantuml.dict
endif


" NERDTree
" @see http://www.vim.org/scripts/script.php?script_id=1658
" @see http://www.gracecode.com/archives/1339/
"imap <F3> <Esc>:NERDTreeToggle<cr>
"nmap <F3> :NERDTreeToggle<cr>
" For NERD_tree Project
" @see http://www.vim.org/scripts/script.php?script_id=2801
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=30
imap <F3> <Esc>:ToggleNERDTree<cr>
nmap <F3> :ToggleNERDTree<cr>


" Powerline.vim
let g:Powerline_symbols = 'fancy' " require fontpatcher

set diffopt=filler,vertical,context:3

" Syntastic
function! SyntasticJavaScriptChecker()
  let l:eslint = 'eslint'
  " let l:node_modules = finddir('node_modules', expand('%:p:h') . ';')

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]

    let l:lints = ['eslint', 'jshint', 'jslint']

    if strlen(l:npm_bin)
      for lint in l:lints
        let l:lint_path = l:npm_bin . '/' . lint
        if executable(l:lint_path)
          let l:eslint = l:lint_path
          break
        endif
      endfor
    endif
  endif

  let b:syntastic_javascript_eslint_exec = l:eslint
  let b:syntastic_typescript_eslint_exec = l:eslint
endfunction

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['eslint']
autocmd FileType javascript,typescript call SyntasticJavaScriptChecker()
" autocmd FileType less call SyntasticJavaScriptChecker()

let g:syntastic_json_checkers = ["jsonlint"] " npm install jsonlint -g
let g:syntastic_css_checkers = ["stylelint", "csslint"] " npm install stylelint csslint -g
let g:syntastic_less_checkers = ["stylelint", "csslint"]
let g:syntastic_yaml_checkers = ["yaml-lint"] " https://github.com/Pryz/yaml-lint
" let g:syntastic_vim_checkers = ['vint']
let g:syntastic_ignore_files = ['\/node_modules\/.*']
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='x'
let g:syntastic_warning_symbol='!'
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'

highlight SyntasticErrorSign guifg=red guibg=#555555
highlight SyntasticWarningSign guifg=yellow guibg=#555555
highlight SignColumn guibg=#555555


" ctags, TagList, Tagbar.
" @see http://easwy.com/blog/archives/advanced-vim-skills-taglist-plugin/
if g:OS#win
  let g:ctags_path=$VIM.'\vimfiles\plugin\ctags.exe'
  let Tlist_Ctags_Cmd=$VIM.'\vimfiles\plugin\ctags.exe'
  let g:tagbar_ctags_bin=$VIM.'\vimfiles\plugin\ctags.exe'
elseif g:OS#mac
  " brew install ctags
  let g:ctags_path='/usr/local/bin/ctags'
  let Tlist_Ctags_Cmd= '/usr/local/bin/ctags'
	let g:tagbar_ctags_bin='/usr/local/bin/ctags'
else
endif

let g:tagbar_foldlevel = 2
let g:tagbar_type_markdown = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:header',
		\ 'i:header',
		\ 'k:header'
	\ ],
  \ 'sort': 0
\ }
let g:tagbar_type_vimwiki = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:header',
		\ 'i:header',
		\ 'k:header'
	\ ],
  \ 'sort': 0
\ }
let g:tagbar_type_javascript = {
  \ 'ctagstype': 'javascript',
  \ 'kinds': [
    \ 'a:arrays',
    \ 'p:properties',
    \ 't:tags',
    \ 'o:objects',
    \ 'g:generator functions',
    \ 'f:functions',
    \ 'c:constructors/classes',
    \ 'm:methods',
    \ 'v:variables',
    \ 'i:imports',
    \ 'e:exports',
    \ 's:styled components'
  \ ],
  \ 'sort': 0
\ }
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'i:imports',
    \ 'e:enums',
  \ ]
\ }

let g:ctags_statusline=1
let g:ctags_args=1
let g:Tlist_Use_Right_Window=1
let g:Tlist_Show_One_File = 1
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_WinWidth=40
nnoremap <F12> :TlistToggle<CR>

let tlist_vimwiki_settings = 'wiki;h:Headers'
let tlist_confluencewiki_settings = 'confluencewiki;h:Headers'
let tlist_markdown_settings = 'markdown;h:Headers'
let tlist_textile_settings = 'textile;h:Headers'
let tlist_html_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_xhtml_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_velocity_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_css_settings = 'css;c:Classes;o:Objects(ID);t:Tags(Elements)'
let tlist_javascript_settings = 'javascript;d:define;c:Classes;f:Functions;o:Objects'
let tlist_json_settings = 'json;o:Objects'


" --------------------------- Macros & Functions ------------------------ {{{
" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
function! RemoveTrailingWhitespace()
  if &ft != "diff"
    let b:curcol = col(".")
    let b:curline = line(".")
    silent! %s/\s\+$//
    silent! %s/\(\s*\n\)\+\%$//
    call cursor(b:curline, b:curcol)
  endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()


highlight TabSpace ctermbg=green guibg=green
syntax match TabSpace /\t/
highlight WhitespaceEOL ctermbg=yellow guibg=yellow
syntax match WhitespaceEOL /\s\+$/


" ================== for some spec ===================

" velocity default encoding setting.
au BufRead,BufNewFile *.vm setlocal ft=html fileencoding=gbk syntax=velocity
au BufRead,BufNewFile *.puml setlocal ft=plantuml

" 支付宝小程序
au BufRead,BufNewFile *.acss setlocal ft=less
au BufRead,BufNewFile *.axml setlocal ft=xml

autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()

" 光标自动定位到最后编辑的位置。
autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 |
                    \   if line("'\"") <= line("$") |
                    \     exe("norm '\"") |
                    \   else |
                    \     exe "norm $" |
                    \   endif |
                    \ endif

function! Agreement()
  silent! %s/[\s  ]\+$//
  silent! %s/\([\s  ]*\n\)\+\%$//
  silent! %s/^\(第.\{1,3\}章\([ ]*.\+\)\?\)$/<h2>\1<\/h2>/g
  " silent! %s/^\(第.\{1,3\}条\([ ]*.\+\)\?\)$/<h3>\1<\/h3>/g
  silent! %s/^\([^< ].*\)$/<p>\1<\/p>/g
endfunction
command! -nargs=? Agreement :call Agreement()

function! FindFileOrDir(filename)
  if filereadable(a:filename)
    return a:filename
  endif

  let suffixes = split(&suffixesadd, ',')
  let suffixes = filter(suffixes, 'count(suffixes, v:val) == 1')

  for s in suffixes
    let candidate = a:filename . s
    if filereadable(candidate)
      return candidate
    endif
  endfor
  return ''
endfunction

function! ReplaceProxyPath(fname)
  " TODO:
  " 如果 controller 不存在，还需要替换为 controllers 试试。
  " app.controller
  let filePath = substitute(a:fname, '\(\(this\.\)\?app\.\)\?\(controllers\?\)\.\([a-zA-Z0-9\.]\+\)\.\w\+$', 'controllers/\4', '')

  " TODO:
  " 如果文件不存在，还需要将驼峰替换成下划线，
  " 如果有多个驼峰，甚至需要各种组合形式的尝试。Egg 真坑。
  " ctx.service, ctx.proxy
  let filePath = substitute(filePath, '\(\(this\.\)\?ctx\.\)\?\(service\|proxy\)\.\([a-zA-Z0-9_\$\.]\+\)\.\w\+$', '\3/\4', '')
  let filePath = substitute(filePath, '\.', '/', 'g')
  return filePath
endfunction

" Egg/Chair 的 proxy 跳转
function! InitEggProxyGF()
  let proxyClass = finddir('app/proxy-class', expand('%:p:h') . ';')
  execute 'setlocal path+=' . proxyClass . '/*/*'

  " TODO: 对于 Enum 需要特殊处理：
  " - com.alipay.${appName}.common.service.facade.enums.${EnumName}
  " + app/proxy-enums/alipay-${appName}-common/${EnumName}.js
  " let proxyEnums = finddir('app/proxy-enums', expand('%:p:h') . ';')
  " execute 'setlocal path+=' . proxyEnums . '/*'

  " 对于 proxy 需要特殊处理：
  " - this.ctx.proxy.${facadeName}.${methodName}
  " + app/proxy/${facadeName}.js
  " let proxy = finddir('app/proxy', expand('%:p:h') . ';')
  " execute 'setlocal path+=' . proxy
  " " 给 includeexpr 用的 substitute 中的正则模式，反斜杠需要多转义一次。
  " set includeexpr=substitute(v:fname,'\\(this\\.\\)\\?\\(ctx\\.\\)\\?proxy\\.\\(\\w\\+\\)\\.\\w\\+$','\\3','')

  " 对于 app/controller, app.service, app.proxy 特殊处理：
  " - this.ctx.service.${filePathName}.${methodName}
  " + app/service/${facadeName}.js
  let appPath = finddir('app', expand('%:p:h') . ';')
  execute 'setlocal path+=' . appPath
  " 给 includeexpr 用的 substitute 中的正则模式，反斜杠需要多转义一次。
  " set includeexpr=substitute(v:fname,'\\(this\\.\\)\\?\\(ctx\\.\\)\\?\\(controller\\\|service\\\|proxy\\)\\.\\(\\[\\w\\.\\]\\+\\)\\.\\w\\+$','\\3/\\4','')
  set includeexpr=ReplaceProxyPath(v:fname)
endfunction
auto FileType javascript,typescript call InitEggProxyGF()

" vim:fdm=marker
