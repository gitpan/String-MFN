use Test::More tests => 11;
use strict; use warnings;

BEGIN { use_ok('String::MFN'); }

is(mfn('this_is_ok'),   'this_is_ok',  "acceptable string");
is(mfn("this isn't"),    'this_isnt',  "string with apostrophe and space");
is(mfn('bad & UGLY'), 'bad_and_ugly',  "caps and ampersand");
is(mfn("13;rlk\/~%"),       '13-rlk',  "'funny' chars, leading numbers");

is(mfn("a.mp3.mp3"),         'a.mp3',  "repeat extentions (single)");
is(mfn("a.mp3.mp3.mp3"),     'a.mp3',  "repeat extentions (multiple)");
is(mfn("a.jpg.mp3.mp3"), 'a.jpg.mp3',  "repeat extentions (complex)");

is(mfn("01. Foo Bar"),  '01-foo_bar',  "looks like a track number");
is(mfn("01FooBar"),     '01-foo_bar',  "initial digits");
is(mfn("01.mp3"),           '01.mp3',  "numeric filename with extension should be left alone");
