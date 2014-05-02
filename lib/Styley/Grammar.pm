grammar Styley::Grammar;
is Text::Indented;

# there's probably a better way ...
my $tabstop;
our sub set-tabstop($stop)
{
	$tabstop = $stop;
}

regex line {
    ^^ (<{ "\\x20" x $tabstop }>*) (\h*) (\N*) $$ \n?

    {
    	# TODO ask @masak to expose a public API
    	check_indent
    }
}