use strict;
use warnings;
use Test::More 0.94 tests => 2;
use String::Trim;

my $tests = {
    one => {
        before => ['one',  ' two ', "three\n", undef],
        after  => ['one',  'two',   'three', undef],
    },
    two => {
        before => [' test '],
        after  => ['test'],
    },
};

subtest 'return' => sub {
    plan tests => scalar keys %$tests;
    foreach my $key (keys %$tests) {
        my @to_trim = @{ $tests->{$key}->{before} };
        my @ought   = @{ $tests->{$key}->{after} };
        
        my @trimmed = trim(@to_trim);
        is_deeply(\@trimmed, \@ought, 'trim(@array) returns a trimmed array OK');
    }
};

subtest 'in-place' => sub {
    plan tests => scalar keys %$tests;
    foreach my $key (keys %$tests) {
        my @to_trim = @{ $tests->{$key}->{before} };
        my @ought   = @{ $tests->{$key}->{after} };
        
        trim(@to_trim);
        is_deeply(\@to_trim, \@ought, 'trims an array in-place OK');
    }
};
