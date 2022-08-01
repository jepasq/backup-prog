
package BackupProg::Common::Logger;

use strict;

use Locale::gettext qw(gettext); use POSIX;
use Class::Singleton;
use IO::File;
use Switch;

require File::Temp; use File::Temp ();

use BackupProg::Common::Def qw(:Booleans);
use BackupProg::Common::Config;
use BackupProg::Exception::BadArgument;
use BackupProg::Exception::OpenFile;

# inherits Class::Singleton
use vars qw(@ISA); 
@ISA = qw(Class::Singleton);

use constant {
    # LogLevels
    LL_INFO      => 1,
    LL_WARN      => 2,
    LL_ERR       => 3,
    LL_EXC       => 4,
    
    # LogMode (>100 to make error)
    LM_APPEND    => 101,
    LM_NEWFILE   => 102
};

# exports
use Exporter qw(import);
our @EXPORT_OK   =  qw(LL_INFO LL_WARN LL_ERR LM_APPEND LM_NEWFILE);
our %EXPORT_TAGS = (LogLevels => [qw(LL_INFO LL_WARN LL_ERR)],
		    LogModes  => [qw(LM_APPEND LM_NEWFILE)]);


# $_[0] is the log filename
sub _new_instance{
    my $class = shift;
    my $self = bless { }, $class;

    $self->{FILENAME}   = shift || "backup_prog.log";
    $self->{LOG_LEVEL}  = shift || LL_WARN;
    $self->{IDENT_LEN}  = shift || 15;
    $self->{LOG_MODE}   = shift || LM_NEWFILE;

    $self->{TMPFILE}    = 0;
    $self->{FILE}       = 0;

    # A LogMode has been used instead of a LogLevel
    ($self->{LOG_LEVEL} < 100) or throw 
	BackupProg::Exception::BadArgument(gettext("LogMode instead of a LogLevel"));
    
    
    # A LogLevel has been used instead of a LogMode
#    ($self->{LOG_MODE} > 100) or throw
#	BackupProg::Exception::BadArgument("LogLevel instead of a LogMode");
    
    # Must be called here due to singleton implementation
    # (Can't be called by backup_prog.pl)

    $self->open_tmp();
    $self->show_info();
    $self->LOGI(gettext("Logger started"));

    bless($self);
}

sub open_tmp{
    my $self = shift;
    print("Opening Logger tmp file\n");
    $self->{TMPFILE} = new File::Temp();
    my $tmpname = $self->{TMPFILE}->filename;
    print("Logger tmp file is \'$tmpname\'\n");

}

# Internally used method 
sub open{
    my $self = shift;
    my $mode;
    if ( $self->{LOG_MODE} == LM_APPEND ){
	$mode = "a";
    }
    else{
	$mode = "w";
    }

    $self->{FILE} = new IO::File($self->{FILENAME}, $mode) or 
	throw BackupProg::Exception::OpenFile($self->{FILENAME}, $!);

#       die(sprintf(gettext("Cannot open %s : %s"),$self->{FILENAME},$!));
}

# Internally used method 
sub close{
    my $self = shift;
    $self->{FILE}->close();
}

# Internally used method 
sub show_info{
    my $self = shift;
    my $def = BackupProg::Common::Def->new();
    
    $self->{TMPFILE}->print(gettext("Starting '".$def->progname()."' "));
    $self->{TMPFILE}->print(gettext("v".$def->version()." "));
    $self->{TMPFILE}->print(gettext("by \'".$def->user()."\' "));
    $self->{TMPFILE}->print(gettext("on \'".$def->date()."\'\n"));

    $self->{TMPFILE}->print(gettext("  II = Informative\n")); 
    $self->{TMPFILE}->print(gettext("  WW = Warning\n")); 
    $self->{TMPFILE}->print(gettext("  EE = Error\n")); 
    $self->{TMPFILE}->print(gettext("  XX = Exception\n")); 
}

# Internally used method 
# 0: LogLevel constant
# 1: Message
sub print_msg($$$){
    my  ($self, $loglevel, $message) = @_;
    my ($package, $filename, $line) = caller(1);

    # Ending process if LOG_LEVEL >= $logvelev
    if ($loglevel < $self->{LOG_LEVEL}){ return; }

    # LogLevel constant to abreviate form
    my $len = length($package);
    my $ll;
    switch($loglevel){
	case LL_INFO   { $ll="II" }
	case LL_WARN   { $ll="WW" }
	case LL_ERR    { $ll="EE" }
	case LL_EXC    { $ll="XX" }
    }

    # Truncation (if -1, we do not truncate)
    if ($self->{IDENT_LEN} != -1){
	if ($len > $self->{IDENT_LEN}){
	    my $start = $len - $self->{IDENT_LEN};
	    my $subs = substr($package, $start, $self->{IDENT_LEN});
	    substr($subs,0, 3)="...";
	    $package = $subs;
	}
	else{
	    for (my $i = $len; $i< $self->{IDENT_LEN}; $i++){
		$package = $package." ";
	    }
	}
    }
    if ($self->{FILE} == 0){
	$self->{TMPFILE}->print("[$package-$line] $ll $message\n");
    }
    else{
	$self->{FILE}->print("[$package-$line] $ll $message\n");
	$self->{FILE}->flush();
    }
}

# $1 is a BackupProg::Common::Config object
sub configure{
    my $self = shift;
    my $conf = shift;    
    my $l = $conf->getLogFile;
    $self->LOGI("Configuring Logger with \'$l\' logfile\n");
    $self->{FILENAME}   = $l;

    # Opens real logfile
    $self->open();

    # Add separation with ancient logs
    if ( $self->{LOG_MODE} == LM_APPEND ){
	$self->{FILE}->print("=================================\n");
    }

    # Close tmp file
    my $tmpname = $self->{TMPFILE}->filename;
    $self->{TMPFILE}->close();

    # Copy tmp file content to logger
    CORE::open( TMP, $tmpname);
    while(<TMP>){
	$self->{FILE}->print("$_");
    }
    CORE::close( TMP );
}

sub LOGI{
    my ($self, $message) = @_;
    $self->print_msg( LL_INFO, $message);
}

sub LOGW{
    my ($self, $message) = @_;
    $self->print_msg( LL_WARN, $message);
}

sub LOGE{
    my ($self, $message) = @_;
    $self->print_msg( LL_ERR, $message);
}

sub LOGX{
    my ($self, $exception) = @_;
    $self->print_msg( LL_EXC, $exception->message());
}

1;
