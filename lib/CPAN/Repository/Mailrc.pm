package CPAN::Repository::Mailrc;
BEGIN {
  $CPAN::Repository::Mailrc::AUTHORITY = 'cpan:GETTY';
}
{
  $CPAN::Repository::Mailrc::VERSION = '0.006';
}
# ABSTRACT: 01mailrc

use Moo;

with qw(
	CPAN::Repository::Role::File
);

sub file_parts { 'authors', '01mailrc.txt' }

has aliases => (
	is => 'ro',
	lazy => 1,
	builder => '_build_aliases',
);

sub _build_aliases {
	my ( $self ) = @_;
	return {} unless $self->exist;
	my @lines = $self->get_file_lines;
	my %aliases;
	for (@lines) {
		if ($_ =~ m/^alias (\w+) "(.*)"$/) {
			$aliases{$1} = $2;
		}
	}
	return \%aliases;
}

sub set_alias {
	my ( $self, $author, $alias ) = @_;
	$self->aliases->{$author} = $alias;
	return $self;
}

sub generate_content {
	my ( $self ) = @_;
	my $content = "";
	for (sort keys %{$self->aliases}) {
		$content .= 'alias '.$_.' "'.( $self->aliases->{$_} ? $self->aliases->{$_} : $_ ).'"'."\n";
	}
	return $content;
}

1;



__END__
=pod

=head1 NAME

CPAN::Repository::Mailrc - 01mailrc

=head1 VERSION

version 0.006

=head1 SYNOPSIS

  use CPAN::Repository::Mailrc;

  my $mailrc = CPAN::Repository::Mailrc->new({
    repository_root => $fullpath_to_root,
  });

=encoding utf8

=head1 SEE ALSO

L<CPAN::Repository>

=head1 SUPPORT

IRC

  Join #duckduckgo on irc.freenode.net. Highlight Getty for fast reaction :).

Repository

  http://github.com/Getty/p5-cpan-repository
  Pull request and additional contributors are welcome

Issue Tracker

  http://github.com/Getty/p5-cpan-repository/issues

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<http://raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by DuckDuckGo, Inc. L<http://duckduckgo.com/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

