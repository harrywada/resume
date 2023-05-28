resume.pdf: resume.groff macros.groff
	pdfroff -Kutf8 -mpdfmark resume.groff >resume.pdf

.PHONY: clean
clean:
	rm -f resume.pdf
