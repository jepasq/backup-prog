# backup-prog.pl

A flexible TUI backup tool written in perl/curses.

## Dependencies

On arch-based distributions :

	sudo pacman -S perl-curses perl-locale-gettext perl-class-singleton \
		perl-switch perl-datetime perl-data-dump

## Installation

`backup-prog` needs to be installed before correctly running.

### Destination

The modules destination is defined in the *m4/CommonRules.m4* file
as `MOD_TARGET` variable. The executable script will be installed 
as the name stored in the variable `EXE_TARGET`.

To install backup_prog :
- call `gen-makefiles.sh`
- `make links` for development installation (use symbolic links)
- `make install` for production (will copy files

POD documentation
=================

The POD documentation, in .pod files is not installed, because it is
a developper only documentation.
