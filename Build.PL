use Module::Build;
use File::Spec;
my $build_class = ($Module::Build::VERSION > 0.27
                   ? 'Module::Build'
                   : Module::Build->subclass(
		   class=>'MyBuilder',
		   code => <<'EOF'));
sub install_base_relative {
   my ($self, $type) = @_;
   return File::Spec->catdir('share', 'txt2html') if $type eq 'dict';
   return $self->SUPER::install_base_relative($type);
}
EOF

my $build = new $build_class(
    module_name	=> 'HTML::TextToHTML',
    dist_name		=> 'txt2html',
    dist_version_from	=> 'scripts/txt2html.PL',
    requires		=> {
		'perl'	=> '5.6.1',
		'Getopt::Long' => 0,
		'Getopt::ArgvFile' => 0,
		'File::Spec' => 0,
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
$path =~ s#/$##;
$path =~ s{(bin|script)}{share/txt2html};
$build->install_path->{dict} = $path;

$build->create_build_script;
