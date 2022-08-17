use strict;

package BackupProg::UserInterface::WidgetList;

use BackupProg::Common::Logger;

# exports
use Exporter qw(import);
#our @EXPORT_OK   =  qw(Left Right Center 

sub new(){
    my ($class) = shift;
    my $self = {};

    $self->{log} = BackupProg::Common::Logger->instance();
    $self->{log}->LOGI("WidgetList: in constructor");

    
    # The list
    $self->{widgets} = ();
    bless $self, $class;
    return $self;
}

sub len(){
     my $self = shift;
     return 0;
}

sub append(){
     my $self = shift;

    $self->{log}->LOGI("WidgetList: in len is now ". $self->len());
     # TODO
}

1;
