package Devel::Trace::More;

use 5.010000;
use strict;
use warnings;

use Exporter;

use base 'Exporter';
our @EXPORT_OK = qw{ trace filter_on };

our $VERSION = '0.01_01';

our $IS_INTERESTING = sub { return 1; };
our $TRACE = 1;

# This is the important part.  The rest is just fluff.
sub DB::DB {
  return unless $TRACE;
  my ($p, $f, $l) = caller;

  # have no idea how to do this with strict
  no strict 'refs';
  my $code = \@{"::_<$f"};
  use strict 'refs';

  print STDERR ">> $f:$l: $code->[$l]" if $IS_INTERESTING->($f, $code->[$l]);
}

sub filter_on {
    my $filter = shift;

    if (! ref($filter)) {
        $filter = qr/$filter/;
    }

    $IS_INTERESTING = sub { my ($f, $l) = @_; return $f =~ $filter || $l =~ $filter; } if ref($filter) eq 'Regexp';
}

my %tracearg = ('on' => 1, 'off' => 0);
sub trace {
  my $arg = shift;
  $arg = $tracearg{$arg} while exists $tracearg{$arg};
  $TRACE = $arg;
}

1;
__END__

=head1 NAME

Devel::Trace::More - Like Devel::Trace but with more control

=head1 SYNOPSIS

  #!/usr/bin/perl -d:Trace::More

  use Devel::Trace::More qw{ filter_on };
  
  filter_on('blah');

  # or

  filter_on(qr/blah/);

=head1 DESCRIPTION

For now look at documentation for L<Devel::Trace>.
More features to come!


=head1 SEE ALSO

L<Devel::Trace>

=head1 AUTHOR

mburns, E<lt>mburns.lungching@gmail.comE<gt>

Also code from Mark Jason Dominus

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Mike Burns

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
