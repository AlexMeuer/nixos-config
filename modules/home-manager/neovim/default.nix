{ pkgs, ... }: {
  xdg.configFile."nvim/init.lua".source = ./config/init.lua;
  xdg.configFile."nvim/lua".source = ./config/lua;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
  };

  home.packages = with pkgs; [
    go
    cargo
    unzip
  ];
}
