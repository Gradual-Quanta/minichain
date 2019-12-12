#!/usr/bin/perl
# $Name: kwsubsti.pl$
# $Source: /my/perl/script/kwsubsti.pl$

# $Date: 12/10/19$
# $tic: $
# $qm: ~$
# $Previous: QmX5xE7kFDauJRmhS8q8VqX8jLSq73oJuTVURbHZ7i15y8$
#
use YAML::Syck qw(LoadFile);
my $yamlf=shift;
my $yml = LoadFile($yamlf);
my $file=$ARGV[0];

local $/ = undef;
my $buf = <>;
$buf =~ s/\$qm: .*\s*\$/\$qm: ~\$/;
my $qm = 'z'.&encode_base58(pack('H4','01551220').&hashr('SHA256',$buf));
$buf =~ s/\$qm: .*\s*\$/\$qm: $qm\$/;


$buf =~ s/\$tic: .*\s*\$/\$tic: $^T\$/;
foreach my $kw (reverse sort keys %{$yml}) {
 #printf "%s: %s\n",$kw,$yml->{$kw};
 my $KW = $kw; $KW =~ s/.*/\u$&/;
 printf "%s: %s\n",$kw,$yml->{$kw};
 $buf =~ s/\$$KW: .*\s*\$/\$$KW: $yml->{$kw}\$/g;
}

print "buf: ",$buf if $dbug;

local *F;
open F,'>',$file;
print F $buf;
close F;

exit $?;

sub encode_base58 { # btc
  use Math::BigInt;
  use Encode::Base58::BigInt qw();
  my $bin = join'',@_;
  my $bint = Math::BigInt->from_bytes($bin);
  my $h58 = Encode::Base58::BigInt::encode_base58($bint);
  $h58 =~ tr/a-km-zA-HJ-NP-Z/A-HJ-NP-Za-km-z/;
  return $h58;
}
sub hashr {
   my $alg = shift;
   my $rnd = shift; # number of round to run ...
   my $tmp = join('',@_);
   use Crypt::Digest qw();
   my $msg = Crypt::Digest->new($alg) or die $!;
   for (1 .. $rnd) {
      $msg->add($tmp);
      $tmp = $msg->digest();
      $msg->reset;
      #printf "#%d tmp: %s\n",$_,unpack'H*',$tmp;
   }
   return $tmp
}

1;