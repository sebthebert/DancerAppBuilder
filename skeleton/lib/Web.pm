package Web;

use Dancer ':syntax';

use Web::Core::JSON;

our $VERSION = '0.1';

get '/' => sub 
{
	template 'index';
};

1;
