package App::APIfy::Input::Command;

=head1 NAME

App::APIfy::Input::Command

=cut

sub execute
{
	 my ($self, $conf) = @_;
                
	my $command_output = `$conf->{command}`;
   	$command_output =~ /$conf->{command_output_regex}/;
	my %data = ();
	%data = %+;

	return (\%data);
}

1;

=head1 AUTHOR

Sebastien Thebert <stt@onetool.pm>

=cut
