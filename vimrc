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

set nocompatible
if g:OS#win
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

if g:OS#win
    " MyDiff {{{
    set diffexpr=MyDiff()
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let eq = ''
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          let cmd = '""' . $VIMRUNTIME . '\diff"'
          let eq = '"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif


function! Jump2DiffText(dir)
    if a:dir=="prev"
        exec "normal [c"
    elseif a:dir=="next"
        exec "normal ]c"
    endif
    if synIDattr(diff_hlID(".", col(".")), "name")=="DiffChange"
        let line=line(".")
        let cols=col("$")-1
        let idx=1
        while idx<=cols
            if synIDattr(diff_hlID(line, idx), "name")=="DiffText"
                call setpos(".", [0,line,idx])
                echo line.",".idx.",".cols
                break
            else
                let idx = idx+1
            endif
        endwhile
    endif
endfunction

" @see http://vim.wikia.com/wiki/Selecting_changes_in_diff_mode
if &diff
    nmap <buffer> <F7> :call Jump2DiffText("prev")<cr>
    nmap <buffer> <F8> :call Jump2DiffText("next")<cr>
else
    map <buffer> <F7> :cp<cr>
    map <buffer> <F8> :cn<cr>
endif

"cnoremap js javascript
"cnoremap vm velocity
"cabbrev js javascript
"cabbrev vm velocity
"cabbrev utf set fenc=utf8
"cabbrev utf8 set fenc=utf8
"cabbrev gbk set fenc=gbk

" }}}

" -------------------------------- Settings ----------------------------- {{{
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


" FencView.vim
" 自动识别文件编码
" @see http://www.vim.org/scripts/script.php?script_id=1708
let g:fencview_autodetect=1
let g:fencview_auto_patterns='*.txt,*.js,*.css,*.c,*.cpp,*.h,*.java,*.cs,*.htm{l\=}'
let g:fencview_checklines=20
let $FENCVIEW_TELLENC='tellenc'


" 文件格式，默认 ffs=dos,unix
set fileformat=unix
set fileformats=unix,dos,mac

" set default(normal) window size.
set lines=999
set columns=200

let s:lines = str2nr(&lines)
let s:columns = str2nr(&columns)
function! MaximumWindow()
    if g:OS#win
        set lines=999
        set columns=200
    else
        set lines=999
        set columns=200
    endif
endfunction
function! NoMaximumWindow()
    if g:OS#win
        let &lines=s:lines
        let &columns=s:columns
    else
        let &lines=s:lines
    endif
endfunction
command -nargs=0 Max :call MaximumWindow()
command -nargs=0 Min :call NoMaximumWindow()
command -nargs=0 NoMax :call NoMaximumWindow()
command -nargs=0 Nomax :call NoMaximumWindow()


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
nnoremap <F11> :call FullScreenToggle()<cr>
inoremap <F11> <C-o><F11>

if g:OS#win
    " max open window
    if g:OS#gui
        au GUIEnter * simalt ~x
    endif

    au! bufwritepost hosts silent !start cmd /C ipconfig /flushdns
    command -nargs=0 Vimrc silent tabnew $VIM/vimfiles/vimrc
    command -nargs=0 Sysrc silent tabnew $VIM/sysrc.vim
    " @see http://practice.chatserve.com/hosts.html
    command -nargs=0 Hosts silent tabnew c:\windows\system32\drivers\etc\hosts
else
    if g:OS#gui
        " <F11> is global hotkey for display desktop.
        nnoremap <C-F11> :call FullScreenToggle()<cr>
        inoremap <C-F11> <C-o>:call FullScreenToggle()<cr>
        if g:OS#mac
            set transparency=5
        elseif g:OS#unix
            function! Maximize_Window()
                " for Gnome.
                " $ sudo apt-get install wmctrl
                " http://fluxbox.sourceforge.net/docbook/zh_cn/html/ch03s05.html
                silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
            endfunction
            autocmd GUIEnter * call Maximize_Window()
        endif
    endif

    if g:OS#mac
        " for Mac OS X 10.5 和 10.6
        "au! bufwritepost hosts silent !sudo dscacheutil -flushcache
        "
        " for Lion(10.7) and Mountain Lion(10.8)
        "au! bufwritepost hosts silent !sudo killall -HUP mDNSResponder
    endif

    command -nargs=0 Vimrc :silent! tabnew ~/.vim/vimrc
    command -nargs=0 Sysrc :silent! tabnew ~/.sysrc
    " readonly.
    command -nargs=0 Hosts :!sudo gvim /etc/hosts
    command -nargs=0 Httpd :!sudo gvim /etc/apache2/httpd.conf
endif

command -nargs=0 Blog :silent! tabnew ~/Sites/blog.hotoo.me/content/index.md


" theme, skin, color
if g:OS#gui
    "colo desert
    "colo hotoo
    "colo ir_desert
    "colo manuscript
    "colo colorzone
    "colo fu
    colo hotoo_manuscript
    "colo default
    "colo emacs
    "colo stackoverflow
    "colo newspaper
    "colo wombat
endif

hi TabLine     cterm=none ctermfg=lightgrey ctermbg=lightblue guifg=gray guibg=black
hi TabLineSel  cterm=none ctermfg=lightgrey ctermbg=LightMagenta guifg=white guibg=black
hi TabLineFill cterm=none ctermfg=lightblue ctermbg=lightblue guifg=black guibg=black


" @see :help mbyte-IME
if has('multi_byte_ime')
    highlight Cursor guibg=#F0E68C guifg=#708090
    highlight CursorIM guibg=Purple guifg=NONE
endif


" FIXME: bugs by FIT.
"if g:OS#mac && g:OS#gui
    "set imdisable
    "set imactivatekey=D-space
    "set imsearch=0

    "set imcmdline=0

    "autocmd! InsertLeave * set iminsert=0|set imdisable

    "autocmd! InsertLeave * set imdisable|set iminsert=0
    "autocmd! InsertEnter * set noimdisable|set iminsert=2

    "inoremap <ESC> <ESC>:set iminsert=0<CR>
"endif


" fonts
" @see http://support.microsoft.com/kb/306527/zh-cn
" @see http://www.gracecode.com/archives/1545/
" @see http://blog.xianyun.org/2009/09/14/vim-fonts.html
if g:OS#win
    set guifont=Courier_New:h12:cANSI
    "set guifont=Microsoft_YaHei_Mono:h11:cANSI

    "set guifont=monaco:h11:cANSI
    "set guifont=Consola:h11:cANSI
    "set guifont=DajaVu:h11:cANSI
    "set guifont=Lucida\ Console:h11:cANSI
    "set guifontwide=YouYuan:h11:cGB2312
elseif g:OS#mac
    set guifont=Courier_New:h16
elseif g:OS#unix
endif

" auto mkview and loadview.
if !&diff
    au BufWinLeave *.js,*.css silent mkview
    au BufWinEnter *.js,*.css silent loadview
endif


" swrap file, auto backup.
set nobackup
if g:OS#win
    set directory=$VIM\tmp
    set backupdir=$VIM\bak
else
    set directory=~/.tmp
    set backupdir=~/.bak
endif

if g:OS#win
    let MRU_File = $VIM.'\_vim_mru_files'
else
    " try for Terminal.
    try
        let MRU_File = ~/.vim_mru_files
    catch /.*/
    endtry
endif
let MRU_Max_Entries = 1000


if has("persistent_undo")
    set undofile
    set undolevels=1000

    if g:OS#win
        set undodir=$VIM\undodir
        au BufWritePre undodir/* setlocal noundofile
    else
        set undodir=~/.undodir
        au BufWritePre ~/.undodir/* setlocal noundofile
    endif
endif

" 加速光标闪烁。
" @see http://c9s.blogspot.com/2007/12/gvim.html
"set guicursor+=n-v-c:block-cursor-blinkwait300-blinkon90-blinkoff90
"set guicursor+=i:block-cursor-blinkwait200-blinkon110-blinkoff110
"set guicursor+=v:ver90-cursor-blinkwait200-blinkon150-blinkoff150

" Tabs
set smarttab
set expandtab       " replace tab to whitespace.
set tabstop=2       " show tab indent word space.
set softtabstop=2
set shiftwidth=2    " tab length

"autocmd FileType html,xhtml,velocity setl softtabstop=2 | setl tabstop=2 | setl shiftwidth=2
"autocmd FileType markdown,vimwiki setl softtabstop=4 | setl tabstop=4 | setl shiftwidth=4
autocmd FileType vimwiki setl nowrap | setl textwidth=0


" 自动检查文件内容中的编码设置，并在保存文件时使用该编码。
if !exists("g:auto_dect_enc")
    let g:auto_dect_enc = 1
endif
function! Auto_dect_enc()
    let re = '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'
    let re5 = '<meta charset="UTF-8" />'
endfunction
function! Auto_save_enc()
endfunction
"if g:autodectHTML_Encoding == 1
    "autocmd BufWritePre *.html,*.htm,*.vm call auto_dect_enc()
"endif

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

set ignorecase
set smartcase
set number

" fixed.
set scrolloff=3

if g:OS#gui
    set autochdir
    set colorcolumn=81
endif

" for Vim72-
"syn match out80 /\%80v./ containedin=ALL
"hi out80 guifg=#333333 guibg=#ffffff

" 设置宽度不明的文字(如 “”①②→ )为双宽度文本。
" @see http://blog.sina.com.cn/s/blog_46dac66f010006db.html
set ambiwidth=double



set history=500

" Show tab number in your tab line
" @see http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
" :h tabline
if g:OS#gui
    " TODO: for MacVim.
    set guitablabel=%N.%t
endif

" auto wrap text.
" NOTE: this setting will change text source.
set textwidth=80
autocmd filetype html setlocal textwidth=120
set fo+=m         "formatoptions

" share system clipboard.
"set clipboard+=unnamed


" velocity default encoding setting.
"au BufNewFile,BufRead *.vm setl fenc=gbk
au BufRead,BufNewFile *.vm setl ft=html fileencoding=gbk syntax=velocity

au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript


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
" statusline

" }}}


" ------------------------------- Mappings ------------------------------ {{{
" Normal Mode, Visual Mode, and Select Mode,
" use <Tab> and <Shift-Tab> to indent
" @see http://c9s.blogspot.com/2007/10/vim-tips.html
"nmap <tab> v>                  " :h ctrl-i :h <tab>
"nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" TODO:
" join more lines without space in chinese.
" some like 'gJ', but ignore invalid space.
function! JoinPlus()
    let cur = getpos(".")
    let startLine = line(".")
    let offset = v:count1>2 ? v:count1 - 1 : 1
    let endLine = startLine + offset
    let reEmpty = "^\s*$"
    let reStart = "[^ \t]"
    let reEnd = "[a-zA-Z0-9][ \t]*$"
    let reLetter = ""
    let txt = getline(startLine)
    if(0!=match(txt, reEmpty))
        let txt = strpart(txt, 0, match(txt, reEnd))
    endif
    let len = strlen(txt)
    let lineIdx = startLine+1
    while lineIdx<=endLine
        let txt = txt . getline(lineIdx)
        let lineIdx = lineIdx+1
    endwhile
    call setline(".", txt)
    exec 'normal j"_'.offset.'ddk'
endfunction
"nmap J :<C-U>call JoinPlus()<cr>

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

" Change Assignment(=) Expression.
" @see http://c9s.blogspot.com/2007/09/vim-tip.html
nmap c=r $F=lcf;
nmap c=l $F=c^


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
"                                      %:p:h     " Just Fold Name.
nmap <F6> :call FileExplorer("")<cr>
imap <F6> <C-o><F6>
command -nargs=0 Explorer :call FileExplorer("")

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
command -nargs=? Cmdhere call OpenBash(<f-args>)
command -nargs=? Bashere call OpenBash(<f-args>)
command -nargs=? Bashhere call OpenBash(<f-args>)
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

" @see http://blog.chinaunix.net/u/8681/showart_1226043.html
" @usage 50g| jump to 50% of the lines columns.
nnoremap <expr> g<Bar> '<Esc>' . float2nr( round( (col('$')-1) * min([100, v:count]) / 100.0)) . '<Bar>'

function QFixState()
    return len(getqflist())
endfunction

" QUICKFIX WINDOW
" @see http://c9s.blogspot.com/2007/10/vim-quickfix-windows.html
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction
"nnoremap <leader>q :QFix<CR>

" close quickfix window.
"nmap <F4> :cclose<CR>
nmap <F4> :cw<CR>
" compile c/cpp code.
autocmd FileType cpp,c nmap <buffer> <F9> :setlocal makeprg=make<cr>:make<cr> :copen<cr> <C-W>10_
"autocmd FileType cpp,c nmap <buffer> <F10> :exe "!gcc -o ".expand("%:r").".exe ".expand("%")<cr>
"autocmd FileType cpp,c nmape <buffer> <F10> :!gcc -o %:r.exe %<cr>
" @see http://easwy.com/blog/archives/advanced-vim-skills-quickfix-mode/
"      http://blog.zdnet.com.cn/html/30/422230-2881199.html
autocmd FileType cpp nmap <buffer> <F10> :w<cr>:setlocal makeprg=g++\ -Wall\ -o\ %:r.exe\ %<cr>:make<cr><cr>:cw<cr>
autocmd FileType c nmap <buffer> <F10> :w<cr>:setlocal makeprg=gcc\ -Wall\ -o\ %:r.exe\ %<cr>:make<cr><cr>:cw<cr>
" run current code.
autocmd FileType cpp,c nmap <buffer> <F5> :!%:r.exe
autocmd FileType dosbatch nmap <buffer> <F5> :!%<cr><cr>

autocmd FileType mxml,actionscript nmap <buffer> <F10> :w<cr>:setlocal makeprg=mxmlc\ -output\ %:r.swf\ %<cr>:make<cr><cr>:cw<cr>

autocmd FileType css syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

"autocmd FileType velocity let b:match_words = '#if\>:#elseif\>:#else\>:#end\>'
		"\ . ',#foreach\>:#end\>'
        "\ . ',#macro\>:#end\>'

au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))


" Processing
function! RunP5()
    let processing_path="C:\\Program Files\\processing-1.0.9"
    let java_home=processing_path.'\\java'
    let class_path=java_home."\\lib\\rt.jar;".java_home."\\lib\\tools.jar;".processing_path."\\lib\\antlr.jar;".processing_path."\\lib\\core.jar;".processing_path."lib\\ecj.jar;".processing_path."\\lib\\jna.jar;".processing_path."\\lib\\pde.jar"
    silent execute '!start '.java_home.'\\bin\\java -classpath "'.class_path.'" processing.app.Commander --sketch="'.expand("%:h").'" --output="output" --run'
endfunction
autocmd FileType processing nnoremap <buffer> <silent> <F9> :up<CR>:call RunP5()<CR>
autocmd FileType processing so $VIM/vimfiles/autoload/processing_omni.vim
autocmd FileType processing set ofu=OmniProcessing

" auto complete drop list.
set completeopt=longest,menu
imap <C-L> <C-x><C-o>


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

echo &guioptions

" Dynamic bind <HOME> key
" if caret/cursor not at the frist non-white-space character
"   move caret/cursor to there
" else
"   move to beginning
function HomeBind(offset)
    let cursor=getpos('.')
    let s0=getline(line('.'))
    let s1=substitute(s0, "^\\s\\+", "", "")
    let x=len(s0)-len(s1)+1
    if col('.') == x-a:offset
        let x=1
    endif
    call setpos('.', [cursor[0], cursor[1], x, cursor[3]])
endfunction
imap <silent> <Home> <Esc>:call HomeBind(1)<cr>i
nmap <silent> <Home> :call HomeBind(0)<cr>
vmap <silent> <Home> <Esc>:call HomeBind(1)<cr>


" Dynamic bind <END> key
" if caret/cursor not at the end
"   move caret/cursor to there
" else
"   move to last non-white-space character.
function EndBind(offset)
    let cursor=getpos('.')
    let s0=getline(line('.'))
    let s1=substitute(s0, "\\s*$", "", "")
    let x=len(s0)+a:offset
    if col('.') == x
        let x=len(s1)+a:offset
    endif
    call setpos('.', [cursor[0], cursor[1], x, cursor[3]])
endfunction
imap <silent> <End> <Esc>:call EndBind(0)<cr>a
nmap <silent> <End> :call EndBind(0)<cr>
vmap <silent> <End> :call EndBind(0)<cr>
":nmap <End> /\S\s*$<CR>:nohl<CR>


" place in vimrc
"nmap <silent><Home> :call SmartHome("n")<CR>
"nmap <silent><End> :call SmartEnd("n")<CR>
"imap <silent><Home> <C-r>=SmartHome("i")<CR>
"imap <silent><End> <C-r>=SmartEnd("i")<CR>
"vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
"vmap <silent><End> <Esc>:call SmartEnd("v")<CR>

function SmartHome(mode)
  let curcol = col(".")
  "gravitate towards beginning for wrapped lines
  if curcol > indent(".") + 2
    call cursor(0, curcol - 1)
  endif
  if curcol == 1 || curcol > indent(".") + 1
    if &wrap
      normal g^
    else
      normal ^
    endif
  else
    if &wrap
      normal g0
    else
      normal 0
    endif
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction

function SmartEnd(mode)
  let curcol = col(".")
  let lastcol = a:mode == "i" ? col("$") : col("$") - 1
  "gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call cursor(0, curcol + 1)
  endif
  if curcol < lastcol
    if &wrap
      normal g$
    else
      normal $
    endif
  else
    normal g_
  endif
  "correct edit mode cursor position, put after current character
  if a:mode == "i"
    call cursor(0, col(".") + 1)
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction

" }}}

" ------------------------------- Commands ------------------------------ {{{
" @see http://www.vim.org/scripts/script.php?script_id=687
" @see http://code.google.com/p/easy-vim/downloads/detail?name=vimtweak.dll
command -nargs=1 Alpha :call libcallnr("vimtweak.dll", "SetAlpha", <args>)
command -nargs=0 MaxWin :call libcallnr("vimtweak.dll", "EnableMaximize", 1)
command -nargs=0 MinWin :call libcallnr("vimtweak.dll", "EnableMaximize", 0)
command -nargs=0 TopWin :call libcallnr("vimtweak.dll", "EnableTopMost", 1)
command -nargs=0 UnTopWin :call libcallnr("vimtweak.dll", "EnableTopMost", 0)


if g:OS#win
    "autocmd FileType xhtml,html command! -nargs=0 IE :call Save2Temp()<cr><cr>:!start RunDll32.exe shell32.dll,ShellExec_RunDLL %:p<cr>
    autocmd FileType xhtml,html command! -nargs=0 FF :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
    autocmd FileType xhtml,html command! -nargs=0 IE6 :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
    autocmd FileType xhtml,html command! -nargs=0 IE7 :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
    autocmd FileType xhtml,html command! -nargs=0 IE8 :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
    autocmd FileType xhtml,html command! -nargs=0 SA :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
    autocmd FileType xhtml,html command! -nargs=0 OP :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
    autocmd FileType xhtml,html command! -nargs=0 CH :call Save2Temp()<cr><cr>:!start "E:\Mozilla Firefox\firefox.exe" -P debug %<cr>
endif


function! BlogDrafts()
  setlocal makeprg=make
  make drafts
  copen
endfunction

autocmd FileType markdown command! -nargs=0 Drafts call BlogDrafts()

" }}}

" -------------------------------- Plugins ------------------------------ {{{
" vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_camel_case = 0
let g:vimwiki_CJK_length = 1
let g:vimwiki_use_calendar = 0
"let g:vimwiki_list_ignore_newline = 0
let g:vimwiki_timestamp_format='%Y年%m月%d日 %H:%M:%S'
let g:vimwiki_user_htmls = "search.html,404.html"



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
autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
if g:OS#win
    "autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
    "autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
    autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k$VIM/vimfiles/dict/javascript.dict'
else
    autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k$VIM/vimfiles/dict/javascript.dict'
endif
"autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'


" Just for AutoComplPop css url.
" but more bugs in other place.
"if exists('+shellslash')
    "set shellslash                          " FileNameComplete by slash(/)
"endif

"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType velocity set omnifunc=velocitycomplete#CompleteTags

autocmd FileType javascript setl dictionary=$VIM/vimfiles/dict/javascript.dict,$VIM/vimfiles/dict/jQuery.dict,$VIM/vimfiles/dict/jQuery.dict
"autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS


" Doxygen
" @see http://www.vim.org/scripts/script.php?script_id=5
" @see http://www.vim.org/scripts/script.php?script_id=987
" @see http://www.jeffhung.net/blog/articles/jeffhung/447/
" @see http://blog.csdn.net/AD_LI/archive/2009/08/24/4474878.aspx
let g:DoxygenToolkit_authorName="闲耘™ (@hotoo, mail@xianyun.org)"
let s:licenseTag = "Copyleft(C)\<enter>"
let s:licenseTag = s:licenseTag . "For 闲耘™\<enter>"
let s:licenseTag = s:licenseTag . "Some right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1


" jsLint
" @see http://www.gracecode.com/category/496/
" @see http://www.vim.org/scripts/script.php?script_id=2578
" @see http://www.javascriptlint.com/index.htm
if g:OS#win
    let g:jslint_command = $VIM.'\vimfiles\jslint\jsl.exe'
else
    let g:jslint_command = '~/.vim/jslint/jsl'
endif
"map <C-s><C-j> :call JsonLint()<cr>


" css color
" @see http://www.gracecode.com/archives/977/
" @see http://www.vim.org/scripts/script.php?script_id=2150


" Calendar
" @see http://www.gracecode.com/archives/674/
let g:calendar_smnd = 1
let g:calendar_monday = 1                   " week start with monday.
let g:calendar_weeknm = 1                   " don't work with g:calendar_diary
let g:calendar_mark = 'left-fit'            " let plus(+) near the date, like +8.
"let g:calendar_mruler = '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月'
"let g:calendar_wruler = '日 一 二 三 四 五 六'
"let g:calendar_navi_label = '上月,本月,下月'

" NERDTree
" @see http://www.vim.org/scripts/script.php?script_id=1658
" @see http://www.gracecode.com/archives/1339/
"imap <F3> <Esc>:NERDTreeToggle<cr>
"nmap <F3> :NERDTreeToggle<cr>
" For NERD_tree Project
" @see http://www.vim.org/scripts/script.php?script_id=2801
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=20
imap <F3> <Esc>:ToggleNERDTree<cr>
nmap <F3> :ToggleNERDTree<cr>


" for javascript.vim
" enable javascript fold
"let javascript_fold=1
" enable support dom, html and css for javascript
"let javascript_enable_domhtmlcss=1


" ctags, TagList, Tagbar.
" @see http://easwy.com/blog/archives/advanced-vim-skills-taglist-plugin/
if g:OS#win
    let g:ctags_path=$VIM.'\vimfiles\plugin\ctags.exe'
    let Tlist_Ctags_Cmd=$VIM.'\vimfiles\plugin\ctags.exe'
	let g:tagbar_ctags_bin=$VIM.'\vimfiles\plugin\ctags.exe'
elseif g:OS#mac
    let g:ctags_path='/usr/local/bin/ctags'
    let Tlist_Ctags_Cmd= '/usr/local/bin/ctags'
	let g:tagbar_ctags_bin='/usr/local/bin/ctags'
else
endif

let g:tagbar_type_markdown = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:header',
		\ 'i:header',
		\ 'k:header'
	\ ],
    \ 'sort': 0
\ }

let g:ctags_statusline=1
let g:ctags_args=1
let g:Tlist_Use_Right_Window=1
let g:Tlist_Show_One_File = 1
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_WinWidth=25
nnoremap <F12> :TlistToggle<CR>

let tlist_vimwiki_settings = 'wiki;h:Headers'
let tlist_confluencewiki_settings = 'confluencewiki;h:Headers'
let tlist_markdown_settings = 'markdown;h:Headers'
let tlist_textile_settings = 'textile;h:Headers'
let tlist_html_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_xhtml_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_velocity_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_css_settings = 'css;c:Classes;o:Objects(ID);t:Tags(Elements)'
let tlist_javascript_settings = 'javascript;f:Functions;c:Classes;o:Objects'


" snipMate
" text+<TAB> to Auto Complete Code Fragments.
" @see http://www.vim.org/scripts/script.php?script_id=2540
" @see http://code.google.com/p/snipmate/
" @see http://vimeo.com/3535418
let snips_author="闲耘™ (hotoo.cn[AT]gmail.com)"

" for smart template.vim
let g:template_author = '闲耘™ (hotoo.cn[AT]gmail.com)'

" }}}

" ------------------------------- Folding ---------------------------- {{{
":au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/plugin/XMLFolding.vim
if g:OS#win
"    au BufNewFile,BufRead *.xml,*.htm,*.html,*.vm,*.php,*.jsp so $VIM/vimfiles/ftplugin/xml/xml_fold.vim
else
"    au BufNewFile,BufRead *.xml,*.htm,*.html,*.vm,*.php,*.jsp so ~/.vim/ftplugin/xml/xml_fold.vim
endif

" }}}

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


" get week day string in chinese.
function! Week_cn()
    return strftime("%A")
    "let len = strlen("日")
    "return "星期".strpart("日一二三四五六", strftime("%w")*len, len)
endfunction


func! Nr2Hex(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc
" Character to Unicode Number.
function! Char2hex(c)
  if a:c =~# '^[:cntrl:]$' | return '' | endif
  let r = ''
  for i in range(strlen(a:c))
    let r .= printf('%%%02X', char2nr(a:c[i]))
  endfor
  return r
endfunction
function! ToUnicode(str, ...)
    let re = ""
    let chars = split(a:str, '\zs')
    let format = (a:0 == 2) ? a:2 : '%u${U}'
    for char in chars
        let re .= substitute(format, '${U}', Nr2Hex(char2nr(char)), '')
    endfor
    return re
endfunction
autocmd FileType css command! -range -nargs=0 ToUnicode <line1>,<line2>call ToUnicode(<f-args>, "\\${U}")
" }}}

" Chinese Docs
if g:OS#win
    let helptags=$VIM.'\vimfiles\doc'
else
    let helptags='~/.vim/doc'
endif
set helplang=cn

let g:uisvr_opening_window = "tabnew"

if &diff
  let g:loaded_syntastic_plugin = 1
else
  let g:syntastic_javascript_closure_compiler_path = "~/Library/closure-compiler/compiler.jar"
  let g:syntastic_javascript_checkers = ["jshint", "gjslint", "closurecompiler", "jsl"]
  let g:syntastic_javascript_jshint_args = '--config /Users/hotoo/.jshintrc'
  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_check_on_open=1
  let g:syntastic_check_on_wq=0
  let g:syntastic_enable_signs=1
  let g:syntastic_error_symbol='✗'
  let g:syntastic_warning_symbol='⚠'

  highlight SyntasticErrorSign guifg=red guibg=#555555
  highlight SyntasticWarningSign guifg=yellow guibg=#555555
  highlight SignColumn guibg=#555555
endif

let g:instant_markdown_autostart = 0



"" {{{ Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'hotoo/vimwiki'
Bundle 'hotoo/uisvr.vim'
Bundle 'hotoo/calendar-vim'
Bundle 'hotoo/template.vim'
Bundle 'mru.vim'
Bundle 'The-NERD-tree'
Bundle 'hotoo/NERD_tree-Project'
Bundle 'The-NERD-Commenter'
Bundle 'AutoComplPop'
"Bundle 'snipMate'
Bundle 'hotoo/snipmate.vim'
Bundle 'velocity.vim'
Bundle 'ZenCoding.vim'
Bundle 'TaskList.vim'
Bundle 'taglist.vim'
Bundle 'Tagbar'
Bundle 'tpope/vim-markdown'
"Bundle 'project.vim'
"Bundle 'vimcn/project.vim.cnx'
"Bundle 'suan/vim-instant-markdown'
Bundle 'terryma/vim-instant-markdown'
"Bundle 'tomtom/checksyntax_vim'
"Bundle 'tomtom/vimtlib'
Bundle 'scrooloose/syntastic'
Bundle 'digitaltoad/vim-jade'
Bundle 'kchmck/vim-coffee-script'
"" }}}



" vim:fdm=marker
