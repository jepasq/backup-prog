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

package BackupProg::Exception::BaseException;

use strict;

use Locale::gettext qw(gettext); use POSIX;
use Error qw(:try);


# inherits Error
use vars qw(@ISA); 
@ISA = qw(Error::Simple);

sub new(){
    my $class = shift;
    my $self  = bless { }, $class;

    my $message = shift || gettext("Empty message");

    $self->{THROWN_MSG} = $self->create_throw_message();
    $self->{MESSAGE} = $self->create_message($message);

    Error::Simple->new($message);
    return $self;
}

# $0 $self
sub create_throw_message{
    my $self = shift;
    my ($package, $filename, $line) = caller;
    my $class_name = $package;

    ($package, $filename, $line) = caller(2);
    my $u1 = sprintf(gettext("Exception \'%s\' thrown from :\n"), $class_name);
    my $u2 = sprintf(gettext("  Module   : %s\n"), $package);
    my $u3 = sprintf(gettext("  Line     : %u"), $line);
    my $msg = "\n===============\n".$u1.$u2.$u3;
}

# $0 $self
# $1 $message
sub create_message{
    my ($self, $message) = @_;
    my $uu = sprintf(gettext("\n  Message  : %s\n"), $message);
    return $self->{THROWN_MSG}.$uu;
}
sub throw_message{
    my $self = shift;
    return $self->{THROWN_MSG};
}

sub message{
    my $self = shift;
    return $self->{MESSAGE};
}
