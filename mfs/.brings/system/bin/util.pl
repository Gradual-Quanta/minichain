#!/usr/bin/env perl
BEGIN { our $brsdir = (__FILE__ =~ m{(.*+)/}) ? $1 : '..'; }
# $Source: /my/perl/script/util.pl$

use lib $brsdir.'/lib';
use UTIL qw(version);

our $dbug=0;
#understand variable=value on the command line...
eval "\$$1='$2'"while $ARGV[0] =~ /^(\w+)=(.*)/ && shift;
printf "@INC: (%s)\n",join(', ',@INC) if $dbug;

printf "%s: %s\n",__FILE__,&version($0);
exit $?;

1;

