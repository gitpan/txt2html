use Module::Build;
my $build = new Module::Build(
    module_name	=> 'HTML::TextToHTML',
    dist_name		=> 'txt2html',
    dist_version_from	=> 'scripts/txt2html.PL',
    requires		=> {
		'perl'	=> '5.6.0',
		'Getopt::Long' => 0,
		'Getopt::ArgvFile' => 0,
		'File::Basename' => 0,
		'Pod::Usage' => 0,
		'Data::Dumper' => 0,
    	},
    build_requires	=> {
		'Test::More' => 0,
		'Filter::Simple' => 0.79,
		'Module::Build' => 0.26
    	},
    PL_files 		=> {
	'scripts/txt2html.PL' => 'scripts/txt2html',
	'lib/HTML/TextToHTML.PL' => 'lib/HTML/TextToHTML.pm'
    	},
    script_files	=> ['scripts/txt2html'],
    dict_files		=> { 'txt2html.dict' => 'dict/txt2html.dict' },
    dist_author		=> 'Kathryn Andersen',
    license		=> 'perl',
    add_to_cleanup	=> ['scripts/txt2html', 'lib/HTML/TextToHTML.pm'],
);
$build->add_build_element('dict');
# calculate dictionary path
my $path = $build->install_destination('script');
$path =~ s{bin/?$}{share/txt2html};
$build->install_path->{dict} = $path;

$build->create_build_script;
# create the Makefile.PL if need be
if (! -f 'Makefile.PL')
{
    use Module::Build::Compat;
    print "creating Makefile.PL\n";
    Module::Build::Compat->create_makefile_pl('passthrough', $build);
}
