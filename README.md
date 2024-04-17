# backup-prog.pl

A flexible [TUI](https://en.wikipedia.org/wiki/Text-based_user_interface) 
backup tool written in **perl**/*curses*.

## Dependencies

On *arch*-based distributions :

	sudo pacman -S m4 make perl-curses perl-locale-gettext \
		perl-class-singleton perl-switch perl-datetime     \
		perl-data-dump perl-test2-suite perl-libintl-perl

This will download nearly 1Tb of new packages on a brand new system.

## Installation

`backup-prog` needs to be installed before correctly running but before 
copying files, you may want to tune destination directory according to your
filesystem.

### Destination

The modules destination is defined in the *m4/CommonRules.m4* file
as `MOD_TARGET` variable. The executable script will be installed 
as the name stored in the variable `EXE_TARGET`.

To know where these files must be installed, you can use the
`perl --version` command from a terminal. Then, modify

	MOD_TARGET=/usr/lib/perl5/5.36/site_perl/$1/

the *5.36* part with your system's version. You can get it running the
`perl --version` command.

### Linking or copying

System-wide Installation is based on *m4*-powered generated Makefiles.

To install *backup_prog*, follow these steps :
- call `gen-makefiles.sh` to write newly-generated Makefiles.
- `make links` for development installation (use symbolic links)
- `make install` for production (will copy files).

Please note that the *manpage* is always copied, never linked.
The installation is always system-wide (i.e. for all users), not only for
the installer user.

## POD documentation

The POD documentation, in .pod files is not installed, because it is
a developper only documentation. To keep a good documentation organization,
you can follow `doc/POD_TEMPLATE` example and to view the result :

	perldoc -t <filename>.pod

To be able to run rhe `man2html` rule of the top-level *Makefile*, you will
need to install `rman` binary which is part of the 
[polyglotman](https://polyglotman.sourceforge.net/) suite :

	sudo apt-get install rman 

on debian while on arch (package is from *AUR*) :

	git clone https://aur.archlinux.org/polyglotman.git
	cd polyglotman
           # please examine the PKGBUILD file
	makepkg
	sudo pacman -U polyglotman-*.pkg.tar.zst

## Unit tests

This package is shipped with unit tests written using perl's 
[test2](https://metacpan.org/pod/Test2) module. It can 
be called after a simple call to `./gen-makefiles.sh` :

	make check
	
Installation may be needed on some systems for the test script to find
the developpement modules. It is a work in progress. Some of
these tests are outdated.

## Translation

Translatable files must be listed in *po/POTFILES*.
`make update-po` will generate po file. You have to edit 
po/BackupProg-*.po files.

To edit pofiles, you can check and install `poedit` :

	sudo pacman -S poedit aspell-<language code>

Then, you just need to edit you language file, for example for french user :

	poedit po/BackupProg-fr.po

## Log file

The execution creates two log files : 
* One in the `/tmp` directory;
* The second, in the execution directory, called `backup_prog.log`.

## Texinfo manual

Manual in *textinfo* format can be found in `manual/` directory. You
can test it or read ot in PDF format using `texi2pdf` command line tool. To
be able to use it, on arch, you must install the **core/texinfo** package.

	texi2pdf BackupProg.texinfo
	
You can then open the *BackupProg.pdf* file using `okular` or `evince`.
