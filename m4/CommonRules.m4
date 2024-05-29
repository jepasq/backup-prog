changequote([,])dnl
dnl m4 manual is accessible via `info m4`
dnl
define([fatal_error],dnl
  [errprint(__program__:__file__:__line__`: fatal error: $*')m4exit([1])])dnl
dnl
dnl Generates header comments and common variables on output file
define([BP_GEN_HEADER],[dnl
# This file was generated by the 'gen-makefiles.sh' script. 
# Do not edit it. Please see Makefile.in instead.
LNS=ln --symbolic --force
INS=install
RMF=rm -f
PWD=$(shell pwd)
MAKE=make
VERSION=BP_VERSION
MD5=md5sum
TAR=tar -cjvf
BIN=BackupProg-$(VERSION)
GZIP=gzip -c
MANDIR=/usr/share/man
MAN=backup_prog
MAN2HTML=rman -f html
INFO=BackupProg
])
define([BP_GEN_SUBDIRS],[dnl
SUBDIRS=$1
])dnl
dnl
dnl Generates a list of EXE files to install
dnl $1 is the .pl filename WITHOUT extension
define([BP_GEN_EXE_SOURCES],[dnl
EXE_SRC=$1.pl
EXE_TARGET=/usr/local/bin/$1
])dnl
dnl
dnl Generates a list of modules files to install
dnl $1 are the Target sub directory
dnl $2 are the Modules names (with .pm extension)
define([BP_GEN_MOD_SOURCES],[dnl
MOD_SRC= $2
MOD_TARGET=PERLD/$1
])dnl
define([BP_GEN_EXE_RULES],[dnl
link-modules:
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) link-modules ); done

unlink-modules:
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) unlink-modules ); done

link-exe:
	@$(LNS) $(PWD)/$(EXE_SRC) $(EXE_TARGET)

unlink-exe:
	@$(RMF) $(EXE_TARGET)

check-target-dir:
	@echo -n "Checking destination directory... "; \
	if [ ! -d $(MOD_TARGET) ]; then  \
	@echo "no"; \
	@echo "Can't find destination directory ($(MOD_TARGET))"; \
	exit 1; \
	else \
	echo "yes"; \
	fi  

links: link-modules link-exe install-man check-target-dir
	@echo "Note that manpage in installed (not linked)"

unlinks: unlink-exe unlink-modules uninstall-man

install-modules:
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) install-modules ); done

uninstall-modules:
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) uninstall-modules ); done

install-exe:
	@$(INS) $(PWD)/$(EXE_SRC) $(EXE_TARGET)

uninstall-exe:
	@$(RMF) $(EXE_TARGET)

install-man:
	$(RMF) $(MANDIR)/man1/$(MAN).1.gz
	$(GZIP) $(MAN).1 > $(MANDIR)/man1/$(MAN).1.gz

uninstall-man:
	$(RMF) $(MANDIR)/man1/$(MAN).1.gz

clean-man2html:
	$(RMF) $(MAN).1.html

man2html:
	$(MAN2HTML) $(MAN).1 > $(MAN).1.html

install-info:
	cd manual/&&make install-info

uninstall-info:
	cd manual/&&make uninstall-info

install: install-modules install-exe install-mo install-man install-info
uninstall: uninstall-exe uninstall-modules uninstall-man uninstall-info

])dnl
define([BP_GEN_MOD_RULES],[dnl
changequote([[[,]]])dnl
make-target-dir:
	  @if [ ! -d $(MOD_TARGET) ]; then   \
	    mkdir $(MOD_TARGET);            \
	    echo "Created directory'$(MOD_TARGET)'"; \
	  fi                                    \

remove-target-dir:
	  @if [ -d $(MOD_TARGET) ]; then   \
	    rmdir $(MOD_TARGET);            \
	    echo "Removed directory'$(MOD_TARGET)'"; \
	  fi                                    \

create-links:
	@for f in $(MOD_SRC); do (		\
	  $(LNS) $(PWD)/$$f.pm $(MOD_TARGET)	\
	); done
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) link-modules ); done

remove-links:
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) unlink-modules ); done
	@for f in $(MOD_SRC); do (		\
	  $(RMF) $(MOD_TARGET)/$$f.pm		\
	); done

create-inst:
	@for f in $(MOD_SRC); do (		\
	  $(INS) $(PWD)/$$f.pm $(MOD_TARGET)	\
	); done
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) install-modules ); done

remove-inst:
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) uninstall-modules ); done
	@for f in $(MOD_SRC); do (		\
	  $(RMF) $(MOD_TARGET)/$$f.pm		\
	); done

link-modules: make-target-dir create-links
unlink-modules: remove-links remove-target-dir

install-modules: make-target-dir create-inst
uninstall-modules: make-target-dir remove-inst

changequote([,])dnl
])dnl
define([BP_GEN_CLEAN_RULES],[dnl
clean: 
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) clean ); done
	$(RMF) *~

distclean: clean
	@for d in $(SUBDIRS); do (cd $$d; $(MAKE) distclean ); done
	$(RMF) Makefile	
])dnl
define([BP_GEN_PACKAGE_RULES],[dnl
package: clean clean-man2html create-txt
	echo $(TAR) package-$(BIN).tar.bz2 . --exclude=backup*
	echo $(MD5) package-$(BIN).tar.bz2 > package-$(BIN).md5
create-txt:
	@echo -e "You got a copy of $(BIN) in a tar.bz2 archive\n\
\n\
You can check the integrity of this archive with the command : \n\
  md5sum -c package-$(BIN).md5 \n\
\n\
If the integrity check do not failed, you can extract file using : \n\
  tar -xjvf package-$(BIN).tar.bz2\n\
Warning : all the files will be extracted in the current directory\n\
\n\
If you want the application to be localized, you ca run (as root)\n\
  # make install-mo\n\
Please report bugs to the following mail address\n\
  rainbru@free.fr" > package-$(BIN).txt

])dnl
define([BP_GEN_INFO_RULES],[dnl
texinfo-info: $(INFO).texinfo
	makeinfo $(INFO).texinfo

texinfo-html: $(INFO).texinfo
	makeinfo --html $(INFO).texinfo

# Make a .xml file compliant with the docbook format
texinfo-docbook:
	makeinfo --docbook $(INFO).texinfo
	mkdir docbook/
	mv $(INFO).xml docbook/

install-info: texinfo-info texinfo-html texinfo-docbook
	gunzip -c texinfo.tex.gz > texinfo.tex
	gzip -c $(INFO).info > $(INFO).info.gz
	install-info --info-dir=/usr/share/info/ manual/$(INFO).info.gz

uninstall-info:
	install-info --delete $(INFO).info

])dnl
define([BP_GEN_CHECK_RULE],[dnl
check:
	./tests/backup_prog_t.pl
])dnl
changequote(`,')dnl

