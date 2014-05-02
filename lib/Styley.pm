module Styley;

use Styley::Grammar;

sub parse(Str $code, @vars --> Callable) {
	my $actions = Styley::Actions.new();
	my $parse = Styley::Grammar.parse($code, :$actions);
	return $parse.ast;
}