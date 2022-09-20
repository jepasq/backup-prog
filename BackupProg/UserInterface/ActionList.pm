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

    my $log = BackupProg::Common::Logger->instance();
    #addstr(10, 10, $self->get_elapsed_str());
    $self->{win}->addstr(1, 1, "Just testin'");
    
    #$self->draw_label();
    
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

1;
