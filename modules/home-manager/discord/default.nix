{ pkgs, ... }:
{
  home.file.".config/vesktop/themes/gruvbox.css".source = ./gruvbox.css;
  home.file.".config/vesktop/settings/settings.json".source = ./settings.json;
  home.packages = [ pkgs.vesktop ];
}
