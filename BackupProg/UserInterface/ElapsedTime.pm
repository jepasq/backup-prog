use strict;

package BackupProg::UserInterface::ElapsedTime;

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Widget;

use DateTime;

our @ISA = qw(BackupProg::UserInterface::Widget);
    
sub new() {

    my ($class, @args) = @_;

    # possibly call Parent->new(@args) first
    my $self = $class->SUPER::new('zze', @args);
    $self->{label}= 'ertetr';
    $self->draw_label();

    my $log = BackupProg::Common::Logger->instance();
    $self->{sttime} = DateTime->now();
    sleep(61);
    $log->LOGI($self->get_elapsed_str());
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
