use Styley::Grammar;

say Styley::Grammar.parse(qq:to/STYLE/).ast;
#abc
  .abc
    color: red
STYLE
