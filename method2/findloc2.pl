local $| = 1;
use JSON;
use Data::Dumper;
use Storable;

print("Reading reviews...\n");
my %review = %{retrieve('../jsonbak/reviewbusiness.bak')};

print("Reading users...\n");
my %user = %{retrieve('../jsonbak/user.bak')};

print("Reading business...\n");
my %business = %{retrieve('../jsonbak/business.bak')};

my %usercity;
print("Getting Location information for reviews...\n");
foreach my $key (keys %user){

	@reviewlist = split(" ",$user{$key});
	for my $rid (@reviewlist){
		$usercity{$key}{$business{$review{$rid}}}++;
	}

}

foreach my $uid (keys %usercity) {
    $max=0;

    foreach my $city (keys %{ $usercity{$uid} }) {
        #print "$uid, $city: $usercity{$uid}{$city}\n";
    	if($usercity{$uid}{$city} > $max){
		$maxcity=$city;
		$max=$usercity{$uid}{$city};
	}
	
    }
    $allcity = join(" ",keys %{ $usercity{$uid} });
    foreach my $city (keys %{ $usercity{$uid} }) {
        #print "$uid, $city: $usercity{$uid}{$city}\n";
        if($usercity{$uid}{$city} == $max && $maxcity ne $city ){
                $maxcity=$maxcity." ".$city;
        }   
    }
    print $uid." ".$maxcity." ".$max." ".$allcity."\n";
}


