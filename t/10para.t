#########################

use Test::More tests => 11;
use HTML::TextToHTML;
ok(1); # If we made it this far, we are ok.

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

my $conv = new HTML::TextToHTML();
ok( defined $conv, 'new() returned something' );
ok( $conv->isa('HTML::TextToHTML'), "  and it's the right class" );

# test the process_para method alone
$test_str = "Matty had a little truck
he drove it round and round
and everywhere that Matty went
the truck was *always* found.
";

$ok_str = "<P>Matty had a little truck<BR>
he drove it round and round<BR>
and everywhere that Matty went<BR>
the truck was <EM>always</EM> found.
";

$out_str = $conv->process_para($test_str);
ok($out_str, 'converted sample string');

# compare the result
is($out_str, $ok_str, 'compare converted string with OK string');

# test the process_para method with an ordered list
$test_str = "Here is my list:

1. Spam
2. Jam
3. Ham
4. Pickles
";

$ok_str = "<P>Here is my list:

<OL>
  <LI>Spam
  <LI>Jam
  <LI>Ham
  <LI>Pickles
</OL>
";

$out_str = $conv->process_para($test_str);
ok($out_str, 'converted sample string with list');

# compare the result
is($out_str, $ok_str, 'compare converted list string with OK list string');

# test with is_fragment
$test_str = "Matty had a little truck
he drove it round and round
and everywhere that Matty went
the truck was *always* found.
";

$ok_str = "Matty had a little truck<BR>
he drove it round and round<BR>
and everywhere that Matty went<BR>
the truck was <EM>always</EM> found.
";

$out_str = $conv->process_para($test_str, is_fragment=>1);
ok($out_str, 'converted sample string');

# compare the result
is($out_str, $ok_str, 'compare converted string with OK string');

# test the process_para method with a URL
$test_str = "I like to look at http://www.example.com a lot";

$ok_str = 'I like to look at <A HREF="http://www.example.com">http://www.example.com</A> a lot';

$conv->args(
	system_link_dict=>'txt2html.dict',
	default_link_dict=>'',
	);

$out_str = $conv->process_para($test_str, is_fragment=>1);
ok($out_str, 'converted sample string with list');

# compare the result
is($out_str, $ok_str, 'compare converted list string with OK list string');
