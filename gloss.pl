#!/usr/bin/env perl
use strict;
use warnings;
use Template;
use YAML qw{LoadFile};

my $template = shift or warn 'No template file found';
warn 'No input files found' unless @ARGV;
die "USEAGE: $0 template yaml_file(s)" unless @ARGV;

sub ANCHOR($){ local $_ = $_[0]; s|\b([A-Z][A-Z ]*[A-Z])|<a href='#$1' name='$1'>$1</a>|g; $_}

my $data = { map{ANCHOR $_} %{ LoadFile(shift @ARGV) } };

my $t = Template->new({RELATIVE=>1});
$t->process($template,{terms=>$data})
  || die $t->error(), "\n";
