use strict;

package BackupProg::UserInterface::MainWindow;

use Locale::gettext;
use POSIX;
use Error qw(:try);

use BackupProg::Common::Logger;
use BackupProg::Common::Def;
use BackupProg::UserInterface::Preferences;
use BackupProg::UserInterface::MainMenu;
use BackupProg::UserInterface::Widget qw(:Align :BorderTypes);
use BackupProg::UserInterface::WidgetList;
use BackupProg::UserInterface::ElapsedTime;
use BackupProg::UserInterface::ActionList;
use Curses;

use IO::Handle;

sub new(){
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

    my %woptions3= ('x'=>45, 'y'=>1, 'w'=>12, 'h'=>3,
		   'align' => Center,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $wmode = BackupProg::UserInterface::Widget->new("mode", \%woptions3);

    my %woptions4= ('x'=>57, 'y'=>1, 'w'=>16, 'h'=>3,
		   'align' => Right,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $ver = sprintf("v%s", $def->version());
    my $wversion = BackupProg::UserInterface::Widget->new($ver, \%woptions4);

    my %woptions5= ('x'=>73, 'y'=>1, 'w'=>18, 'h'=>3,
		   'align' => Right,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $et = BackupProg::UserInterface::ElapsedTime->new(\%woptions5);

    my %woptions6= ('x'=>1, 'y'=>5, 'w'=>70, 'h'=>20,
		   'align' => Left,
		   'text_y' => 1,
		   'border' => TopCenterLeft);
    my $al = BackupProg::UserInterface::ActionList->new(\%woptions6);


    my $stdin = new IO::Handle;
    $stdin->fdopen( fileno( STDIN ), "r" ) || die "Cannot open STDIN";


    my $menu = BackupProg::UserInterface::MainMenu->new();
    
    #    addstr(1, 1, "aze");
    while (1) {
	# Makes the screen empty : must be removed when the "Elapsed err."
	# error is fixed

	$et->update();
#        refresh();    # Black screen if uncommented
	while ( my $char = $stdin->getc() ) {
	    if ( ord( $char ) == 20 ) {
		# Ctrl+T
		$menu->show();
	    } else {
		print "ord: " . ord($char) . "\n";
	    }
	}
#	my $ch = getch();
    }
    #getch();
    endwin();  # Restore the screen at the end of the program
}
1;
