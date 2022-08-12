use strict;

package BackupProg::UserInterface::WidgetList;

sub new(){
    my ($class) = shift;
    my $self = {};

    #/ The list
    $self->{widgets} = ();
    
    return bless $self, $class;
}

1;
