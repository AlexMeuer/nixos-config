{ pkgs, ... }: {
  xdg.configFile."nvim/init.lua".source = ./config/init.lua;
  xdg.configFile."nvim/lua".source = ./config/lua;
}
