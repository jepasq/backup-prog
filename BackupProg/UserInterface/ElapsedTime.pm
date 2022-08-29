use strict;

package BackupProg::UserInterface::ElapsedTime;

use BackupProg::UserInterface::Widget;

our @ISA = qw(BackupProg::UserInterface::Widget);
    
sub new() {

    my ($class, @args) = @_;

    # possibly call Parent->new(@args) first
    my $self = $class->SUPER::new('zze', @args);
    $self->{label}= 'ertetr';
    $self->draw_label();
    # Already blessed by parent
    return $self;
}
1;
