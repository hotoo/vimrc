                     {/ ． ．\}
                     ( (oo)   )
 +-------------oOOo---︶︶︶︶---oOOo-------------+
                                      _  ___
                                       \/ _/
                                      _/ /ian__
                                     /__/\ \/ /
                                          \  /
                                          /_/un


                                    闲耘™(@hotoo)
                             hotoo.cn[AT]gmail.com

 +---------------------------------Oooo-----------+

闲耘™'s Vim settings, plugins...


+- vimrc
|   |
|   +- .vimrc_sample        Unix-like 系统的样本配置文件，本质上是导入 vimrc
|   |
|   +- _vimrc_sample        针对 Windows gvim 的样本配置文件，同 .vimrc
|   |
|   +- sysrc_sample.vim     针对系统的特殊设置，比如 Vimwiki 项目的存储目录、
|   |                       私有的账户信息等。
|   |
|   +- vimrc                统一管理的 Vim 设置信息，目前已知支持 Mac & Windows。
|   |
|   `- addons               一些外部工具。
|
+- .tmp
+- tmp               用来存储临时文件的目录，请手工创建。
|
+- .undodir
+- undodir           存储持久化撤销文件的目录，请手工创建。
|
+- .vim_mru_files
`- _vim_mru_files    MRU.vim 保存的列表文件，如果没有请手工创建。


== Install ==

for Unix-like(Mac, Linux):
    $ cd ~
    $ mkdir .tmp .undodir
    $ touch .vim_mru_files
    $ git clone git@github.com:hotoo/vimrc.git .vim
    $ cp .vim/.sysrc_sample.vim ./.sysrc.vim
    $ vi .sysrc.vim
    $ cp .vim/.vimrc_sample ./.vimrc

for Windows:
    $ cd "C:\Program Files\Vim"
    $ mkdir tmp undodir
    $ copy NUL _vim_mru_files
    $ rmdir /s /q vimfiles
    $ git clone git@github.com:hotoo/vimrc.git vimfiles
    $ copy vimfiles\.sysrc_sample.vim sysrc.vim
    $ vi vimfiles/sysrc.vim
    $ del _vimrc
    $ copy vimfiles\_vimrc_sample _vimrc
    $ copy vimfiles\addons\curl.exe C:\WINDOWS\system32
    $ copy vimfiles\addons\libeay32.dll C:\WINDOWS\system32
    $ copy vimfiles\addons\gvimfullscreen.dll vim73
    $ copy vimfiles\addons\vimtweak.dll vim73
    $ copy vimfiles\addons\validate-css.bat C:\WINDOWS\system32
    $ copy vimfiles\addons\validate-html.bat C:\WINDOWS\system32

*注意：*
- 上面的 .sysrc_sample.vim 和 sysrc_sample.vim 的内容参考对应的范例文件。
- vim73 目录请以你的 Vim 实际版本为准。
- for Windows 的 "C:\Program Files\Vim" 是你的 Vim 实际安装目录。
