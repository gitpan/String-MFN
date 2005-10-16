use strict;
use warnings;
use ExtUtils::MakeMaker;

my @programs;
my %reqs;

$reqs{'Test::More'} = 0;

for (split "\n", <<'QUERIES') {
mfn|y|Moronic Filename Normalizer
QUERIES
    my ($program, $default, $description) = split /\|/, $_;
    if (prompt("Install '$program', the $description?", $default) =~ /^y/i) {
	push(@programs, 'bin/mfn');
        $reqs{'Config::YAML'} = 0;
    }
}

WriteMakefile(
    NAME          => 'String::MFN',
    AUTHOR        => 'Shawn Boyette <mdxi@cpan.org>',
    VERSION_FROM  => 'lib/String/MFN.pm',
    ABSTRACT_FROM => 'lib/String/MFN.pm',
    PREFIX        => '/usr/local',
    EXE_FILES     => \@programs,
    PREREQ_PM     => \%reqs,
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'String-MFN-*' },
);
