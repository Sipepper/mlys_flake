#!/usr/bin/env nu

let preamble_location = "/home/mlys/.assets/tex/preamble.tex"
let bib_location = "/home/mlys/.assets/tex/preamble.tex"

let text = "
\\input{/home/mlys/.assets/tex/preamble.tex}
\\addbibresource{/home/mlys/.assets/tex/general.bib}
\\addbibresource{additional.bib}
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

let gitignore = "
main.pdf
main.blg
main.log
main.synctex.gz
"

def main [name: string] {
  let repo_name = $"Paper | ($name)"
  gh repo create $repo_name --private --clone -g $gitignore
  cd $repo_name 
  mkdir assets
  ~/.assets/tex/listings-rust.sty | save "listings-rust.sty"
  $text | save "main.tex"
  '' | save "additional.bib"
  git add -A 
  git commit -am $"Creation of ($repo_name)"
  git push
}
