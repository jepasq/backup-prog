use strict;

package BackupProg::UserInterface::ActionList;

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Widget;

use DateTime;
use Curses;

our @ISA = qw(BackupProg::UserInterface::Widget);

our @actions=();

sub new() {
    my ($class, @args) = @_;

    # possibly call Parent->new(@args) first
    my $self = $class->SUPER::new('Actions:', @args);

    $self->{log} = BackupProg::Common::Logger->instance();
    #addstr(10, 10, $self->get_elapsed_str());
    $self->{win}->addstr(1, 1, "Just testin'");
    
    #$self->draw_label();
    $self->draw_actions();
    # Already blessed by parent
    return $self;
}

sub len(){
     my $self = shift;
     return scalar @actions;
}

sub append(){
     my $self = shift;
     my $val = shift;
     
     push @actions, $val;
     $self->{log}->LOGI("ActionList: (@actions)in len is now ". $self->len());
}

sub draw_actions(){
    my $self = shift;
    my $action_number = $self->len();
    $self->{log}->LOGI("Printing ActionList with $action_number items...");

    for (my $i = 0; $i <= $action_number; $i++) {
	my $my= 3 + $i;
	$self->{win}->addstr($my, 1, $actions[$i]);
    }
}

1;
