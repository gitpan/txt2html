# My Builder subclass of Module::Build
package # hide from pause indexer
	MyBuilder;
use Module::Build;
use File::Spec;
BEGIN{@ISA = qw ( Module::Build );}

sub ACTION_install {
    my $self = shift;
    $self->SUPER::ACTION_install;
    $self->_do_install_extras(0);
}

sub ACTION_fakeinstall {
    my $self = shift;
    $self->SUPER::ACTION_fakeinstall;
    $self->_do_install_extras(1);
}

# add another target to the installation;
# copy the link dictionary to a known global spot.
sub _do_install_extras {
    my $self = shift;
    my $fake = (@_ ? shift : 0);
    my $path = $self->_get_extras_path();
    # If there is a destdir, then prepend that to the path
    # Note that we do this here because destdir is set at install
    $path = File::Spec->catdir($self->destdir(), $path) if $self->destdir();
    my @files = ('txt2html.dict');
    print "installing extras to $path\n";
    for (@files) {
	$fake
	    ? print "$_ -> $path/$_ (FAKE)\n"
	    : $self->copy_if_modified($_, $path);
    }
}

# Calculate the "extras" path.
sub _get_extras_path {
    my $self = shift;

    # Try to guess where /usr/share or /usr/local/share kind of
    # directories would be, relative to the 'bin' dir.
    # Assumes it's just up one dir.
    my $bin_path = $self->install_destination('bin');
    my @dirs = File::Spec->splitdir($bin_path);
    pop @dirs; # remove the last element of the bin path
    # replace it with "share" + dist_name
    push @dirs, 'share';
    push @dirs, $self->dist_name();
    my $path = File::Spec->catdir(@dirs);
    return $path;
}

# ACTION_bump_version
# Automate the update of the version, taken from version.txt
# This should only be done by the developer!
sub ACTION_bump_version {
    my $self = shift;

    my $old_version_file = 'old_version.txt';
    my $version_file = 'version.txt';
    my $VERSION = '';
    my $old_version = '';
    my $version = '';
    my $product = $self->dist_name();

    # read the old version
    if (-f $old_version_file
	&& open(OVFILE, $old_version_file))
    {
	while (<OVFILE>)
	{
	    if (/([\$*])(([\w\:\']*)\bVERSION)\b.*\=/)
	    {
		eval $_;
		$old_version = $VERSION;
		last;
	    }
	}
	close(OVFILE);
    }
    # read the new version
    if (-f $version_file
	&& open(NVFILE, $version_file))
    {
	while (<NVFILE>)
	{
	    if (/([\$*])(([\w\:\']*)\bVERSION)\b.*\=/)
	    {
		eval $_;
		$version = $VERSION;
		last;
	    }
	}
	close(NVFILE);
    }
    #
    # change the version in various files
    #

    my $command = 'perl -pi -e "s/VERSION = '
	. "'.*?'" . "/VERSION = '$version'/" . '" txt2html.in TextToHTML.in';
    system($command);

    $command = 'perl -pi -e "!/^txt2html version/ || s/version '
	. "[0-9]+\.[0-9]+" . "/version $version/" . '" README';
    system($command);

    $command = 'perl -pi -e "!/content=\"HTML::TextToHTML/i || s/ v'
	. "[0-9]+\.[0-9]+" . "/ v$version/" . '" tfiles/good_*.html';
    system($command);

    # copy the current version to old_version.txt
    if (-f $old_version_file
	&& open(OVFILE, ">$old_version_file"))
    {
	print OVFILE '$VERSION = ' . "'$version';\n";
	close(OVFILE);
    }
}

1;
