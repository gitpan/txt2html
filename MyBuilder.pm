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
    my @files = ('txt2html.dict');
    print "installing extras to $path\n";
    for (@files) {
	$fake
	    ? print "$_ -> $path/$_ (FAKE)\n"
	    : $self->copy_if_modified($_, $path);
    }
}

# Try to guess where /usr/share or /usr/local/share kind of
# directories would be, relative to the 'bin' dir.
# Assumes it's just up one dir.
sub _get_extras_path {
    my $self = shift;
    my $bin_path = $self->install_destination('bin');
    my @dirs = File::Spec->splitdir($bin_path);
    pop @dirs; # remove the last element of the bin path
    # replace it with "share" + dist_name
    push @dirs, 'share';
    push @dirs, $self->dist_name();
    my $path = File::Spec->catdir(@dirs);
    return $path;
}

1;
