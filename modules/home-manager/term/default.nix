{ pkgs, inputs, ... }: {
  imports = [
    ./fish.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    bat
    fzf
    gnupg
    grc
    ranger
    ripgrep
    tree
    neofetch
  ];

  programs = {

    atuin = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      # enableFishIntegration = true; This reports being set twice if done here.
      nix-direnv.enable = true;
    };

    thefuck = {
      enable = true;
      enableFishIntegration = true;
    };

  };
}
