
PUML_URLS_PATTERN=http://www\.plantuml\.com.*gh-pages/docs/\(.*\).puml&fmt=svg&vvv=1&sanitize=true
PUML_URLS_REPLACE=https://dg0lden.github.io/mkdocs-demo/\1.png

site: clean_docs replace_puml_urls convert_puml build_docs copy_puml

.PHONY : replace_puml_urls
replace_puml_urls:
	find . -type f -name "*.md" -print -exec sed -i.bak 's%${PUML_URLS_PATTERN}%${PUML_URLS_REPLACE}%' {} \;
	find . -type f -name "*.md.bak" -print -delete

.PHONY : convert_puml
convert_puml:
	cd docs && plantuml **/*.puml

.PHONY : build_docs
build_docs: clean_docs
	mkdocs build --verbose

.PHONY : clean_docs
clean_docs:
	rm -rf site

.PHONY : copy_puml
copy_puml:
	cd docs && rsync -armR --include="*/" --include="*.puml" --include="*.png" --exclude="*" . ../site/
