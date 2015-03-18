use WWW::Mechanize;
local $| = 1;
use Crypt::SSLeay;
use JSON;
use Data::Dumper;
use Storable;
use HTML::TreeBuilder;
use LWP::Simple;
  

my $urlToSpider="http://www.yelp.com/biz/selden-standard-detroit";

print $content;
sub parseYelpBusiness{
	my $urlToSpider="http://www.yelp.com/biz/selden-standard-detroit";
	my $html = get $urlToSpider;
	$tree = HTML::TreeBuilder->new;
	$root = HTML::TreeBuilder->new_from_url($urlToSpider);
	#print $root->as_HTML;
	print $html;
	#$tree->parse($html);
	#print $tree->as_HTML;
	#@reviews = $tree->find_by_attribute("class","ylist ylist-bordered reviews");
	#print $reviews[0]->as_text;
	#@list = $reviews[0]->content_list();
	#print "SIZE:".scalar(@list)."\n";
	#foreach (@reviews){
	#	print $_->as_HTML;
		#@loc= $_->look_down('class','user-location');
		#print $loc[0]->as_text."\n";
	#}
}

&parseYelpBusiness;
