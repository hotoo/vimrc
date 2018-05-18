
install-unix:
	@mkdir .tmp .undodir
	@touch .vim_mru_files
	@ln -s $(CURDIR)/.vimrc ~/.vimrc

install: install-unix
