#!/usr/bin/env perl
use strict;
use warnings;
use Template;
use YAML qw{LoadFile};
use Data::Dumper; sub D(@){warn Dumper(@_)};

die "USEAGE: $0 yaml_file" unless @ARGV;
sub ANCHOR($){ local $_ = $_[0]; s|\b([A-Z][A-Z ]*[A-Z])|<a href='#$1' name='$1'>$1</a>|g; $_}

my $data = { map{ANCHOR $_} %{ LoadFile(shift @ARGV) } };

my $template = <<END;
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<p>NOTE: order is done by sort, if natural order from file is intended then move to an array</p>

<dl>
[% FOREACH key IN terms.keys.sort %]
  <dt>[%key%]</dt>
    <dd>[%terms.\$key%]</dd>
[% END %]

</dl>

</body>
</html>
END

Template->new()->process(\$template,{terms=>$data});
