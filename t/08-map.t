use strict;
use warnings;
use Test::More 0.88;
use String::Trim;

my @original = (
  ' one',
  'two   ',
  '',
  'three ',
  ' four ',
  " and a longer string \r\n",
);
my @copy = @original;
my @expected = (
  'one',
  'two',
  '',
  'three',
  'four',
  'and a longer string',
);

is_deeply [map { trim } @copy], \@expected, 'trimmed in map';
# @copy shouldn't be modified yet because map has scalar context
is_deeply \@copy, \@original, 'array not modified';
ok( scalar (grep { m/(^\s|\s$)/ } @copy), 'array still has some whitespace');

is_deeply [map { trim; $_ } @copy], \@expected, 'trimmed in map';
# @copy should be modified because of forced void context
is_deeply \@copy, \@expected, 'array modified';
ok(!scalar (grep { m/(^\s|\s$)/ } @copy), 'array no longer has whitespace');

done_testing;
