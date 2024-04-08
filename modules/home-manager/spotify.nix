{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];
  programs.spicetify =
    {
      enable = true;
      # theme = spicePkgs.themes.Onepunch;
      theme = spicePkgs.themes.RetroBlur;

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
	playNext
      ];
    };
}
