GCC = cc
PREFIX=/usr/local
CFLAGS = -O2 -Wall $(shell pkg-config --cflags gtk+-2.0)
LIBS = $(shell pkg-config --libs gtk+-2.0)
CFLAGS += -DGTK_DISABLE_BROKEN -DGTK_DISABLE_DEPRECATED

VERSION = 2.0.0rc2
all: switch

switch: switch.c switch.h
	${GCC} -o switch2 switch.c ${CFLAGS} ${LIBS}

clean:
	-rm -f switch2 *~
	
install: all
	strip switch2
	mkdir -p ${PREFIX}/bin
	mkdir -p ${PREFIX}/man
	install -c switch2 ${PREFIX}/bin
	install -c switch.1 ${PREFIX}/man

dist: clean
	rm -rf /tmp/gtk-theme-switch-$(VERSION)
	cp -r . /tmp/gtk-theme-switch-$(VERSION)
	tar czf ../gtk-theme-switch-$(VERSION).tar.gz -C /tmp/ gtk-theme-switch-$(VERSION)
	rm -rf /tmp/gtk-theme-switch-$(VERSION)
