use strict;
use warnings;
use Test::More;

use FindBin qw($Bin);
use lib "$Bin/lib";

use Test::Text::Socialize::Standard;

my $machine = Test::Text::Socialize::Standard->new(
	name => 'Simple',
	setup => [{
		keywordlists => [
			['Perl','YAPC::\w\w \d\d\d\d|YAPC'],
			['Linux','Microsoft'],
		],
	},{
		keywordlists => [
			['London','Ice'],
			['Beer','Peter Parker'],
		],
	}]
);

$machine->test_result([
	'Perl YAPC Linux London Ice Beer',
	undef,
	['Perl','Linux','YAPC','London','Beer','Ice'],
	['Twitter',{
		url => 'http://www.perl.org/',
		hashtags_at_end => 1,
	},'Perl YAPC Linux London Ice Beer http://www.perl.org/ #perl #linux #yapc #london #beer #ice'],
],[
	'Peter Parker uses Perl on London at YAPC::EU 2010',
	'Lalala More Beer on Ice',
	['Perl','YAPC::EU 2010','London','Beer','Ice','Peter Parker'],
	['Twitter',{
		url => 'http://www.perl.org/verylong/verylong/verylong/verylong/verylong/',
		hashtags_at_end => 1,
	},'Peter Parker uses Perl on London at YAPC::EU 2010 http://www.perl.org/verylong/verylong/verylong/verylong/verylong/ #perl #yapceu2010 #beer'],
],[
	'Perl Perl Perl Perl Perl',
	'Lalala More Beer!!!',
	['Perl','Beer']
]);

done_testing;
