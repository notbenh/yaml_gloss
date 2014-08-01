<dl>
[% FOREACH key IN terms.keys.sort %]
  <dt>[%key%]</dt>
    <dd>[%terms.$key%]</dd>
[% END %]

</dl>
