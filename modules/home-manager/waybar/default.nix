{ pkg, inputs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "mpd"
          "disk"
          "memory"
          "cpu"
          "privacy"
          "wireplumber"
          "clock"
        ];

       "hyprland/workspaces" = {
          persistent-workspaces = { "*" = 6; };
          show-special = true;
          format = ''{icon} <span font="12" rise="-8">{windows}</span>'';
          window-rewrite-default = "";
          window-rewrite = {
            "title<.*youtube.*>" = "󰗃";
            "class<firefox>" = "";
            "class<firefox> title<.*github.*>" = "";
            "fish" = "";
            "class<kitty>" = "";
            "class<kitty> title<nvim.*>" = "";
	    "spotify" = "󰓇";
	    "steam" = "󰓓";
	    "discord" = "󰙯";
          };
        };
      };
    };
    style = builtins.readFile ./style.css;
  };
}
