package App::APIfy::API;

=head1 NAME

App::APIfy::API

=cut

use Mojo::Base 'Mojolicious::Controller';

=head2 METHODS

=head2 info()

=cut

sub info
{
    my $self = shift;

	my $str = '';
	foreach my $route (@{$self->app->routes->children})
	{
		$str .= $route->name . ' - ' . $route->pattern
	}

    $self->render(text => $str);
}

1;

=head1 AUTHOR

Sebastien Thebert <stt@onetool.pm>

=cut
