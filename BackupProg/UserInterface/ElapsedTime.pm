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
    my $sttime = DateTime->now();
    sleep(61);
    my $entime = DateTime->now;
    my $elapse = $entime - $sttime;
    $log->LOGI("Elapsed time : ".$elapse->in_units('seconds')."s");
    $log->LOGI("Elapsed time : ".$elapse->in_units('minutes')."m");
    $log->LOGI("Elapsed time : ".$elapse->in_units('hours')."h");

    # Already blessed by parent
    return $self;
}
1;
