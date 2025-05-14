def main [path] {
  sudo nixos-rebuild switch --flake $"($path)/mlys_flake#default"
}
