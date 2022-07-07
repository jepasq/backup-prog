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

package BackupProg::Exception::BadArgument;

use strict;

use Locale::gettext qw(gettext); use POSIX;
use Error qw(:try);

use BackupProg::Exception::BaseException;

# inherits BaseException
use vars qw(@ISA); 
@ISA = qw(BackupProg::Exception::BaseException);

sub new(){
    my $class = shift;
    my $self = bless { }, $class;

    my $msg = shift;

    $self->{THROWN_MSG} = $self->create_throw_message($class);
    $self->{MESSAGE} = $self->create_message($msg) ."\n". $self->get_caller();
}

sub get_caller{
    my $self = shift;
    my ($package, $filename, $line) = caller(4);
    my $u1 = sprintf(gettext("  Module   : %s\n"), $package);
    my $u2 = sprintf(gettext("  Line     : %u\n"), $line);
    my $msg =  "Caller informations :\n".$u1.$u2;
    return $msg;
}

