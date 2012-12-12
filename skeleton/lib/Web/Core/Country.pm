=head1 NAME

Web::Core::Country

=head1 SYNOPSIS

    use Web::Core::Country;
    my $countries = Web::Core::Country::CountryNames;
    my $country_name = Web::Core::Country::CountryName($iso_code);

=cut

package Web::Core::Country;

use strict;
use warnings;

use FindBin;

use lib "$FindBin::Bin/../lib/";

use Web::Core::I18N;

# http://www.iso.org/iso/en/prods-services/iso3166ma/02iso-3166-code-lists/list-en1-semic.txt
my @COUNTRY_CODES = qw(
  ad ae af ag ai al am an ao aq ar as at au aw ax az
  ba bb bd be bf bg bh bi bj bl bm bn bo br bs bt bv bw by bz
  ca cc cd cf cg ch ci ck cl cm cn co cr cu cv cx cy cz
  de dj dk dm do dz
  ec ee eg eh er es et
  fi fj fk fm fo fr
  ga gb gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy
  hk hm hn hr ht hu
  id ie il im in io iq ir is it
  je jm jo jp
  ke kg kh ki km kn kp kr kw ky kz
  la lb lc li lk lr ls lt lu lv ly
  ma mc md me mf mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz
  na nc ne nf ng ni nl no np nr nu nz
  om
  pa pe pf pg ph pk pl pm pn pr ps pt pw py
  qa
  re ro rs ru rw
  sa sb sc sd se sg sh si sj sk sl sm sn so sr st sv sy sz
  tc td tf tg th tj tk tl tm tn to tr tt tv tw tz
  ua ug um us uy uz
  va vc ve vg vi vn vu
  wf ws
  ye yt
  za zm zw
);

my %Cache;

# Act::Util::usort { $_->{name} }

=head1 FUNCTIONS

=head2 CountryNames($language)

=cut

sub CountryNames
{
	my $language = shift;
	
    my $lh = Web::Core::I18N->get_handle($language);
    return $Cache{$language} ||=
     [
      map {{ iso => $_, name => $lh->maketext("country_$_") }}
      @COUNTRY_CODES
     ];
}

=head2 CountryNames($language, $code)

=cut

sub CountryName
{
	my ($language, $code) = @_;

   	my $lh = Web::Core::I18N->get_handle($language);
   	
	return $lh->maketext("country_$code") || $code;
}

1;

=head1 AUTHOR

Sebastien Thebert <stt@ittool.org>

=cut
