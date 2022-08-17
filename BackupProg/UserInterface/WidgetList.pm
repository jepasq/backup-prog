use strict;

package BackupProg::UserInterface::WidgetList;

# exports
use Exporter qw(import);
#our @EXPORT_OK   =  qw(Left Right Center 

sub new(){
    my ($class) = shift;
    my $self = {};

    # The list
    $self->{widgets} = ();
    bless $self, $class;
    return $self;
}

sub len(){
     my $self = shift;
     return 0+$self->{widgets};
}

sub append(){
     my $self = shift;


     # TODO
}

1;
