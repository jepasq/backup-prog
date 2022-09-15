use strict;

package BackupProg::UserInterface::ElapsedTime;

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Widget;

use DateTime;
use Curses;

our @ISA = qw(BackupProg::UserInterface::Widget);


sub new() {
    my ($class, @args) = @_;

    # possibly call Parent->new(@args) first
    my $self = $class->SUPER::new('ELA. 0:00:00', @args);
    #$self->SUPER::set_label('ertetr');
    $self->SUPER::draw_label();

    my $log = BackupProg::Common::Logger->instance();
    $self->{sttime} = DateTime->now();
    $log->LOGI("In ElapsedTime widget constructor. Label is '".
	       $self->SUPER::get_label()."'");
    #addstr(10, 10, $self->get_elapsed_str());

    $self->{label} = $self->get_elapsed_str();
    #$self->draw_label();
    $SIG{ALRM} = sub {
	my $log = BackupProg::Common::Logger->instance();
	$log->LOGI($self->get_elapsed_str());
	
	alarm(1);
    };
    alarm(1);
    sleep(2);
    
    # Already blessed by parent
    return $self;
}

sub get_elapsed_str() {
    my $self = shift;

    my $elapse = DateTime->now - $self->{sttime};
    my $stt = sprintf("Ela. %d:%02d:%02d", $elapse->in_units('hours'),
		      $elapse->in_units('minutes'),
		      $elapse->in_units('seconds'));
}

1;
