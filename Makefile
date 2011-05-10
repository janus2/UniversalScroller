export

#------------------------------------

# Unfortunately, "DEBUG" is used internally the "Generic BeOS Makefile"
# framework. So we resort to using ENABLE_DEBUG

ENABLE_DEBUG=yes

#------------------------------------

SUBDIRS=src/filter src/preferences
ENV_VERSION:=$(VERSION)
VERSION=$(shell if test -z $$VERSION ; then if test -e .git ; then echo git-$(shell git branch | grep '*' | sed -e 's/^[[:space:]]*\*[[:space:]]*//' -e 's/[^a-zA-Z]/_/g')-$(shell date +'%Y%m%d') ; else echo "UNKNOWN" ; fi ; else echo $$VERSION ; fi )
OSNAME=$(shell uname -s)
DISTNAME=$(NAME)-$(VERSION)-$(OSNAME)

NAME=UniversalScroller
NAME_LOWERCASE_NON_SPACED=universalscroller
URL=http://$(NAME_LOWERCASE_NON_SPACED).quelltextlich.at/
EMAIL=$(NAME_LOWERCASE_NON_SPACED)@quelltextlich.at

all:
	for SUBDIR in $(SUBDIRS) ; do pushd $$SUBDIR && $(MAKE) all && popd ; done

clean:
	for SUBDIR in $(SUBDIRS) ; do pushd $$SUBDIR && $(MAKE) clean && popd ; done
	rm -rf dist

dist: all
	rm -rf dist
	mkdir dist
	scripts/substituting_cp.sh doc/readme.txt dist
	scripts/substituting_cp.sh scripts/install.sh dist
	scripts/substituting_cp.sh scripts/uninstall.sh dist
	cp src/preferences/obj.$(BE_HOST_CPU)/Preferences dist
	cp src/filter/obj.$(BE_HOST_CPU)/UniversalScroller dist
	cp LICENSE.txt dist
	chmod +x dist/install.sh
	chmod +x dist/uninstall.sh
	chmod +x dist/Preferences

dist-zip: dist
	rm -rf $(NAME)-$(VERSION)
	cp -a dist $(DISTNAME)
	zip -r $(DISTNAME).zip $(DISTNAME)
	rm -rf $(DISTNAME)

release:
	if test "x$(ENABLE_DEBUG)" != "x" ; then echo -e "\n\n\nAborting, as ENABLE_DEBUG is set\n\n" >&2 ; exit 1 ; fi
	if test x$(VERSION) != x$(ENV_VERSION) ; then echo -e "\n\n\nTry issuing:\n\n  VERSION=3.9 make release\n\n" >&2 ; exit 1 ; fi
	$(MAKE) dist-zip
	
test_UniversalScroller: all	
	cp src/filter/obj.x86/UniversalScroller /boot/home/config/add-ons/input_server/filters
	/system/servers/input_server -q
	for i in $(shell seq 10 -1 0 ) ; do echo -n "$$i " ; sleep 1 ; done
	rm -f /boot/home/config/add-ons/input_server/filters/UniversalScroller
	/system/servers/input_server -q