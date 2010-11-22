package Test::Text::Socialize::Standard;

use Moo;

use Text::Socialize::Machine;
use Text::Socialize::KeywordContainer;
use Text::Socialize::KeywordList;
use Text::Socialize::Information;

has setup => (
	is => 'ro',
	required => 1,
);

has name => (
	is => 'ro',
	required => 1,
);

has _machine => (
	is => 'rw',
);

sub BUILD {
	my ( $self ) = @_;
	my @containers;
	for my $setup_container (@{$self->setup}) {
		my @keywordlists;
		for my $setup_keywordlist (@{$setup_container->{keywordlists}}) {
			push @keywordlists, Text::Socialize::KeywordList->new(
				keywords => $setup_keywordlist,
			);
		}
		my $cnt = 0;
		for (@keywordlists) {
			$cnt++;
			::isa_ok($_,'Text::Socialize::KeywordList','Checking generated '.$cnt.'. KeywordList for proper class of machine '.$self->name);
		}
		delete $setup_container->{keywordlists};
		$setup_container->{keywordlists} = \@keywordlists;
		push @containers, Text::Socialize::KeywordContainer->new($setup_container);
	}
	my $cnt = 0;
	for (@containers) {
		$cnt++;
		::isa_ok($_,'Text::Socialize::KeywordContainer','Checking generated '.$cnt.'. KeywordContainer for proper class of machine '.$self->name);
	}
	$self->_machine(Text::Socialize::Machine->new(
		keywordcontainers => \@containers,
	));
	::isa_ok($self->_machine,'Text::Socialize::Machine','Checking class of generated Machine '.$self->name);
	::is(scalar @{$self->_machine->keywordcontainers},scalar @containers,'Checking right count of KeywordContainer on Machine '.$self->name);
}

sub test_result {
	my ( $self, @tests ) = @_;
	my $cnt = 0;
	for (@tests) {
		my ( $text, $content, $keywords, @submachines ) = @{$_};
		$cnt++;
		my $information;
		if ($content) {
			$information = Text::Socialize::Information->new({
				text => $text,
				content => $content,
			});
			::is($information->text,$text,'Checking Information on '.$cnt.'. for correct text');
			::is($information->content,$content,'Checking Information on '.$cnt.'. for correct content');
		} else {
			$information = Text::Socialize::Information->new({
				text => $_->[0],
			});
			::is($information->text,$text,'Checking Information on '.$cnt.'. for correct text');
			::ok(!$information->has_content,'Checking Information on '.$cnt.'. has no content');
		}
		::isa_ok($information,'Text::Socialize::Information','Checking generated '.$cnt.'. Information for proper class of machine '.$self->name);
		my $result = $self->_machine->analyze_information($information);
		::isa_ok($result,'Text::Socialize::Result','Checking Result on '.$cnt.'. Information for proper class of machine '.$self->name);
		::is_deeply($result->keywords,$keywords,'Checking Result of '.$cnt.'. Information for correct result keywords');
		for (@submachines) {
			my ( $subname, $extradata, $expected_result ) = @{$_};
			my $socialized_result = $self->_machine->socialize_result($subname, $result, $extradata);
			::is_deeply($socialized_result,$expected_result,'Checking Result of '.$cnt.'. Information on submachine '.$subname.' for correct result');
		}
	}
}

1;