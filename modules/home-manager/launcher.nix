{ pkgs, ... }: {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "gruvbox-dark-soft";
      font = "Hack Nerd Font Mono 14";
      plugins = [
        pkgs.rofi-calc
      ];
    };
}
