use strict;
use warnings;
use ExtUtils::MakeMaker;

my @programs;

for (split "\n", <<'QUERIES') {
mfn|y|Moronic Filename Normalizer (needs Config::YAML)
QUERIES
    my ($program, $default, $description) = split /\|/, $_;
    if (prompt("Install '$program', the $description?", 
               $default) =~ /^y/) {
	push(@programs, $program);
    }
}

WriteMakefile(
    NAME                => 'String::MFN',
    AUTHOR              => 'Shawn Boyette <mdxi@cpan.org>',
    VERSION_FROM        => 'lib/String/MFN.pm',
    ABSTRACT_FROM       => 'lib/String/MFN.pm',
    PL_FILES            => {}, #{ map {("bin/$_.PL" => "bin/$_")} @programs},
    EXE_FILES           => [ map {"bin/$_"} @programs],
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'String-MFN-*' },
);
