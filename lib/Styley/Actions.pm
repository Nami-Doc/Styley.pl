class Styley::Actions;

class RootProperty is Exception {}

class Node {}; # { ... };

class Property is Node {
	has Str $.property;
	has Str $.value;
}

class Selector is Node {
	has Str @.queries;
	has Node @.nodes;
}

enum LexingState <Selector Property>;

method TOP($/) {
	# $/.made is a suite
	return unless +$/.made;

	self!parse: @($/.made.items);
}

method !parse(@items) {
	my Selector @selectors;
	my Str @queries;
	my Node @nodes;
	my LexingState $state = Selector;
	for @items {
		when Str {
			if $state == Selector {
				@queries.push: $_;
				next;
			} else {
				my $selector = Selector.new(:@queries, :@nodes);
				say $selector.perl;
				next;
			}
		}

		$state = Property if $state == Selector;
		#@nodes.push: self!parse: @($_.items);
		say @(.items).list.perl;
		say self!parse(@($_.items)).perl;
	}

	(@selectors, Selector.new(:@queries, :@nodes))
}