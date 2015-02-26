package App::APIfy;

=head1 NAME

App::APIfy

=cut

use Mojo::Base 'Mojolicious';

my $API_ROOT = '/api';

=head1 METHODS

=head2 startup()

=cut

sub startup 
{
	my $self = shift;

	my $config = $self->plugin('JSONConfig', 
	   { file => "$FindBin::Bin/../conf/apify.json" });

	# Router
    my $r = $self->routes;

	foreach my $api (@{$config->{api}})
	{
		printf "path: %s\n", $api->{path};
		if (defined $api->{command})
		{
			$r->get($API_ROOT . $api->{path} => sub { 
				my $c = shift;
				my $command_output = `$api->{command}`;
				$command_output =~ /$api->{command_output_regex}/;
				my $str = '';
				foreach my $k (keys %+)
				{
					$str .= "$k $+{$k} "
				}	
  				$c->render(text => "$api->{path} ($api->{command}) => $str" );
				});
		}
	}
}

1;

=head1 AUTHOR

Sebastien Thebert <stt@onetool.pm>

=cut
