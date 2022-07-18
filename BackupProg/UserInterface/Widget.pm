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
    draw_border($win, $options{'border'}, $options{'w'},, $options{'h'});

    $win->refresh();
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
