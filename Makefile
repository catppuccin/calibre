all:

build: convert

clean:
	find ./icons/dist -type f -name '*.png' -delete
	find ./icons/dist -empty -delete

convert:
	sh icons/svg_to_png.sh

install:
	mkdir -p "$(HOME)/.config/calibre/resources/images"
	cp -R icons/dist/$(FLAVOR)/* "$(HOME)/.config/calibre/resources/images"

uninstall:
	rm -rf "$(HOME)/.config/calibre/resources/images"


.PHONY: all build clean convert install uninstall