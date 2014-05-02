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
		check_indent($0, $1)

		# do something with $1
		# ... or try to
		if same-indent() {
			if is-selector($1) {
				@*selectors.push: $1.split(',')>>trim;
			} else {
				@*attributes.push: $1 # should've been `made`
			}
		}
	}
}

regex ident {
	[ <[a..z A..Z _ -]> + % <[_ -]> ]
}

regex variable { :i
	'$' <.ident>
}

rule attribute:sym<attr> {
	<attr-name> ':' <value>
}

rule attribute:sym<call> {
	<function-name=.ident>
	'(' ~ ')'
	[ <attribute> * % ',' ]
}


regex value:sym<literal> { <.ident> }
regex value:sym<doubleq-string> {
	'"' ~ '"'
	<-["]> +
}
regex value:sym<simpleq-string> {
	"'" ~ "'"
	<-[']> +
}