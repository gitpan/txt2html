use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

# add another target to the installation;
# copy the link dictionary to a known global spot.
sub MY::install {
	package MY;
	my $dest_dir = '$(PREFIX)/usr/share/txt2html';
	my $link_dict = 'txt2html.dict';
	my $script = shift->SUPER::install(@_);
	$script =~ s/install :: (.*)$/install :: $1 install_link_dictionary/m;
	$script .= <<"INSTALL";

install_link_dictionary :
	\$(MKPATH) $dest_dir
	\$(PERL) -I\$(PERL_ARCHLIB) -I\$(PERL_LIB) -MExtUtils::Command -e cp $link_dict $dest_dir


INSTALL

	return $script;
}

WriteMakefile(
    'NAME'		=> 'HTML::TextToHTML',
    'DISTNAME'		=> 'txt2html',
    'VERSION_FROM'	=> 'TextToHTML.pm', # finds $VERSION
    'PREREQ_PM'		=> {
		'Getopt::Long' => 0,
		'Getopt::ArgvFile' => 0,
		'File::Basename' => 0,
		'Pod::Usage' => 0,
		'Data::Dumper' => 0,
		'Test::More' => 0
    	},
    'EXE_FILES' => ['txt2html'],
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'txt2html', # retrieve abstract from module
       AUTHOR     => 'Kathryn Andersen') : ()),
);
