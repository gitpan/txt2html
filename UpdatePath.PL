use MyBuilder;
my $build = MyBuilder->current;
my $extras_dir = $build->_get_extras_path;

sub update_path {
    my $infile = shift;
    my $outfile = shift;
    open(PFILE, $infile) || die "File '$infile' not readable.";
    open(OFILE, ">$outfile") || die "File '$outfile' not writeable.";
    while(<PFILE>)
    {
	if (m#/usr/local/share/txt2html#)
	{
	    s#/usr/local/share/txt2html#${extras_dir}#;
	}
	print OFILE $_;
    }
}

# update the script
update_path('txt2html.in', 'txt2html');
# chmod the script to execute
chmod 0755, 'txt2html';

# update the Module
update_path('TextToHTML.in', 'TextToHTML.pm');

