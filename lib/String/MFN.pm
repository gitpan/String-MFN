package String::MFN;

require Exporter;
use warnings;
use strict;

our @ISA       = qw(Exporter);
our @EXPORT    = qw(&mfn);

=head1 NAME

String::MFN - 'Normalize' a string in the manner of the mfn utility

=head1 Version

Version 1.0

=cut

our $VERSION = '1.0';

=head1 Synopsis

    use String::MFN;

    my $sane_string = mfn($retarded_string);
    ...

=head1 Description

This module provides an mechanism for normalizing a string in the same
manner filenames are by the utility mfn (the Moronic Filename
Normalizer).

Normalization, in brief, means converting the string to something
which resembles a sane UNIX filename containing no special characters,
while attempting to maintain information carried by the original
formatting.

Normalization, in specific, consists of characters other than
C<[A-Za-z0-9_-.+]> being removed, lowercasing of all letters,
separation of internaCaps, separation of leading numerals from
trailing non-numerals, replaecment of "bracketing" characters (C<<<
{[(<>)]} >>>), replacement of ampersands, and collapsing (things that
look like) repeating extentions.

=head1 Functions

=head2 mfn

Applies normalization routines to a string. Returns the normalized
string.

=cut

sub mfn {
    my $string = shift;
    
    $string =~ s/^[\{\[\(\-_]+//;         # drop leading {[(-_
    $string =~ s/([a-z])([A-Z])/$1\_$2/g; # Insert '_' between caseSeparated words
    $string =~ s/[\{\[\(\<>)\]\}]/-/g;    # change remaining {[(<>)]} to '-'
    $string =~ s/\s+/_/g;                 # change whitespace to '_'
    $string =~ s/\&/_and_/g;              # change '&' to "_and_"
    $string =~ s/[^\w\-\.\+]//g;          # drop if not word, '-', '.', '+'
    $string =~ s/^(\d+)/$1-/;             # Add a hyphen after initial numbers
    $string =~ s/_+-+/-/g;                # collapse _- sequences
    $string =~ s/-+_+/-/g;                # collapse -_ sequences
    $string =~ s/(\-|\_|\.)+/$1/g;        # collapse -_.
    $string =~ s/(\-|\_|\.)$//;           # remove trailing -_. (rare)
    $string =~ s/^(\-|\_|\.)//;           # remove leading -_. (rare-er)
    $string =~ s/[_\-]+(\.[^\.]+)$/$1/;   # drop trailing -_ before extension

    if ($string =~ /\.(\w+?)$/) {         # collapse
	my $ext = $1;                    # repeat
	$string =~ s/(\.$ext)+$/\.$ext/; # extensions
    }

    $string = lc($string);                # slam lowercase

    return $string;
}

=head1 Author

Shawn Boyette, C<< <mdxi@cpan.org> >>

=head1 Bugs

None known.

Please report any bugs or feature requests to
C<bug-string-mfn@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 Copyright & License

Copyright 2004 Shawn Boyette, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of String::MFN
