#!/usr/bin/perl -w

# Backup_prog unit tests

use Test2::Tools::Basic;

use BackupProg::UserInterface::Widget qw(:Align :BorderTypes);
use BackupProg::UserInterface::ActionList;
use BackupProg::UserInterface::WidgetList;


# Widget unit tests
## todo "Widget can be instantiated" => 
sub {
    my %woptions= ('x'=>2, 'y'=>0, 'w'=>20, 'h'=>23,
		   'align' => Center,
		   'text_y' => 0,
		   'border' => TopCenterLeft);
    my $w = BackupProg::UserInterface::Widget->new("Menu=Ctrl+T", \%woptions);
};

todo "Widget's window is accessible" => sub {
    my %woptions= ('x'=>2, 'y'=>0, 'w'=>20, 'h'=>23,
		   'align' => Center, 'text_y' => 0,
		   'border' => TopCenterLeft);
    my $w = BackupProg::UserInterface::Widget->new("Test", \%woptions);
    my $win = $w->get_window();
    # Here we have an error if win is unitialized
    ok($win>0, "Can get widget's window");
};


# ActionList unit tests
todo "ActionList should have an len() method" => sub {
    my $l = BackupProg::UserInterface::ActionList->new();
    ok($l->len() == 0, "ActionList len should be 0");
};

todo "ActionList should have an append() method" => sub {
    my %woptions= ('x'=>2, 'y'=>0, 'w'=>20, 'h'=>23,
		   'align' => Center,
		   'text_y' => 0,
		   'border' => TopCenterLeft);

    my $l = BackupProg::UserInterface::ActionList->new();
    $l->append("Here is a new action");
    ok($l->len() == 1, "ActionList len should now be 1");
};

#use FindBin;
#use WidgetListTest "./";

done_testing();
runtests()
