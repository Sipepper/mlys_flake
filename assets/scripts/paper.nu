#!/usr/bin/env nu

let text = "
  \\input{preamble.tex}
  \\addbibresource{general.bib}
  \\title{}
  \\begin{document}
  
  \\maketitle
  \\begin{abstract}
    abstract
  \\end{abstract}
  \\vspace{4em}
  % \\pagebreak
  % \\tableofcontents
  % \\pagebreak
  
  \\section{Introduction}
  \\section{Main results}
  	
  \\printbibliography
  \\end{document}
"


def main [name: string] {
  git init $"($name)"
  cd $name 
  mkdir assets
  ln -s ~/.assets/tex/preamble.tex ./preamble.tex
  ln -s ~/.assets/tex/general.bib ./general.bib
  ln -s ~/.assets/tex/listings-rust.sty ./listings-rust.sty
  # echo $text | save $"($name).tex"
  echo $text | save "main.tex"
  
}
