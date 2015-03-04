use WWW::Mechanize;
local $| = 1;
use Crypt::SSLeay;
use JSON;
use Data::Dumper;
use Storable;
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

my %reviews;
open(USER,"userreview/userlist");
open(REVIEW,"yelp_dataset_challenge_academic_dataset/yelp_academic_dataset_review.json");
while(<REVIEW>){
	chomp;
	
	my $text = decode_json($_);
	$review = $text->{review_id};
	$review_text = $text->{text};
	$reviews{$review}=$review_text;
	$c=$c+1;
	$per = ($c/1569264)*100;
	printf ("\rReading reviews:%.3f complete (%d/1569264)   ",$per,$c);
}

print("\nStoring reviews in file for future reference\n");
store \%reviews, 'review.bak';

print("\nReading user data...\n");
my %users;
while(<USER>){
	chomp;
	@list = split(" ",$_);
	$id = shift(@list);
	#print $id." ".join(" ",@list)."\n";
	$users{$id}=join(" ",@list);
}

print("\nStoring users in file for future reference\n");
store \%users, 'user.bak';
