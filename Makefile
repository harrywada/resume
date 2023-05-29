ENVS := GROFF_TMAC_PATH=. GROFF_FONT_PATH=.
MACROS := -mpdfmark -mresume
PAPER := -dpaper=letter -P-pletter

FONTS_DIT := devps/ArgentumR devps/ArgentumB
FONTS_PFA := devps/ArgentumR.pfa devps/ArgentumB.pfa

resume.pdf: resume.groff resume.tmac $(FONTS_DIT) $(FONTS_PFA)
	$(ENVS) pdfroff -Kutf8 $(MACROS) $(PAPER) resume.groff >resume.pdf

devps/ArgentumR: devps/ArgentumR.afm
	afmtodit -f ArgentumR devps/ArgentumR.afm textmap devps/ArgentumR
devps/ArgentumR.pfa devps/ArgentumR.afm: ArgentumSans-Light.ttf
	@mkdir -p devps/
	ttf2pt1 -W 0 -ae ArgentumSans-Light.ttf devps/ArgentumR
	@# For portability; POSIX sed doesn't have -i flag.
	mv devps/ArgentumR.pfa devps/ArgentumR.pfa.orig
	sed "/^\/FontName/s/ArgentumSans-Light/ArgentumR/" devps/ArgentumR.pfa.orig >devps/ArgentumR.pfa
	printf "%s\n" "ArgentumR ArgentumR.pfa" >>devps/download
devps/ArgentumB: devps/ArgentumB.afm
	afmtodit -f ArgentumB devps/ArgentumB.afm textmap devps/ArgentumB
devps/ArgentumB.pfa devps/ArgentumB.afm: ArgentumNovus-SemiBold.ttf
	@mkdir -p devps/
	ttf2pt1 -W 0 -ae ArgentumNovus-SemiBold.ttf devps/ArgentumB
	@# For portability; POSIX sed doesn't have -i flag.
	mv devps/ArgentumB.pfa devps/ArgentumB.pfa.orig
	sed "/^\/FontName/s/ArgentumNovus-SemiBold/ArgentumB/" devps/ArgentumB.pfa.orig >devps/ArgentumB.pfa
	printf "%s\n" "ArgentumB ArgentumB.pfa" >>devps/download

.PHONY: clean
clean:
	rm -rf devps/ resume.pdf
