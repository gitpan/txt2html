package # hide from PAUSE
    MyUpdatePath;
use Filter::Simple;
use Module::Build;
use strict;
our $VERSION = '0.02';

our $filename;

BEGIN {
    $filename = '';
    if (defined $main::ARGV[0]) {
	$filename = $main::ARGV[0];
	open OUT, ">$filename" || die "Unable to open: $filename";
	warn "making ", $filename, "\n";
    }
}

FILTER {
    my $build = Module::Build->current;
    my $dict_dir = $build->install_destination('dict');
    s#/usr/local/share/bibledaily/plans#${dict_dir}#;
    if ($filename) {
	print OUT $_;
    }
    exit;
};

END {
    if ($filename) {
	close OUT;
    }
}

1;
