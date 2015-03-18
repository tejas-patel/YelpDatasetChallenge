use WWW::Mechanize;
local $| = 1;
use Crypt::SSLeay;
use JSON;
use Data::Dumper;
use Storable;
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
$b=363001;
$e=364000;
$c=363001;

print("Reading reviews...\n");
my %review = %{retrieve('../jsonbak/review.bak')};

print("Reading users...\n");
my %user = %{retrieve('../jsonbak/user.bak')};
$json = JSON->new->allow_nonref;
$json = $json->relaxed([$enable]);
open(UNS, ">>uns2");
while(1){
	print("Begining for file:"."../users/".$b."_".$e."\n");
	open(USER, "../users/".$b."_".$e);
	open(USER_SCRAP, ">../scrap_user/".$b."_".$e);

	if(tell(USER)==-1){
        	last;
	}
	$d=0;
	while(<USER>){
		chomp;
		#print $_."\n";
		my $text = $json->decode($_);
		$user_id=$text->{user_id};
		
		if(exists $user{$user_id}){
			@user_review = split(" ",$user{$user_id});
			$f=0;
			for my $ur (@user_review){
				$new_review = substr($review{$ur}, 0, 200);
				my @list = &crawl($new_review);
   
	             		#$url="";
                		#foreach(@list){
                        	#	$url=$url." ".$_;
               			#}
				$url =join(" ",@list);	   
                		if(scalar(@list)!=0){
                			print " $c Found ".scalar(@list)." possible links for review_id:".$ur." and user:".$user_id."\n";
					print USER_SCRAP $user_id." ".$ur." ".$url."\n";	
                			$f=1;
					last;
				}   
			}
			if($f==0){
				print "All reviews unsuccessful for user:".$user_id."\n";
				print UNS $user_id."\n";
				$d+=1;
			}
		}	
		else{
			print "Not found for:".$user_id."\n";
		}
		$c+=1;
	}
	print "Completed extraction for file:"."users/".$b."_".$e." There were ".$d." unsuccessful searches"."\n";
	printf "Completed %.3f\n",($c/366714)*100; 
	$b+=1000;
	$e+=1000;
}
