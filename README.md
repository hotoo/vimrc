
# vimrc

```
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

 +---------------------------------Oooo-----------+

闲耘™'s Vim settings, plugins...
```

## 目录结构

```
+- vimrc
|   |
|   +- .vimrc               Unix-like 系统的样本配置文件，本质上是导入 vimrc
|   |
|   +- sysrc_sample.vim     针对系统的特殊设置，比如 Vimwiki 项目的存储目录、
|   |                       私有的账户信息等。
|   |
|   +- vimrc                统一管理的 Vim 设置信息，目前已知支持 Mac & Windows。
|   |
|   `- addons               一些外部工具。
|
+- .tmp               用来存储临时文件的目录，请手工创建。
|
+- .undodir           存储持久化撤销文件的目录，请手工创建。
|
`- .vim_mru_files    MRU.vim 保存的列表文件，如果没有请手工创建。
```

## Features

- `:MRU` Most Recent Used files.
- `:CtrlP`, `<Ctrl-p>` Fuzzy file, buffer, mru, tag, etc finder. https://github.com/ctrlpvim/ctrlp.vim
- `<F2>` NERDTree by project.
- `%` https://github.com/vim-scripts/matchit.zip
- 打开文件时光标自动定位到上次所在的位置。

## Install

for Unix-like(Mac, Linux):

```
$ git clone git@github.com:hotoo/vimrc.git ~/.vim
$ cd ~/.vim
$ make install
$
$ vim sysrc
```
