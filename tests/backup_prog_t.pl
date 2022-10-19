#!/usr/bin/perl -w

# Backup_prog unit tests

use Test2::Tools::Basic;

use BackupProg::UserInterface::Widget qw(:Align :BorderTypes);
use BackupProg::UserInterface::ActionList;
use BackupProg::UserInterface::WidgetList;

# Widget unit tests
todo "Widget can be instantiated" => sub {
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
    ok($w->get_window()>0, "Can get widget's window");
};


# WidgetList unit tests
todo "WidgetList should have an len() method" => sub {
    my $l = BackupProg::UserInterface::WidgetList->new();
    ok($l->len() == 0, "WidgetList len should be 0");
};

todo "WidgetList should have an append() method" => sub {
    my %woptions= ('x'=>2, 'y'=>0, 'w'=>20, 'h'=>23,
		   'align' => Center,
		   'text_y' => 0,
		   'border' => TopCenterLeft);
    my $w = BackupProg::UserInterface::Widget->new("Test", \%woptions);

    my $l = BackupProg::UserInterface::WidgetList->new();
    $l->append($w);
    ok($l->len() == 1, "WidgetList len should now be 1");
};

todo "WidgetList has a refresh() method" => sub {
    my %woptions= ('x'=>2, 'y'=>0, 'w'=>20, 'h'=>23,
		   'align' => Center,
		   'text_y' => 0,
		   'border' => TopCenterLeft);
    my $w = BackupProg::UserInterface::Widget->new("Test", \%woptions);

    my $l = BackupProg::UserInterface::WidgetList->new();
    $l->append($w);
    ok($l->refresh());
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

done_testing();

