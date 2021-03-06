#!/usr/bin/perl
# $Source: /my/perl/script/source.pl,v $
# $Previous: /ipfs/QmZRbJUXqA53WcGHdoBrBGYrirjUPJ3jXQhY6bGpKvoScS$
# $tic: 1575654442$

our $dbug=0;
#--------------------------------
# -- Options parsing ...
#
my $yml = 0;
while (@ARGV && $ARGV[0] =~ m/^-/)
{
  $_ = shift;
  #/^-(l|r|i|s)(\d+)/ && (eval "\$$1 = \$2", next);
  if (/^-d(?:e?bug)?/) { $dbug= 1; }
  elsif (/^-y(?:ml)?/) { $yml= 1; }
  else                  { die "Unrecognized switch: $_\n"; }

}
#understand variable=value on the command line...
eval "\$$1='$2'"while $ARGV[0] =~ /^(\w+)=(.*)/ && shift;



my $source;
my $file=shift;
if (-e $file) {
   # extraction of RCS keyword source
   open F,'<',$file;
   while (<F>) {
      if (m/\$[S]ource:\s*([^\$]*?)\s*\$/) {
	 $source = $1;
	 $source =~ s/,v$//;
      } else {
	 chomp;
	 printf "dbug: %s\n",$_ if $dbug;
      }
   }
   close F;
   if (! defined $source) {
      if ($file =~ m{^/.*/([^/]+)/([^/]+)/?$}) {
	 $source = $1.'/'.$2;
      } else {
	 use Cwd qw(cwd);
	 cwd() =~ m{/([^/]+)/?$};
	 $source = '/uploaded/'.$1.'/'.$file;
      }
   }

} else {
  $source=$file||'/from/the/ultimate/divine/source/empty_file.blob,v';
}

if ($yml) {
printf "source: %s\n",$source;
} else {
print $source;
}

exit $?;
1;
