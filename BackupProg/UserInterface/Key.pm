use strict;

package BackupProg::UserInterface::Key;

use BackupProg::Common::Logger;

sub new(){
    my $log = BackupProg::Common::Logger->instance();
    $log->LOGI("UserInterface::Key widget instantiated");
}

sub update(){
    my ($self, $char) = @_;

    print "\e[15;4H"; # Cursor Home {ROW;COLUMN}
    print "KEY pressed ord: " . ord($char) . "\n";
}

1;
