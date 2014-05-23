BEGIN { @*INC.push: './lib/' } # until masak++'s lib is on panda
use Text::Indented;

grammar Styley::Grammar;
also is Text::Indented;

# TODO(tm)
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