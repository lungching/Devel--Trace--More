#!/usr/bin/perl -d:Trace::More

use strict;
use lib 'Devel-Trace-More/lib';
use Devel::Trace::More qw{ filter_on output_to };
use DateTime;
filter_on(\&filter_on_ref);
output_to("err_stuff.txt");

sub filter_on_ref { my ($p, $file, $line_num, $code_line) = @_; return index($code_line, 'stuff') > -1; } 

print "hello world\n";
my $thing = 'stuff';
my $stuff = 'thing';
$Devel::Trace::More::IS_INTERESTING = sub { my ($p, $file, $line_num, $code_line) = @_; return index($code_line, 'Time') > -1; };
output_to("err_time.txt");
my $a = 1 + 2; 
DateTime->now();
0
