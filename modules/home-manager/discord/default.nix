{ pkgs, ... }:
{
  home.file.".config/vesktop/themes/gruvbox.css".source = ./gruvbox.css;
  home.packages = [ pkgs.vesktop ];
}
