
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
