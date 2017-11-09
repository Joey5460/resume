all: pdf html

run: html
	firefox resume-ch.html 

html:
	rst2html resume.rst > resume.html
	rst2html resume-ch.rst > resume-ch.html

pdf: 
	pandoc -f rst -t odt resume-ch.rst -o resume-ch.odt
	libreoffice --headless --convert-to pdf:writer_pdf_Export resume-ch.odt
	pandoc -f rst -t odt resume.rst -o resume.odt
	libreoffice --headless --convert-to pdf:writer_pdf_Export resume.odt

clean:
	rm -vf resume.odt resume.html 

