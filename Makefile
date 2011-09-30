0: vim-stratifiedjs.xml

vim-stratifiedjs.xml: VERSION
	mkzero-gfxmonk -p syntax -p ftdetect -p ftplugin -v `cat VERSION` vim-stratifiedjs.xml
