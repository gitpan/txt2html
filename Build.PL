
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0,
    "warnings" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "convert plain text file to HTML.",
  "dist_author" => [
    "Kathryn Andersen <perlkat\@katspace.org>"
  ],
  "dist_name" => "txt2html",
  "dist_version" => "2.52",
  "license" => "gpl",
  "module_name" => "txt2html",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "File::Basename" => 0,
    "Getopt::Long" => 0,
    "Pod::Usage" => 0,
    "YAML::Syck" => 0,
    "constant" => 0,
    "perl" => "5.8.1",
    "strict" => 0
  },
  "script_files" => [
    "scripts/txt2html"
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
