use strict;
use warnings;
use Test::More 0.94 tests => 2;
use Test::Builder 0.94 qw();
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
    plan tests => 2 * scalar keys %$tests;
    foreach my $key (keys %$tests) {
        my @to_trim = @{ $tests->{$key}->{before} };
        my @ought   = @{ $tests->{$key}->{after} };
        
        my @trimmed = trim(@to_trim);
        is_deeply(\@trimmed, \@ought, 'trim(@array) returns a trimmed array OK');
        is_deeply(\@to_trim, $tests->{$key}->{before}, 'array not modified');
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
