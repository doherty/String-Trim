use strict;
use warnings;

package String::Trim;
# ABSTRACT: trim whitespace from your strings

=head1 SYNOPSIS

    use String::Trim;

    print "Do it? ";
    trim(my $response = <>);
    print "'$response'\n";

=head1 DESCRIPTION

C<String::Trim> trims whitespace off your strings. L<chomp> trims only C<$/> (typically,
that's newline), but C<trim> will trim all leading and trailing whitespace.

=cut

use Exporter 5.57 qw(import);
our @EXPORT = qw(trim);

=head1 FUNCTIONS

=head2 trim

Returns the string with all leading and trailing whitespace removed. Trimming
undef gives you undef. Alternatively, you can trim in-place.

    my $var     = ' my string  ';
    my $trimmed = trim($var);
    # OR
    trim($var);

C<trim> also knows how to trim an array or arrayref:

    my @to_trim = (' one ', ' two ', ' three ');
    my @trimmed = trim(@to_trim);
    # OR
    trim(@to_trim);
    # OR
    my $trimmed = trim(\@to_trim);
    # OR
    trim(\@to_trim);

=cut

sub trim { # Startin point: http://www.perlmonks.org/?node_id=36684
    if (defined wantarray) {
        @_ = (@_ ? @_ : $_);
        if (ref $_[0] eq 'ARRAY') {
            @_ = @{ $_[0] };
            for (@_) { s{^\s+|\s+$}{}g if defined $_ }
            return \@_;
        }
        else {
            for (@_ ? @_ : $_) { s{^\s+|\s+$}{}g if defined $_ }
        }
        return wantarray ? @_ : $_[0];
    }
    else {
        if (ref $_[0] eq 'ARRAY') {
            for (@{ $_[0] }) { s{^\s+|\s+$}{}g if defined $_ }
        }
        else {
            for (@_ ? @_ : $_) { s{^\s+|\s+$}{}g if defined $_ }
        }
    }
}

=head1 RATIONALE

C<trim> is often used by beginners, who may not understand how to spin their own. While
L<String::Util> does have a C<trim> function, it depends on L<Debug::ShowStuff>, which
depends on L<Taint>, which fails the test suite, and doesn't appear to be maintained.
This module installs, is actively maintained, and has no non-core dependencies.

Other options include L<Text::Trim> and L<String::Strip> (which is implemented in XS,
and is therefore likely to be very fast, but requires a C compiler).

=head1 CREDITS

This module was inspired by code at L<http://www.perlmonks.org/?node_id=36684> written
by japhy (Jeff Pinyan), dragonchild, and Aristotle. This Perl module was written by Mike
Doherty.

=cut

1;

__END__
