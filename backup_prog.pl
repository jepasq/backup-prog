#!/usr/bin/perl -w

#use strict;

# Fix the setlocale() error
use POSIX qw(locale_h);
use locale;

use Curses;
use Locale::gettext qw(gettext textdomain); 
use Locale::TextDomain ('backup_prog');

#use POSIX; # Got a 'Subroutine main::getchar redefined' error
use Error qw(:try);

use BackupProg::UserInterface::MainWindow;
use BackupProg::Common::Logger qw(:LogLevels :LogModes);
use BackupProg::Parser::CommandLine;
use BackupProg::Common::Config;

# First, open the Logger
my $log;
try{
    $log = BackupProg::Common::Logger
	->instance( "backup_prog.log", LL_INFO, 25, LM_NEWFILE );
}
catch BackupProg::Exception::BadArgument with{
    my $E = shift;
    print gettext("Error creating Logger : ").$E->message()."\n";
}
catch BackupProg::Exception::OpenFile with{
    my $E = shift;
    print gettext("Error opening logfile : ").$E->message()."\n";
};

=for Config files test
use Data::Dump qw(dump);
use Config::General;
#my $conf = new Config::General("get_distant.d/test");
my $conf = new Config::General("doc/SKINS");
my %config = $conf->getall();
dump(%config);
=cut

# Trying GNU gettext
$log->LOGI("Setting up GNU gettext");
setlocale(LC_MESSAGES, "");
textdomain("BackupProg");

# TRANSLATOR : This is a message for You
print gettext("Welcome to backup_prog\n");

# Creating configuration object
my $conf = BackupProg::Common::Config->new();

# Command-line arguments parsing
my $clp = BackupProg::Parser::CommandLine->new();
$clp->parse_before_configfile();
$log->LOGI("Parsing config file");
$clp->parse();

#exit 0; # WARNING =======================================================

$log->LOGE("Should be written in the temp file");

$log->configure($conf);

use BackupProg::Parser::ConfigFile;
my $cf = BackupProg::Parser::ConfigFile->new();

try{
    my $mw = BackupProg::UserInterface::MainWindow->new();
}
catch BackupProg::Exception::BadArgument with{
    print "Catched a MainWindow exception\n";
    my $E = shift;
    $log->LOGX($E);
};
# Close Logger
$log->close(); 

1;
=pod

=head1 NAME

baclkup_prog - A perl/curses program used to backup files.

=head1 SYNOPSIS

backup_prog [options]

  Options:
    -h, --help			print a brief help message
    -c, --config-file <file>	set the configuration file to be used
=cut
