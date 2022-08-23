use strict;

package BackupProg::UserInterface::MainWindow;

use Locale::gettext;
use POSIX;
use Error qw(:try);

use BackupProg::Common::Logger;
use BackupProg::Common::Def;
use BackupProg::UserInterface::Preferences;
use BackupProg::UserInterface::Widget qw(:Align :BorderTypes);
use BackupProg::UserInterface::WidgetList;
use Curses;


#use BackupProg::Exception::BadArgument;

sub new(){
    print __"We are in MainWindow::new()", "\n";
    
    my $log = BackupProg::Common::Logger->instance();
    $log->LOGI("Informative message");
    $log->LOGW("Warning message");
    $log->LOGE("Error message");

    #throw BackupProg::Exception::BadArgument("MainWindow creation error");

    initscr();
#    start_color();
#    init_pair(1, COLOR_BLACK, COLOR_CYAN);

    my $wl = BackupProg::UserInterface::WidgetList->new();
    
    my %woptions1= ('x'=>2, 'y'=>1, 'w'=>15, 'h'=>3,
		   'align' => Left,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $w = BackupProg::UserInterface::Widget->new("Menu=Ctrl+T", \%woptions1);
    $wl->append($w);
    
    
    my %woptions2= ('x'=>20, 'y'=>1, 'w'=>20, 'h'=>3,
		   'align' => Center,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $def=BackupProg::Common::Def->new();
    my $w2= BackupProg::UserInterface::Widget->new($def->progname(),
						   \%woptions2);

    my %woptions3= ('x'=>60, 'y'=>1, 'w'=>12, 'h'=>3,
		   'align' => Center,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $wmode = BackupProg::UserInterface::Widget->new("mode", \%woptions3);

    my %woptions4= ('x'=>72, 'y'=>1, 'w'=>16, 'h'=>3,
		   'align' => Right,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $ver = sprintf("v%s", $def->version());
    my $wversion = BackupProg::UserInterface::Widget->new($ver, \%woptions4);

    #    addstr(1, 1, "aze");
#    refresh();

    #getch();
    sleep 5;
    endwin();  # Restore the screen at the end of the program
}
1;
