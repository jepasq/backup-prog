use strict;

package BackupProg::UserInterface::ElapsedTime;

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Widget;

use DateTime;
use Curses;

use Time::HiRes qw(time);
use POSIX qw(strftime);

our @ISA = qw(BackupProg::UserInterface::Widget);

my $selfStttime = 0;

sub new() {
    my ($class, @args) = @_;

#    $self->{y} = $args{'y'};
#    $self->{w} = $args{'w'};
    
    # possibly call Parent->new(@args) first
    my $self = $class->SUPER::new('ELA. 0:00:00', @args);
    $self->SUPER::draw_label();
    
    my $log = BackupProg::Common::Logger->instance();
    $selfStttime = DateTime->now;
    $log->LOGI("In ElapsedTime widget constructor. Label is '".
	       $self->SUPER::get_label()."'");
    addstr(10, 10, $self->get_elapsed_str());

    $self->{label} = '0:00:01'; #$self->get_elapsed_str();
    $self = $class->SUPER::new($self->{label}, @args);

    $self->{lastseconds}  = -1;

    
    # Already blessed by parent
    return $self;
}

sub get_elapsed_str() {
    my $self = shift;

    my $elapse = DateTime::Duration->new();
    
    if ($selfStttime) {
	$elapse = DateTime->now - $selfStttime;
	
    }
    else {
	$selfStttime = DateTime->now
    }
    
    my $stt = sprintf("Ela. %d:%02d:%02d", $elapse->in_units('hours'),
		      $elapse->in_units('minutes'),
		      $elapse->in_units('seconds'));
    return $stt;
}

sub draw_label(){
    # Stolen from Widget's implementation but without alignment handling etc..
    my $self = shift;

    my $ly=$self->{y};
    my $lx=1;
    
    $lx = $self->{w} - length($self->{label}) - 1;
    $self->{win}->addstr(0, $lx, $self->{label});
}

# Update each tick from the MainWindow's endless loop
sub update() {
    my $self = shift;
    
    my $date = strftime "%S", localtime;
    if ($date != $self->{lastseconds}) {
	$self->{lastseconds} = $date;
	print ".";
	$self->draw_label();
	addstr(10, 10, $self->get_elapsed_str());
    } else {
	addstr(10, 10, "ElapsedTime err.");
    }
}

1;
