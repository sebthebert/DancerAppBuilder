=head1 NAME

Web::Core::I18N - internationalization class

=head1 SYNOPSIS

  # In a handler, get a translated string
  use Act::Util;
  my $xlated = localize('string');
  
  ### low-level access
  use Core::I18N;
  
  # Get a localization handle
  $lh = Core::I18N->get_handle('en');
  
  # Get a translated string
  my $xlated = $lh->maketext('(a string to translate)');

=head1 DESCRIPTION

Web::Core::I18N provides the interface for internationalisation, and how different localizations are implemented.

=cut

package Web::Core::I18N;

use strict;
use warnings;

use File::Spec::Functions qw(catfile);
use FindBin;
use base qw(Locale::Maketext);
use Locale::Maketext::Lexicon;

unless ($^C) {
    Locale::Maketext::Lexicon->import({
        '*' => [ Gettext => catfile("$FindBin::Bin/../", 'po', '*.[pm]o'),
                 Gettext => catfile("$FindBin::Bin/../", 'po', '*', '*.[pm]o'),
               ],
        _auto   => 0,
        _decode => 1,
        _style  => 'gettext',
    });
}

sub init
{
    my $self = shift;
    $self->SUPER::init();
    $self->fail_with('failure_handler');
}

sub failure_handler
{
    my ($self, $key, @params) = @_;

    # look up in the default_language lexicon,
    # then in the superordinate (if variant, e.g; en_US => en)
    # then in the English lexicon,
    # avoiding infinite recursion
    my $lang = $self->language_tag();
    if ($lang ne 'en') {
        my @fallbacks = ('en'); #($Config->general_default_language, 'en');
        if ($lang =~ /^((\w+)[-_].+)$/) {    # $1 = en_US, $2 = en
            unshift @fallbacks, $2;
        }
        for my $fallback (@fallbacks) {
            if ($lang ne $fallback) {
                return Act::I18N->get_handle($fallback)->maketext($key, @params);
            }
        }
    }
    return 'TRANSLATEME';
}

#### language specific behavior

package Web::Core::I18N::fr;

# zero is singular in French
sub numerate
{
    my ($handle, $num, @forms) = @_;
    my $s = ($num < 2);
    
    return '' unless @forms;
    if (@forms == 1) {
        # only the headword form specified
        return $s ? $forms[0] : ($forms[0] . 's'); # very cheap hack.
    }
    # sing and plural were specified
    return $s ? $forms[0] : $forms[1];
}

package Web::Core::I18N::ru;

# Russian/Belarusian declensions for numerals.
# usage: numerate(num, nominative, genitive,   plural);
# or:    numerate(num, form for 1, form for 2, form for 5);
sub numerate
{
   my ($handle, $num, $nominative, $genitive, $plural) = @_;

   return $plural if $num =~ /1.$/;

   my ($last_digit) = $num =~ /(.)$/;

   return $nominative if $last_digit == 1;
   return $genitive if $last_digit > 0 && $last_digit < 5;
   return $plural;
}

package Web::Core::I18N::be;
*numerate = \&Core::I18N::ru::numerate;

1;

=head1 AUTHOR

Sebastien Thebert <stt@ittool.org>

=cut
