=head1 NAME

Web::Core::JSON

=cut

package Web::Core::JSON;

use Dancer ':syntax';
use FindBin;

use lib "$FindBin::Bin/../lib";
 
use Web::Core::Country;
use Web::Core::JSON::Validation;
use Web::Core::Language;

set serializer => 'JSON';

prefix '/JSON';

=head1 ROUTES

=head2 GET /JSON/country/list

=cut

get '/country/list' => sub
{
	my $countries = Web::Core::Country::CountryNames('fr');

	return ($countries);
};

=head2 GET /JSON/language/list

=cut

get '/language/list' => sub
{
    my $languages = Web::Core::Language::Names();
	my @data = ();
	foreach my $l (keys %{$languages})
	{
		push @data, { name => $languages->{$l}, code => $l };
	}

    return (\@data);
};

1;

=head1 AUTHOR

Sebastien Thebert <stt@ittool.org>

=cut
