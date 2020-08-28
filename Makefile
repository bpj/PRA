LTXPP := pp/latex.pp.md
LTXPDC := pandoc/latex.yaml
LTXDEPS := $(LTXPP) $(LTXPDC) latex/praroman.ltx

.PHONY:

pdf/pra-charts.pdf: documents/pra-charts.md $(LTXDEPS)
	pp $(PPARGS) -import=pp/latex.pp.md $< | pandoc --defaults pandoc/latex.yaml -o $@
