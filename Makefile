ENVS := GROFF_TMAC_PATH=.
MACROS := -mpdfmark -mresume
PAPER := -dpaper=letter -P-pletter

resume.pdf: resume.groff resume.tmac
	$(ENVS) pdfroff -Kutf8 $(MACROS) $(PAPER) resume.groff >resume.pdf

.PHONY: clean
clean:
	rm -f resume.pdf
