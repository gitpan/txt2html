package # hide from PAUSE
    MyUpdatePath;
use Filter::Simple;
use MyBuilder;
use strict;
our $VERSION = '0.03';

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
    my $build = MyBuilder->current;
    my $dict_dir = $build->install_destination('dict');
    s#/usr/local/share/txt2html#${dict_dir}#g;
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
