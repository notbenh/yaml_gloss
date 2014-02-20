#!/usr/bin/env perl
use strict;
use warnings;
use Template;
use YAML qw{LoadFile};
use Data::Dumper; sub D(@){warn Dumper(@_)};

die "USEAGE: $0 yaml_file" unless @ARGV;

my $data = LoadFile(shift @ARGV);

my $template = <<END;
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<p>NOTE: order is done by sort, if natural order from file is intended then move to an array</p>

<dl>
[% FOREACH key IN terms.keys.sort %]
  <dt><a name='[%key%]'>[%key%]</a></dt>
    <dd>[%terms.\$key%]</dd>
[% END %]

</dl>

</body>
</html>
END

Template->new()->process(\$template,{terms=>$data});
