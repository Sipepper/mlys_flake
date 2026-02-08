{ ... }:
{
  imports = [
    ./default.nix
  ];

  home.file = {
    "Git/.readme.md" = {
      text = "Primary folder for git repos.";
    };
    "Rust/.readme.md" = {
      text = "Primary folder for programming projects.";
    };
    "Games/.readme.md" = {
      text = "Primary folder for games outside of Steam.";
    };
    "Books/.readme.md" = {
      text = "Primary folder for books, i.e. **The Library**.";
    };
    "Work/.readme.md" = {
      text = "Primary folder for non-math work.";
    };
    "Documents/.readme.md" = {
      text = "Primary folder for legal and other documents.";
    };
    "LaTeX/.readme.md" = {
      text = "Primary folder for math papers projects.";
    };


    ".assets/tex/preamble.tex" = {
      source = ./assets/tex/preamble.tex;
    };
    ".assets/tex/general.bib" = {
      source = ./assets/tex/bib.bib;
    };
    ".assets/nu/pack.nu" = {
      source = ./assets/scripts/pack.nu;
    };

  };

}
