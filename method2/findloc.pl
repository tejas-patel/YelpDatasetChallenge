local $| = 1;
use JSON;
use Data::Dumper;
use Storable;

my %reviews;

open(REVIEW,"../yelp_dataset_challenge_academic_dataset/yelp_academic_dataset_review.json");
while(<REVIEW>){
        chomp;
    
        my $text = decode_json($_);
        $review = $text->{review_id};
        $business = $text->{business_id};
        $reviews{$review}=$business;
        $c=$c+1;
        $per = ($c/1569264)*100;
        printf ("\rReading reviews:%.3f complete (%d/1569264)   ",$per,$c);
}
print("\nBacking up Review:Business information\n"); 
store \%reviews, '../jsonbak/reviewbusiness.bak';

my %business;
$c=0;
open(BUSINESS,"../yelp_dataset_challenge_academic_dataset/yelp_academic_dataset_business.json");
while(<BUSINESS>){
	chomp;
    
	my $text = decode_json($_);
	$bid = $text->{business_id};
	$city = $text->{city};
	$business{$bid}=$city;
	$c=$c+1;
	$per = ($c/61184)*100;
	printf ("\rReading business:%.3f complete (%d/61184)   ",$per,$c);
}
print("\nBacking up Business:City information\n"); 
store \%business, '../jsonbak/business.bak';

