
install-unix:
	@mkdir .tmp .undodir
	@touch .vim_mru_files
	@cp .sysrc_sample.vim .sysrc.vim
	@ln -s $(CURDIR)/.vimrc ~/.vimrc

install: install-unix
