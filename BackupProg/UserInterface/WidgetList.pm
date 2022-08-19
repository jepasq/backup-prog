use strict;

package BackupProg::UserInterface::WidgetList;

use BackupProg::Common::Logger;

# exports
use Exporter qw(import);
#our @EXPORT_OK   =  qw(Left Right Center 

our @widgets=0;

sub new(){
    my ($class) = shift;
    my $self = {};

    $self->{log} = BackupProg::Common::Logger->instance();
    $self->{log}->LOGI("WidgetList: in constructor");

    
    # The list
    $self->{widgets} = ();
    $self->{len} = 0;

    bless $self, $class;
    return $self;
}

sub len(){
     my $self = shift;
     return (scalar @widgets)-1;
}

sub append(){
     my $self = shift;
     my $val = shift;
     
     push @widgets, $val;
     $self->{log}->LOGI("WidgetList: (@widgets)in len is now ". $self->len());
     # TODO
}

1;
