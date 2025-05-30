use strict;

package BackupProg::UserInterface::Widget;

use Locale::gettext;
use POSIX;
use Error qw(:try);

use BackupProg::Common::Logger;
use BackupProg::UserInterface::Preferences;

use BackupProg::Exception::BadArgument;

use Curses;

use Scalar::Util 'blessed';

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

    # Check if it's a hash before derreferencing to avoid
    # 'Can't use an undefined value as a HASH reference' error
    my %options;
    my $optionsref = shift;
    if (ref($optionsref) eq 'HASH') {
        %options = %{$optionsref};
    } 
    
    $self->{align} = $options{'align'};
    $self->{y} = $options{'y'};
    $self->{w} = $options{'w'};

    $self->{border} = $options{'border'};
    $self->{text_y} = $options{'text_y'};
    
    if ($options{'text_y'} < 1) {
	my $log = BackupProg::Common::Logger->instance();
	$log->LOGW("The Widget's 'text_y' property is lesser than 1. ".
		   "The label may be masked by the widget's border ".
		   "(Widget's label is '".$self->{label}.")");
    }

    my $log = BackupProg::Common::Logger->instance();
    
    $self->{win}=newwin($options{'h'},$options{'w'},
			$options{'y'},$options{'x'});
    if ($self->{win}) {
	$self->{win}->bkgd(COLOR_PAIR(1)||' ');
	$self->{win}->attrset(COLOR_PAIR(1));
    }
    
    bless $self, $class;
    $self->draw_label();
    $self->draw_border();
    # The following needs to be after label and border drawing, otherwise,
    # the complete UI is not drawn anymore
    if ($self->{win}) {
	$self->{win}->refresh();
    }
    return $self;
}

sub draw_label(){
    # y is the label_y value
    my $self = shift;

    my $ly=$self->{y};
    my $lx=1;
    
    if ($self->{align}==Left){
	$lx = 1;
    }
    elsif ($self->{align} == Right){
	$lx = $self->{w} - length($self->{label}) - 1;
    }
    elsif ($self->{align} == Center){
	$lx = ($self->{w} / 2) - (length($self->{label}) / 2) -1;
	$ly = $self->{text_y};
    }
    else{
	die("Alignment '".$self->{align}."' not implemented");
    }

    if ($self->{win}) {
	$self->{win}->addstr($ly, $lx, $self->{label});
    }
    else {
	my $msg="Can't add string '".$self->{label}."'";
	# print $msg; # Do not die as it occurs also in unit tests
	my $log = BackupProg::Common::Logger->instance();
	$log->LOGW($log)
    }
}

sub draw_border(){
    my $self = shift;

    if ($self->{border} == TopCenterLeft) {
	if ($self->{win}) { # Only fail in tests
	    box($self->{win}, 0, 0);
	}
    }
    else {
	my $msg="Border '".$self->{border}."' not implemented";
	throw BackupProg::Exception::BadArgument($msg);
    }
}

sub refresh(){
    my $self = shift;
    if ($self->{dirty}) {
	$self->draw_border();
	$self->draw_label();
	if ($self->{win}) {
	    $self->{win}->refresh();
	}
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

sub get_label(){
     my $self = shift;
     return $self->{label};
}     

sub get_window() {
    my $self = shift;
    print blessed( $self->{win} );
    my $aa = $self->{win};
    print blessed( $aa );
    return $aa;
}

1;
