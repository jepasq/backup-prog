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

package BackupProg::Common::Def;

use DateTime;
use strict;

use constant {
    true  => 1,
    false => 0,

    null  => 0
};

# exports
use Exporter qw(import);
our @EXPORT_OK   =  qw(true false null);
our %EXPORT_TAGS = (Booleans => [qw(true false null)]);

sub new{
    my $class = shift;
    my $self = bless { }, $class;

    $self->{ PROGNAME } = "backup_prog";
    $self->{ VERSION }  = "0.0.1-24";
    $self->{ DATE }     = get_today();
    $self->{ USER }     = getlogin();

    return $self;    
}

# A simple sub returning the date 
sub get_today{
    my $dt = DateTime->now();
    my $ymd = $dt->ymd;
    my $h = $dt->hour;
    my $m = $dt->minute;
    return "$ymd $h\:$m";
}

sub progname{
    my $self = shift;
    return $self->{ PROGNAME };
}

sub version{
    my $self = shift;
    return $self->{ VERSION };
}

sub date{
    my $self = shift;
    return $self->{ DATE };
}

sub user{
    my $self = shift;
    return $self->{ USER };
}

1;
