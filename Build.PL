use MyBuilder;
my $build = MyBuilder->new(
    module_name	=> 'HTML::TextToHTML',
    dist_name		=> 'txt2html',
    dist_version_from	=> 'TextToHTML.in', # finds $VERSION
    requires		=> {
		'perl'	=> '5.6.0',
		'Getopt::Long' => 0,
		'Getopt::ArgvFile' => 0,
		'File::Basename' => 0,
		'Pod::Usage' => 0,
		'Data::Dumper' => 0,
    	},
    build_requires	=> {
		'Test::More' => 0
    	},
    pm_files 		=> {
    	'TextToHTML.pm' => 'lib/HTML/TextToHTML.pm'
    	},
    PL_files 		=> {
    	'UpdatePath.PL' => ['txt2html', 'TextToHTML.pm'],
    	},
    script_files	=> ['txt2html'],
    dist_author		=> 'Kathryn Andersen',
    license		=> 'perl',
);
$build->create_build_script;
# create the Makefile.PL if need be
if (! -f 'Makefile.PL')
{
    use Module::Build::Compat;
    print "creating Makefile.PL\n";
    Module::Build::Compat->create_makefile_pl('passthrough', $build);
}
