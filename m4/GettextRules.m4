dnl Copyright 2009 Jérôme Pasquier
dnl
dnl This file is part of backup_prog.
dnl
dnl backup_prog is free software: you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation, either version 3 of the License, or
dnl (at your option) any later version.
dnl
dnl backup_prog is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with backup_prog.  If not, see <http://www.gnu.org/licenses/>.
dnl
dnl Generates header common variables on related to GNU Gettext
changequote([,])dnl
define([BP_GEN_GETTEXT_HEADER],[dnl
# Gettext related variables
I18=BackupProg
I18N=po/$(I18)
LOC=/usr/share/locale/fr_FR/LC_MESSAGES/
FILE=file
XTRACT=-k__ -k\$__ -k\%__ -k__x -k__n:1,2 -k__nx:1,2 -k__xn:1,2 -kN__ -k -a
XGET=xgettext --from-code=utf-8 --language=Perl --add-comments $(XTRACT)
MERGE=msgmerge
])
define([BP_GEN_GETTEXT_RULES],[dnl
nb-messages:
	@msgfmt --statistics -c -v -o /dev/null $(I18N)-fr.po

update-po:
	$(XGET) -f po/POTFILES -o po/new-$(I18).pot
	$(MERGE) -U $(I18N)-fr.po po/new-$(I18).pot
	$(RMF) po/new-$(I18).pot
	@echo "PLEASE EDIT $(I18N)-fr.po"

install-mo:
	msgfmt $(I18N)-fr.po -o $(LOC)/$(I18).mo

uninstall-mo:
	$(RMF) $(LOC)/$(I18).mo
])
changequote(`,')dnl
