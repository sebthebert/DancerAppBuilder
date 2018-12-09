# DancerAppBuilder

Builds a Dancer Application with:

* Bootstrap - http://twitter.github.com/bootstrap/
* Font Awesome - http://fortawesome.github.com/Font-Awesome

The template engine configured will be Template Toolkit.

Template Toolkit will be configured to use 'utf8' as encoding and '[%' and '%]' as opening/closing tags.

## Skeleton of the Dancer Application

### Minimal Skeleton

```shell
bin/web.pl

lib/Web.pm
lib/Web/Core/Country.pm
lib/Web/Core/I18N.pm
lib/Web/Core/JSON.pm
lib/Web/Core/JSON/Validation.pm
lib/Web/Core/Language.pm

public/css/bootstrap.min.css  
public/css/bootstrap-responsive.min.css  
public/css/font-awesome.css

public/font/fontawesome-webfont.eot
public/font/fontawesome-webfont.svg
public/font/fontawesome-webfont.ttf
public/font/fontawesome-webfont.woff

public/js/bootstrap.min.js
public/js/jquery.min.js
public/js/highcharts.js

t/

views/core/bootstrap/menu_top.tt
views/core/form/input_account_facebook.tt
views/core/form/input_account_github.tt
views/core/form/input_account_googleplus.tt
views/core/form/input_account_linkedin.tt
views/core/form/input_account_pinterest.tt
views/core/form/input_account_twitter.tt
views/core/form/input_email.tt
views/core/form/input_password.tt
views/core/form/input_phone.tt
views/core/form/input_port.tt
views/core/form/select_country.tt
views/core/form/select_language.tt
views/core/chart_pie.tt
views/core/homepage.tt
views/core/message.tt
views/core/navigation.tt
views/index.tt
views/layouts/default_page.tt
views/layouts/default_page_footer.tt
views/layouts/default_page_header.tt
```