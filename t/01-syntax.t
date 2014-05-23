BEGIN { @*INC.push: './lib/' }
use Styley::Grammar;
use Styley::Actions;
use Test;

plan 1;

is Styley::Grammar.parse(q:to/STYLE/, :actions(Styley::Actions.new)), q:to/CSS/;
  #abc
  .def
    color: red
    background-color: blue
  STYLE
  #abc {
    color: red;
    background-color: blue;
  }
  CSS