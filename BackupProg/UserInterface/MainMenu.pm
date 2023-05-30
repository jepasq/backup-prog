use strict;

use Curses;

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

    my $x = 5;
    my $y = 5;
    my $h = 10;
    my $w = 15;
    
    # Create menu and add border
    my $win = newwin($h, $w, $y, $x);
    $win->box($win, 0, 0);

}
1;
