use strict;
use warnings;
use Test::More tests => 1;
use String::Trim;

my $trimmed;
while (<DATA>) {
    trim;
    $trimmed .= $_;
}
is($trimmed, 'onetwothreefour', 'Trims $_ OK');

__DATA__
 one
 two 

three  
  four 
