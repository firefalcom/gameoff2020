VERSION=0.0.1

SCSS_FILES := $(shell find src/styles -type f -name '*.scss')
CSS_FILES := $(SCSS_FILES:.scss=.css)

compile: css
	haxe build.hxml -D version=$(VERSION) -D js-source-map

%.css: %.scss
	sass $< ./build/styles/$(shell basename $(<:.scss=.css))

css: $(CSS_FILES)

retail: compile
	rm -rf retail
	mkdir -p retail/build
	rsync -avzm . ./retail -progress --exclude='**/phaser.js' --include='deps/**/*.css' --include='deps/**/*.js' --include='data/**' --include='src/*.css' --include='src/*.js' --exclude='haxe-babylon' --exclude='examples' --include='src/*.html' --include='*/' --include='index.html' --exclude='*'
	cp build/generated.js retail/build/generated.js

obfuscate: retail
	uglifyjs --compress --mangle -- build/generated.js > retail/build/generated.js

zip: retail
	zip -r atomic-$(VERSION).zip retail




.PHONY: all retail
