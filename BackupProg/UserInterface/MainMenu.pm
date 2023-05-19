use strict;

package BackupProg::UserInterface::MainMenu;

sub new(){
    my $log = BackupProg::Common::Logger->instance();
    my ($class) = shift;
    my $self = {};

    bless $self;

    return $self;
}

sub show(){
    # y is the label_y value
    my $self = shift;
    print "Showing menu\n";
}
1;
