#!/usr/bin/env nu

let text = "
\\documentclass{article}
"


def main [name: string] {
  git init $"($name)"
  cd $name 
  mkdir assets
  ln -s ~/.assets/tex/preamble.tex ./preamble.tex
  ln -s ~/.assets/tex/general.bib ./general.bib
  ln -s ~/.assets/tex/listings-rust.sty ./listings-rust.sty
  echo $text | save $"($name).tex"
  
}
