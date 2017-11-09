all: clean pdf html

prepare:
	cp -v resume-ch.rst resume.rst.in
	perl -i -p -e 'BEGIN{$$NODEID = qx"hg log -r . --template \"{node|short}\""} s/NODEID/$$NODEID/g' resume.rst.in
	perl -i -p -e 'BEGIN{$$DATE = qx"hg log -r . --template \"{date|shortdate}\""} s/DATE/$$DATE/g' resume.rst.in

pdf: prepare
	rst2pdf resume.rst.in --output=resume.pdf

html: prepare
	rst2html --stylesheet-path=resume.css resume.rst.in | sed 's/border="1"/border="0"/g' >| resume.html
	perl -i -p -e 'BEGIN{open JS, "<google-analytics.js" || die; $$js = join "", <JS>} s/<title>/$$js<title>/' resume.html
clean:
	rm -vf resume.pdf resume.html resume.rst.in
dist: pdf html
	#scp resume.html resume.pdf ry4an@four:/var/www/ry4an/resume
	#scp resume.rst.in ry4an@four:/var/www/ry4an/resume/resume.txt
	#ssh ry4an@four chmod -v a+r /var/www/ry4an/resume/*
	cp resume.html resume.pdf /var/www/ry4an/resume
	cp resume.rst.in /var/www/ry4an/resume/resume.txt
	chmod -v a+r /var/www/ry4an/resume/*
