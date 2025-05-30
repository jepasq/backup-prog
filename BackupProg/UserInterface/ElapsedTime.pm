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
    
    # possibly call Parent->new(@args) first
    my $self = $class->SUPER::new('ELA. 0:00:00', @args);
    $self->SUPER::draw_label();
    
    my $log = BackupProg::Common::Logger->instance();
    $selfStttime = DateTime->now;
    $log->LOGI("In ElapsedTime widget constructor. Label is '".
	       $self->SUPER::get_label()."'");
    addstr(10, 10, $self->get_elapsed_str());

    $self = $class->SUPER::new($self->{label}, @args);

    $self->{lastseconds}  = -1;
#    $self->{label} = $self->get_elapsed_str();

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

    my $log = BackupProg::Common::Logger->instance();
    $log->LOGI("drawing new label : '". $self->{label} ."' at pos " . $ly . 'x'
	. $lx);
    
    $lx = $self->{w} - length($self->{label}) - 1;
    $self->{win}->addstr($ly, $lx, $self->{label});
  #  print "\e[3;77H"; # Cursor Home {ROW;COLUMN}
  #  print $self->{label};
}

# Update each tick from the MainWindow's endless loop
sub update() {
    my $self = shift;
    
    my $date = strftime "%S", localtime;
    
    if ($date ne $self->{lastseconds}) { # TODO: Seems it doesn't work
	my $log = BackupProg::Common::Logger->instance();
	$log->LOGI("Updating : '". $date ."' is ne '".$self->{lastseconds}."'");
	$self->{lastseconds} = $date;
	$self->{label} = $self->get_elapsed_str();
	$self->draw_label();
	# addstr(3, 73, $self->get_elapsed_str());
    } else {
	# $self->draw_label();
    }
}

1;
