# Copyright 2009-2010 Jérôme Pasquier

# This file is part of backup_prog.

# backup_prog is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# backup_prog is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with backup_prog.  If not, see <http://www.gnu.org/licenses/>.

use strict;

package BackupProg::UserInterface::MainWindow;

use Locale::gettext;
use POSIX;
use Error qw(:try);

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Preferences;
use BackupProg::UserInterface::Widget qw(:Align :BorderTypes);
use Curses;

#use BackupProg::Exception::BadArgument;

=for Curses test

# print $LINES, $COLS
# Curses screen initialization
initscr(); 
start_color();
# change color rgb 0-1000
init_color(&COLOR_BLUE, 200, 400, 600);
init_pair(1, &COLOR_BLACK, &COLOR_BLUE);
bkgd(COLOR_PAIR(1));
refresh();
#attron(COLOR_PAIR(1));
move(2,2);
#addstr("A                      A");
#attroff(COLOR_PAIR(1));
refresh();
my $win = newwin(10, $COLS, 0, 0);
#$win->box(0, 0);
$win->hline(1, 0, ACS_HLINE, $COLS);
#$win->refresh();
$win->addstr(0, 1, $0);
$win->bkgd(COLOR_PAIR(1));
$win->refresh();
getch(); # Wait for user input
# Ending with Curses
bkgd(COLOR_PAIR(0));
erase(); refresh();
endwin();
=cut


sub new(){
    print Locale::gettext::gettext("We are in MainWindow::new()"), "\n";
    
    my $log = BackupProg::Common::Logger->instance();
    $log->LOGI("Informative message");
    $log->LOGW("Warning message");
    $log->LOGE("Error message");

#    throw BackupProg::Exception::BadArgument("MainWindow creation error");

    initscr();
    start_color();
#    init_pair(1, COLOR_BLACK, COLOR_CYAN);

    my %woptions= ( 'x'=>4, 'y'=>8, 'w'=>20, 'h'=>23,
		    'align' => Center,
		    'text_y' => 1,
		    'border' => TopCenterLeft
	);
    my $w = BackupProg::UserInterface::Widget->new("Essaia", \%woptions);
#    addstr(1, 1, "aze");
#    refresh();
    
    getch();
    endwin();  # Restore the screen at the end of the program
}
1;
