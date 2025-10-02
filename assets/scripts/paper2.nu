#!/usr/bin/env nu

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
	
\\renewcommand*{\\bibfont}{\\footnotesize}
\\printbibliography
\\end{document}
"

def main [
  name: string
  --git
] {
  let repo_name = $"Paper-($name)"
  if $git { gh repo create $repo_name --private --clone } else { mkdir $repo_name}
  cd $repo_name 
  mkdir assets
  cp ~/.assets/tex/listings-rust.sty .
  cp ~/.assets/nu/pack.nu .
  $text | save "main.tex"
  '' | save "additional.bib"
  if $git {
    git add -A 
    git commit -am $"Creation of ($repo_name)"
    git push
  }
}
