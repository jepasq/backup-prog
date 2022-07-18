#!/usr/bin/perl -w

# Backup_prog unit tests

use Test2::Tools::Basic;

use BackupProg::UserInterface::Widget qw(:Align :BorderTypes);

=for
ok($x, "simple test");
if ($passing) {
    pass('a passing test');
}
else {
    fail('a failing test');
}
diag "This is a diagnostics message on STDERR";
note "This is a diagnostics message on STDOUT";
{
    my $todo = todo "Reason for todo";
    ok(0, "this test is todo");
}
ok(1, "this test is not todo");
todo "reason" => sub {
    ok(0, "this test is todo");
};
ok(1, "this test is not todo");
SKIP: {
    skip "This will wipe your drive";
    # This never gets run:
    ok(!system('sudo rm -rf /'), "Wipe drive");
}
done_testing;
=cut

todo "Waiting for Widget implementation" => sub {
    my %woptions= ('x'=>2, 'y'=>0, 'w'=>20, 'h'=>23,
		   'align' => Center,
		   'text_y' => 0,
		   'border' => TopCenterLeft);
    my $w = BackupProg::UserInterface::Widget->new("Menu=Ctrl+T", \%woptions);
};
done_testing();
