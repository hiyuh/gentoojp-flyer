Q       = 
VQ      = @
ECHO    = echo
RM      = rm -rf
TEX2DVI = platex
DVI2PDF = dvipdfmx
GS      = gs

TTEXS = gentoojp-flyer.tex
TDVIS = $(TTEXS:.tex=.dvi)
TPDFS = $(TDVIS:.dvi=.pdf)

.SUFFIXES: .tex .jpg .png .eps .dvi .pdf

all: $(TPDFS)

.dvi.pdf:
	$(VQ)$(ECHO) "== convert to $@"
	$(Q)$(DVI2PDF) $<

# FIXME: To update index correctly, call $(TEX2DVI) 3 times, ATM... :(
.tex.dvi:
	$(VQ)$(ECHO) "== convert to $@"
	$(Q)$(TEX2DVI) $<
	$(Q)$(TEX2DVI) $<
	$(Q)$(TEX2DVI) $<

gentoojp-flyer.dvi:              \
	gentoojp-flyer.tex           \
	ripples-gblend.eps           \
	gentoo-10-1920x1200.jpg      \
	portage-9999-1680x1050.png   \
	larry-the-cow-full-udder.eps \
	gentwoo_logo.eps             \
	walbrix_logo.eps
#	larry-the-cow-full-udder.svg
#	ripples-gblend.svg

gentoojp-flyer-grayscale.pdf: gentoojp-flyer.pdf
	$(GS) \
		-sDEVICE=pdfwrite \
		-sProcessColorModel=DeviceGray \
		-sColorConversionStrategy=Gray \
		-dOverrideICC \
		-dHaveTransparency=false \
		-o $@ \
		-f $<

.PHONY: distclean clean info

clean: distclean
	$(VQ)$(ECHO) "== clean"
	$(Q)$(RM) $(TPDFS)

distclean:
	$(VQ)$(ECHO) "== distclean"
	$(Q)$(RM) $(TDVIS)

info:
	$(VQ)$(ECHO) "== info"
	$(VQ)$(ECHO) "Q       = $(Q)"
	$(VQ)$(ECHO) "VQ      = $(VQ)"
	$(VQ)$(ECHO) "ECHO    = $(ECHO)"
	$(VQ)$(ECHO) "RM      = $(RM)"
	$(VQ)$(ECHO) "TEX2DVI = $(TEX2DVI)"
	$(VQ)$(ECHO) "DVI2PDF = $(DVI2PDF)"

