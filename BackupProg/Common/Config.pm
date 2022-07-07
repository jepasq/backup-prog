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

package BackupProg::Common::Config;

use strict;

# $_[0] is the log filename
sub new{
    my $class = shift;
    my $self = {};

    # The name of the configuration file passed as a command-line argument
    $self->{CONFIG_FILE}   = undef; 
    $self->{LOG_FILE}      = 'backup_prog.log'; 

    bless ($self, $class);
    return $self;
};

sub setConfigFile($){
    my ($self, $cf) = @_;
    $self->{CONFIG_FILE} = $cf;
}
sub getConfigFile{ 
    my $self = shift;
    return $self->{CONFIG_FILE}; 
};

sub setLogFile($){
    my ($self, $lf) = @_;
    $self->{LOG_FILE} = $lf;
}
sub getLogFile{ 
    my $self = shift;
    return $self->{LOG_FILE}; 
};

1;
