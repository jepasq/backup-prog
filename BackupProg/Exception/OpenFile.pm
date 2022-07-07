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

package BackupProg::Exception::OpenFile;

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

    my $filename = shift || gettext("No filename");
    my $msg = shift      || gettext("No message");

    $self->{THROWN_MSG} = $self->create_throw_message($class);
    $self->{MESSAGE} = $self->create_message($msg)
	. $self->get_caller($filename);
}

sub get_caller{
    my $self = shift;
    my $file = shift;
    my $msg= sprintf(gettext("  Filename : %s\n"), $file);
    return $msg;
}

