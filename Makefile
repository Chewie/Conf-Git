all: slidy

slidy:
	pandoc -t slidy -s test.markdown --toc -o lol.html

beamer:
	pandoc -t beamer -s test.markdown --toc -V theme:Warsaw -o test.pdf
