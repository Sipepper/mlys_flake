
let preamble = "/home/mlys/.assets/tex/preamble.tex";
let bib = "/home/mlys/.assets/tex/general.bib";
let listings = "/home/mlys/.assets/tex/listings-rust.sty"

def main [] {
  mv main.tex main_old.tex
  cp main_old.tex main.tex
  sed -i "2s|{[^}]*}|{preamble.tex}|g" main.tex
  sed -i "3s|{[^}]*}|{general.bib}|g" main.tex
  ouch compress -S assets $preamble $bib $listings "main.tex" "main.pdf" "additional.bib" $"mlys-(date now | format date "%Y-%m-%d").zip"  
  rm main.tex
  mv main_old.tex main.tex
}
