#
# Makefile for fat.com
# 
# Derived from Build.cmd/Clean.cmd
#
# Tested with Linux Mint 19.3 and sdcc 3.5.0
# 
#
TOOLS=../RomWBW/Tools
ZXBINDIR=${TOOLS}/cpm/bin/
ZXLIBDIR=${TOOLS}/cpm/lib/
ZXINCDIR=${TOOLS}/cpm/include/

SDCC_LIB=/usr/share/sdcc/lib
SDCC_OPTS=-c -mz80 --opt-code-size

%.rel: %.c
	sdcc ${SDCC_OPTS} $<

fat.com: fat.hex
	${TOOLS}/Linux/zx ${ZXBINDIR}MLOAD25.COM fat.hex

fat.hex: fat.ihx
	mv $< $@

fat.ihx: ucrt0.rel chario.rel bios.rel bdos.rel ff.rel diskio.rel fat.rel
	sdldz80 -mjxi -b _CODE=0x0100 -k ${SDCC_LIB}/z80 -l z80 fat $+

ucrt0.rel: ucrt0.s
	sdasz80 -fflopz ucrt0.s

clean:
	rm -f *.rel *.lst *.sym *.com *.hex *.ihx *.lk *.map *.mem *.noi *.rst *.asm
