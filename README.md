# backup-prog.pl

A flexible TUI backup tool written in perl/curses.

## Dependencies

On arch-based distributions :

	sudo pacman -S  m4 make perl-curses perl-locale-gettext  \
		perl-class-singleton perl-switch perl-datetime       \
		perl-data-dump perl-test2-suite perl-libintl-perl

## Installation

`backup-prog` needs to be installed before correctly running.

### Destination

The modules destination is defined in the *m4/CommonRules.m4* file
as `MOD_TARGET` variable. The executable script will be installed 
as the name stored in the variable `EXE_TARGET`.

To install backup_prog :
- call `gen-makefiles.sh`
- `make links` for development installation (use symbolic links)
- `make install` for production (will copy files).

## Unit tests

This package is shipped with unit tests written using 'test2' module. It can 
be called after a simple call to `./gen-makefiles.sh` :

	make check

## POD documentation

The POD documentation, in .pod files is not installed, because it is
a developper only documentation. To keep a good documentation organization,
you can follow `doc/POD_TEMPLATE` example and to view the result :

	perldoc -t <filename>.pod

To be able to run rhe `man2html` rule of the top-level *Makefile*, you will
need to install `rman` binary which is part of the *polyglotman* suite :

	sudo apt-get install rman 

on debian while on arch (package is from *AUR*) :

	git clone https://aur.archlinux.org/polyglotman.git
	cd polyglotman
           # please examine the PKGBUILD file
	makepkg
	sudo pacman -U polyglotman-*.pkg.tar.zst

## Unit tests

After Makefile generation (call to `./gen-makefiles.sh`), running current
unit tests is done running `make check`. It is a work in progress. Some of
these tests are outdated.

## Translation

Translatable files must be listed in *po/POTFILES*.
`make update-po` will generate po file. You have to edit 
po/BackupProg-*.po files.

To edit pofiles, you can check and install `poedit` :

	sudo pacman -S poedit aspell-<language code>

Then, you just need to edit you language file, for example for french user :

	poedit po/BackupProg-fr.po
