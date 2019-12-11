#!/usr/bin/perl

my %seen = ();
local $/ = "\n";
while (<>) {
   if ($_ =~ /^$/) {
      print "\n";
   } else {
      print $_ unless $seen{$_}++;
   }
}
exit $?;
1;

