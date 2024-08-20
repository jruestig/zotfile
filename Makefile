all: Makefile.in
-include Makefile.in

RELEASE := $(shell grep '"version"' manifest.json | head -n 1 | sed -e 's/ *"version": "//' -e 's/",//')

zotfile.xpi: FORCE
	rm -rf $@
	zip -r $@ chrome chrome.manifest defaults _locales manifest.json -x \*.DS_Store

zotfile-%-fx.xpi: zotfile.xpi
	mv $< $@

Makefile.in: manifest.json
	echo "all: zotfile-${RELEASE}-fx.xpi" > Makefile.in

FORCE:
