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
      enableFishIntegration = programs.fish.enable;
    };

    thefuck = {
      enable = true;
      enableFishIntegration = programs.fish.enable;
    };

  };
}
