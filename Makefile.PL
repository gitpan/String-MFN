use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'String::MFN',
    AUTHOR              => 'Shawn Boyette <mdxi@cpan.org>',
    VERSION_FROM        => 'lib/String/MFN.pm',
    ABSTRACT_FROM       => 'lib/String/MFN.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'String-MFN-*' },
);
