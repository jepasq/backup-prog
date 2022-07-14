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

package BackupProg::UserInterface::Widget;

use Locale::gettext;
use POSIX;
use Error qw(:try);

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Preferences;
use Curses;

use constant {
# Text alignment constants    
    Left   => 101,
    Right  => 102,
    Center => 103,
# Border style constants (see SCREEN.layout file)
    TopCenterLeft  => 201,   # Should be 'backup_prog'
    TopCenterRight => 202,   # Should be the mode
    TopLeft        => 203,   # Should be 'Menu ...'
};

# exports
use Exporter qw(import);
our @EXPORT_OK   =  qw(Left Right Center 
TopCenterLeft TopCenterRight TopLeft);
our %EXPORT_TAGS = (
    Align => [qw(Left Right Center)],
    BorderTypes => [qw(TopCenterLeft TopCenterRight TopLeft)]
    );

sub new(){
    my ($class) = shift;
    my ($label)= shift;
    my (%options) = %{(shift)}; # Shift an hash


    my $log = BackupProg::Common::Logger->instance();
    
    my $win=newwin($options{'h'}, $options{'w'}, $options{'y'}, $options{'x'});
    $win->bkgd(COLOR_PAIR(1)||' ');
    $win->attrset(COLOR_PAIR(1));

    
    draw_label($win, $options{'text_y'}, $options{'w'}, $options{'align'},
	       $label);
    $log->LOGI("New widget's label is '$label'");
    #draw_border($win, $options{'border'}, $options{'w'},, $options{'h'});

    $win->addstr(0, 0, "azeaze");
    refresh($win);
    
    foreach my $k (keys(%options)){
	$log->LOGI("$k=$options{$k})");
    }

    $log->LOGI( $options{'w'});
}

sub draw_label(){
    # y is the label_y value
    my ($win, $y, $w, $align, $label) = @_;

    if ($align==Left){
	$win->addstr($y,1, $label);
    }
    elsif ($align==Right){
	$win->addstr($y,$w - length($label) - 1, 
		     $label);
    }
    elsif ($align==Center){
	my $y = ($w / 2) - (length($label) / 2);
	$win->addstr($y, $y, $label);
    }
    else{
	die("Alignment '".$align."' not implemented");
    }
}

sub draw_border(){
    my ($win, $border, $w, $h) = @_;

    if ($border=TopCenterLeft){
	$win->move($h,0); #y, x
	$win->addch( ACS_BTEE);
    }
    else{
	die("Border '".$border."' not implemented");
    }

}

sub refresh(){
     my ($win) = @_;
    $win->refresh();
}

1;
