=head1 NAME

Web::Core::JSON::Validation

=cut

package Web::Core::JSON::Validation;

use Dancer ':syntax';
use FindBin;

set serializer => 'JSON';

prefix '/JSON/validation';

=head1 ROUTES

=head2 GET /JSON/validation/email/:email

=cut

get '/email/:email' => sub
{
    my $email = params->{'email'};

	if ($email !~ /^(\S+)@(\S+)(\.(\S+))+$/)
	{
		return ( { level => 'error', msg => 'email should be like someone@domain.com' } );
	}

	return ( { level => 'success', msg => 'email like someone@domain.com' } );
};

=head2 GET /JSON/validation/password/:password

=cut

get '/password/:password' => sub
{
	my $password = params->{'password'};

    if (length($password) < 6)
    {
        return ( { level => 'error', msg => 'length < 6' } );
    }
    elsif (length($password) < 8)
    {
        return ( { level => 'warning', msg => 'length < 8' } );
    }
    else
    {
        return ( { level => 'success', msg => 'length >= 8' } );
    }
};

=head2 GET /JSON/validation/phone/:phone

=cut

get '/phone/:phone' => sub
{
    my $phone = params->{'phone'};
	$phone =~ s/ //g;

	if ($phone !~ /^\+\d\d\d{9}|\d{10}$/)
	{
		return ( { level => 'error', msg => 'Invalid phone number !' } );
	}

	return ( { level => 'success', msg => 'Valid phone number' } );
};

=head2 GET /JSON/validation/port/:port

=cut

get '/port/:port' => sub
{
    my $port = params->{'port'};
   
    if (($port =~ /^\d+$/) && ($port >= 0) && ($port <= 65535))
    {
        return ( { level => 'success', msg => 'Valid port number !' } );
    }

    return ( { level => 'error', msg => 'Invalid port number ! (should be between 0 and 65535)' } );
};

1;

=head1 AUTHOR

Sebastien Thebert <stt@ittool.org>

=cut
