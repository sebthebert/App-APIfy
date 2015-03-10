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
	
	my %input = ();
	foreach my $api (@{$config->{api}})
    {
        my $type = $api->{input}->{type};
        $input{$type} = 1;
    }
    foreach my $m (keys %input)
    {
        my $module = "App/APIfy/Input/${m}.pm";
        require $module;
        $module->import()
    }
    my $r = $self->routes;

	$r->get("${API_ROOT}/info")->to('API#info');

	foreach my $api (@{$config->{api}})
	{
		printf "path: %s\n", $api->{path};
			$r->get($API_ROOT . $api->{path} => sub { 
				my $c = shift;

                my $module = "App::APIfy::Input::" . $api->{input}->{type};
				my $data = $module->execute($api->{input});
				
				$c->render(json => $data );
				});
	}
}

1;

=head1 AUTHOR

Sebastien Thebert <stt@onetool.pm>

=cut
