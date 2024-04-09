{ pkgs, ... }: {
  services = {
    mako = {
      enable = true;
      defaultTimeout = 60;
      width = 600;
      font = "Hack Nerd Font Mono 10";
      textColor = "#d4be98";
      borderColor = "#8ec07c";
      backgroundColor = "#282828";
      borderRadius = 8;
      borderSize = 2;
      extraConfig = ''
        [urgency=low]
        border-color=#689d6a
        [urgency=critical]
        border-color=#fb4934
        text-color=#fbf1c7
      '';
    };
  };
}
