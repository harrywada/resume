ENVS := GROFF_TMAC_PATH=. GROFF_FONT_PATH=.
MACROS := -mpdfmark -mresume
PAPER := -dpaper=letter -P-pletter

DIT_FONTS := ArgentumR ArgentumB
T42_FONTS := ArgentumSans-Light.t42 ArgentumNovus-SemiBold.t42
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

devps/download:
	@mkdir -p devps/
	printf %s\\t%s.t42\\n $(foreach f,$(basename $(T42_FONTS)),$(f) $(f)) >devps/download
textmap: /usr/share/groff/current/font/devps/generate/textmap
	cp /usr/share/groff/current/font/devps/generate/textmap textmap

devps/%.t42: %.ttf
	@mkdir -p devps/
	fontforge -lang=ff -c 'Open("$<"); Generate($$fontname + ".t42");'
	mv $(patsubst %.ttf,%.t42,$<) $@
%.afm %.pfa: %.ttf
	@mkdir -p devps/
	fontforge -lang=ff -c 'Open("$<"); Generate($$fontname + ".pfa");'

.PHONY: clean
clean:
	rm -rf devps/ resume.pdf resume.txt textmap *.afm *.pfa
