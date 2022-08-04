use strict;

package BackupProg::UserInterface::Widget;

use Locale::gettext;
use POSIX;
use Error qw(:try);

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Preferences;

use BackupProg::Exception::BadArgument;

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
    my $self = {};

    $self->{dirty} = 1;
    $self->{label}= shift;
    
    my (%options) = %{(shift)}; # Shift an hash


    if ($options{'text_y'} < 1) {
	my $log = BackupProg::Common::Logger->instance();
	$log->LOGW("The Widget's 'text_y' property is lesser than 1. ".
		   "The label may be masked by the widget's border ".
		   "(Widget's label is '".$self->{label}.")");
    }

    my $log = BackupProg::Common::Logger->instance();
    
    my $win=newwin($options{'h'}, $options{'w'}, $options{'y'}, $options{'x'});
    if ($win) {
	# $win may be NULL when running unit test. Shouldn't in normal run.
	$win->bkgd(COLOR_PAIR(1)||' ');
	$win->attrset(COLOR_PAIR(1));
    
	draw_label($win, $options{'text_y'}, $options{'w'}, $options{'align'},
	    $self->{label});
	draw_border($win, $options{'border'}, $options{'w'},, $options{'h'});
	$win->refresh();
    }
    
    return bless $self, $class;
}

sub draw_label(){
    # y is the label_y value
    my ($win, $y, $w, $align, $label) = @_;

    my $ly=$y;
    my $lx=1;
    
    if ($align==Left){
	$lx = 1;
    }
    elsif ($align==Right){
	$lx = $w - length($label) - 1;
    }
    elsif ($align==Center){
	$ly = ($w / 2) - (length($label) / 2);
	$lx = $ly;
    }
    else{
	die("Alignment '".$align."' not implemented");
    }

    my $log = BackupProg::Common::Logger->instance();
    $log->LOGI("[y:".$ly.", x:".$lx."] Printing label '".$label."'");

    $win->addstr($ly, $lx, $label);
    
}

sub draw_border(){
    my ($win, $border, $w, $h) = @_;

    if ($border=TopCenterLeft){
	#$win->move($h,0); #y, x
	#$win->addch( ACS_BTEE);
	box($win, 0, 0);
	#border($win, ' ', ACS_VLINE, ' ', ACS_HLINE, 0, 0, 0, 0);
	#$win->move($h+1,0); #y, x
	#$win->hline(ACS_HLINE, $w)
    }
    else{
	my $msg="Border '".$border."' not implemented";
	throw BackupProg::Exception::BadArgument($msg);
    }

}

sub refresh(){
    my $self = shift;
    if ($self->{dirty}) {
	$self->draw_border();
	$self->draw_label();
	$self->{win}->refresh();
    }
    $self->{dirty} = 0;
}

sub force_refresh(){
     my $self = shift;

     $self->draw_border();
     $self->draw_label();
     $self->{win}->refresh();

     $self->{dirty} = 0;
}

sub set_label(){
     my $self = shift;
     my $text = shift;

     $self->{label} = $text;
     $self->{dirty} = 1;
}     
1;
