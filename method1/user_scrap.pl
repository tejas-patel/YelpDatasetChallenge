use WWW::Mechanize;

use  Crypt::SSLeay;
use JSON;
use Data::Dumper;

my $mech = WWW::Mechanize->new();


sub crawl{
	my @list;
	my $urlToSpider="https://www.bing.com/?q=".$_[0];
	$mech->get($urlToSpider);
	my @foundLinks = $mech->find_all_links();
	foreach my $linkList(@foundLinks) {
		if($linkList->[0] =~ "yelp\.com/biz"){
			#print "=>$linkList->[0]";
    			#print "\n";
			push @list,$linkList->[0];
		}
	}
	return @list;
}
$b=1;
$e=1000;
$c=0;

my %user_review;
open(REVIEW,"yelp_dataset_challenge_academic_dataset/yelp_academic_dataset_review.json");
open(BACK,">userreview/userlist");

while(<REVIEW>){
	chomp;
	
	my $text = decode_json($_);
	$user = $text->{user_id};
	$review = $text->{review_id};
	push @{ $user_review{$user} },$review;
	$new_review = substr($review, 0, 200);
	$c+=1;
	print("Done:".$c."\n");
	#if($c>10000){
	#	last;
	#}

}

foreach my $key ( keys %user_review){

	my @arr = @{$user_review{$key}};
	print BACK $key;
	for my $val (@arr){
		print BACK " ".$val;

	} 
	print BACK "\n";	
}
