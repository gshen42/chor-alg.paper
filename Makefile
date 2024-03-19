OUTPUT_DIR = _build
TEX_FILES := 00-main.tex  \
             01-intro.tex \
             02-algeff.tex \
             03-choreo.tex \
             04-future.tex
TEX_FILES := $(patsubst %, $(OUTPUT_DIR)/%, $(TEX_FILES))

open: $(OUTPUT_DIR)/00-main.pdf
	open $<

$(OUTPUT_DIR)/00-main.pdf: $(TEX_FILES) $(OUTPUT_DIR)/10-references.bib
	cd $(OUTPUT_DIR); xelatex 00-main.tex; bibtex 00-main
	cd $(OUTPUT_DIR); xelatex 00-main.tex; bibtex 00-main
	cd $(OUTPUT_DIR); xelatex 00-main.tex; bibtex 00-main

$(OUTPUT_DIR)/%.tex: %.lagda.tex
	agda --latex --latex-dir=$(OUTPUT_DIR) $<

$(OUTPUT_DIR)/10-references.bib: 10-references.bib
	cp -f 10-references.bib $(OUTPUT_DIR)/.

clean:
	rm -r $(OUTPUT_DIR)
