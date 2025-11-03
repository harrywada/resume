ENVS := GROFF_TMAC_PATH=. GROFF_FONT_PATH=.
MACROS := -mpdfmark -mresume
PAPER := -dpaper=letter -P-pletter

DIT_FONTS := ArgentumR ArgentumB MPLUS1p
T42_FONTS := ArgentumSans-Light.t42 ArgentumNovus-SemiBold.t42 MPLUS1p-Regular.t42
FONTS := $(addprefix devps/,$(DIT_FONTS) $(T42_FONTS))

resume.pdf: resume.groff resume.tmac devps/download $(FONTS)
	$(ENVS) pdfroff -Kutf8 $(MACROS) $(PAPER) resume.groff >resume.pdf
resume.txt: resume.groff resume.tmac
	$(ENVS) groff -Tutf8 -Kutf8 $(MACROS) resume.groff >resume.txt

devps/ArgentumR: ArgentumSans-Light.afm textmap
	@mkdir -p devps/
	afmtodit ArgentumSans-Light.afm textmap devps/ArgentumR
devps/ArgentumB: ArgentumNovus-SemiBold.afm textmap
	@mkdir -p devps/
	afmtodit ArgentumNovus-SemiBold.afm textmap devps/ArgentumB
devps/MPLUS1p: MPLUS1p-Regular.afm textmap
	@mkdir -p devps/
	afmtodit -s MPLUS1p-Regular.afm textmap devps/MPLUS1p

devps/download:
	@mkdir -p devps/
	printf %s\\t%s.t42\\n $(foreach f,$(basename $(T42_FONTS)),$(f) $(f)) >devps/download
textmap: /usr/share/groff/current/font/devps/generate/textmap
	cp /usr/share/groff/current/font/devps/generate/textmap textmap

devps/%.t42: %.ttf
	@mkdir -p devps/
	fontforge -c 'open(argv[1]).generate(argv[1][:-3] + "t42")' $<
	mv $(patsubst %.ttf,%.t42,$<) $@
%.afm %.pfa: %.ttf
	fontforge -c 'open(argv[1]).generate(argv[1][:-3] + "pfa")' $<

.PHONY: clean
clean:
	rm -rf devps/ resume.pdf resume.txt textmap *.afm *.pfa
