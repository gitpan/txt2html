# miscelaneous tests in separate files

#########################

use Test::More tests => 26;
use HTML::TextToHTML;

#########################

# compare two files
sub compare {
    my $file1 = shift;
    my $file2 = shift;

    open(F1, $file1) || return 0;
    open(F2, $file2) || return 0;

    my $res = 1;
    my $count = 0;
    while (<F1>)
    {
	$count++;
	my $comp1 = $_;
	# remove newline/carriage return (in case these aren't both Unix)
	$comp1 =~ s/\n//;
	$comp1 =~ s/\r//;

	my $comp2 = <F2>;

	# check if F2 has less lines than F1
	if (!defined $comp2)
	{
	    print "error - line $count does not exist in $file2\n  $file1 : $comp1\n";
	    close(F1);
	    close(F2);
	    return 0;
	}

	# remove newline/carriage return
	$comp2 =~ s/\n//;
	$comp2 =~ s/\r//;
	if ($comp1 ne $comp2)
	{
	    print "error - line $count not equal\n  $file1 : $comp1\n  $file2 : $comp2\n";
	    close(F1);
	    close(F2);
	    return 0;
	}
    }
    close(F1);

    # check if F2 has more lines than F1
    if (defined($comp2 = <F2>))
    {
	$comp2 =~ s/\n//;
	$comp2 =~ s/\r//;
	print "error - extra line in $file2 : '$comp2'\n";
	$res = 0;
    }

    close(F2);

    return $res;
}

#-----------------------------------------------------------------

my $conv = new HTML::TextToHTML();

#
# Custom headers 1
#
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
infile=>["tfiles/custom-headers.txt"],
outfile=>"custom-headers.html",
custom_heading_regexp=>['^\d+\. +\w+', '^\d+\.\d+\. +\w+', '^\d+\.\d+\.\d+\. +\w+'],
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted custom-headers.txt');

# compare the files
$result = compare('tfiles/good_custom-headers.html', 'custom-headers.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('custom-headers.html');
}

#
# Custom headers 2
#
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
infile=>["tfiles/custom-headers2.txt"],
outfile=>"custom-headers2.html",
custom_heading_regexp=>['^What: '],
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted custom-headers2.txt');

# compare the files
$result = compare('tfiles/good_custom-headers2.html', 'custom-headers2.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('custom-headers2.html');
}

#
# hyphens
#
$conv = undef;
$conv = new HTML::TextToHTML();

$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
infile=>["tfiles/hyphens.txt"],
outfile=>"hyphens.html",
custom_heading_regexp=>[],
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted hyphens.txt');

# compare the files
$result = compare('tfiles/good_hyphens.html', 'hyphens.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('hyphens.html');
}

#
# links
#
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
infile=>["tfiles/links.txt"],
outfile=>"links.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted links.txt');

# compare the files
$result = compare('tfiles/good_links.html', 'links.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('links.html');
}

$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
infile=>["tfiles/links2.txt"],
outfile=>"links2.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted links2.txt');

# compare the files
$result = compare('tfiles/good_links2.html', 'links2.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('links2.html');
}

#
# Lists
#
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
infile=>["tfiles/list.txt"],
outfile=>"list.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted list.txt');

# compare the files
$result = compare('tfiles/good_list.html', 'list.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('list.html');
}

$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
infile=>["tfiles/list-2.txt"],
outfile=>"list-2.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted list-2.txt');

# compare the files
$result = compare('tfiles/good_list-2.html', 'list-2.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('list-2.html');
}

$conv = undef;
$conv = new HTML::TextToHTML();

$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
xhtml=>1,
infile=>["tfiles/list-3.txt"],
outfile=>"list-3.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted list-3.txt');

# compare the files
$result = compare('tfiles/good_list-3.html', 'list-3.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('list-3.html');
}

$conv = undef;
$conv = new HTML::TextToHTML();
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>0,
xhtml=>1,
infile=>["tfiles/list-4.txt"],
outfile=>"list-4.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted list-4.txt');

$conv = undef;
$conv = new HTML::TextToHTML();
# compare the files
$result = compare('tfiles/good_list-4.html', 'list-4.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('list-4.html');
}

$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>0,
xhtml=>1,
infile=>["tfiles/list-advanced.txt"],
outfile=>"list-advanced.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted list-advanced.txt');

# compare the files
$result = compare('tfiles/good_list-advanced.html', 'list-advanced.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('list-advanced.html');
}

$conv = undef;
$conv = new HTML::TextToHTML();
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>0,
xhtml=>1,
infile=>["tfiles/list-styles.txt"],
outfile=>"list-styles.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted list-styles.txt');

# compare the files
$result = compare('tfiles/good_list-styles.html', 'list-styles.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('list-styles.html');
}

#
# news
#
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>0,
mailmode=>1,
infile=>["tfiles/news.txt"],
outfile=>"news.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted news.txt');

# compare the files
$result = compare('tfiles/good_news.html', 'news.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('news.html');
}

#
# pre
#
$result = $conv->txt2html(
system_link_dict=>"txt2html.dict",
default_link_dict=>"",
extract=>1,
use_preformat_marker=>1,
infile=>["tfiles/pre.txt"],
outfile=>"pre.html",
#debug=>1,
#dict_debug=>15,
);
ok($result, 'converted pre.txt');

# compare the files
$result = compare('tfiles/good_pre.html', 'pre.html');
ok($result, 'test file matches original example exactly');
if ($result) {
    unlink('pre.html');
}
