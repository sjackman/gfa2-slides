.DELETE_ON_ERROR:
.SECONDARY:

all: gfa2-slides.html

clean:
	rm -f gfa2-slides.html

install-deps:
	brew install pandoc

publish: gfa2-slides.html
	git checkout -B gh-pages
	cp -a gfa2-slides.html index.html
	git add index.html
	git commit index.html -m 'Render index.html'
	git push --force origin gh-pages
	git checkout master

%.html: %.md reveal.js/js/reveal.js
	pandoc -st revealjs -V theme:sky -o $@ $<

revealjs-3.3.0.tar.gz:
	curl -L -o $@ https://github.com/hakimel/reveal.js/archive/3.3.0.tar.gz

reveal.js-3.3.0/js/reveal.js: revealjs-3.3.0.tar.gz
	tar xf $<
	touch $@

reveal.js/js/reveal.js: reveal.js-3.3.0/js/reveal.js
	cp -a reveal.js-3.3.0 reveal.js
	sed -i .orig -e 's/text-transform: uppercase;//' reveal.js/css/theme/sky.css
	touch $@
