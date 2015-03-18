use strict;
use warnings;

use feature 'say';

use WWW::Mechanize::Firefox;
use HTML::TreeBuilder::XPath;

#my $url = 'http://www.imdb.com/find?q=Yek+mard%2C+yek+khers&s=all';
my $url = "http://www.yelp.com/biz/selden-standard-detroit";
print "New Mechanize\n";
my $mech = WWW::Mechanize::Firefox->new;
print "Getting url\n";
$mech->get($url);

print "Getting url\n";
$mech->get($url);
#my $tree = HTML::TreeBuilder::XPath->new_from_content($mech->response->content);
