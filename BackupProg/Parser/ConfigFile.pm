# Copyright 2009-2010 Jérôme Pasquier

# This file is part of backup_prog.

# backup_prog is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# backup_prog is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with backup_prog.  If not, see <http://www.gnu.org/licenses/>.

# A configuration file parser for backup_prog
use strict;

package BackupProg::Parser::ConfigFile;

use BackupProg::Common::Logger;
use Data::Dump qw(dump);

sub new{
    my $class = shift;
    my $self = bless { }, $class;

    my @dirs = ("/etc", $ENV{'HOME'}, "config");
    my @base = ("backup", "backup_prog");
    my @exts = ("rc", "hourly.rc", "weekly.rc", "daily.rc", "complete.rc");

    my @search;

    foreach my $dir (@dirs){
	foreach my $bas (@base){
	    foreach my $ext (@exts){
		push(@search, "$dir/$bas.$ext");
	    }
	}
    }

#    print dump(@dirs)."\n";
#    print dump(@exts)."\n";
    my $log  = BackupProg::Common::Logger->instance();
    $log->LOGI(dump(@search));
}

1;
