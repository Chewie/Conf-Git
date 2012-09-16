all:
	pandoc -t beamer -s git.markdown --toc -V theme:Warsaw -o git.pdf
