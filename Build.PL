use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'Test::Differences',
    license           => 'perl',
    dist_author       => 'Curtis "Ovid" Poe <ovid@cpan.org>',
    dist_version_from => 'lib/Test/Differences.pm',
    perl              => 5.006,
    requires          => {
        'Test::More'   => 0,
        'Text::Diff'   => 0.35,
        'Data::Dumper' => 2.126,
    },
    add_to_cleanup => ['Test-Differences-*'],
    meta_merge     => {
        resources =>
          { repository => 'https://github.com/Ovid/Test-Differences' }
    },
);

$builder->create_build_script();
