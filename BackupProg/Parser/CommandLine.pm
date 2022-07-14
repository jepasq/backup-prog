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

# A command line argument parser for backup_prog
package BackupProg::Parser::CommandLine;

use strict;

use Getopt::Long;
use Pod::Usage;
use Data::Dump qw(dump);

# We use this contant to avoid gettext warnings when updating message catalog
use constant EMPTYSTR => "";

sub new{
    my $class = shift;
    my $self = bless { }, $class;
};

sub parse_before_configfile{
    my $self = shift;
    
    print("parse_before_configfile ():\n");
    my $help = EMPTYSTR;
    my $config_file = EMPTYSTR;

    my %opts = ();

    # Does not Provide error messages for unknown options
    Getopt::Long::Configure( qw(pass_through) );
    GetOptions(\%opts, 'help|?' => \$help,
	       'c|config-file=s' => \$config_file);

    # pod2usage uses backup_prog.pl POD documentation
    pod2usage(1) if $help;

    print("config_file = \'$config_file\'\n");
};

sub parse{
    print("parse ():\n");
    my $logfile = EMPTYSTR;

    # Provide error messages for unknown options
    Getopt::Long::Configure( qw(no_pass_through) );
    GetOptions('l|log-file=s' => \$logfile);

    print("logfile = \'$logfile\'\n");

};
1;
