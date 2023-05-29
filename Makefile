ENVS := GROFF_TMAC_PATH=.
MACROS := -mpdfmark -mresume

resume.pdf: resume.groff resume.tmac
	$(ENVS) pdfroff -Kutf8 $(MACROS) resume.groff >resume.pdf

.PHONY: clean
clean:
	rm -f resume.pdf
