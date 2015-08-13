
if did_filetype()
  finish
endif

if getline(1) =~# '^#!.*\/bin\/evn\s\+node\>'
  setfiletype javascript
endif
