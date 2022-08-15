use strict;

package BackupProg::UserInterface::WidgetList;

sub new(){
    my ($class) = shift;
    my $self = {};

    # The list
    $self->{widgets} = ();
    
    return bless $self, $class;
}

sub len(){
     my $self = shift;
     return 0+$self->{widgets};
}
1;
