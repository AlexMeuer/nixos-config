{ pkg, inputs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyperland/window" ];
        modules-right = [
          "mpd"
          "mpris"
          "temperature"
          "disk"
          "memory"
          "cpu"
          "privacy"
          "wireplumber"
          "clock"
        ];

        "hyperland/workspaces" = {
          persistent-workspaces = { "*" = 6; };
          show-special = true;
          format = "<sub>{icon}</sub>{windows}";
          window-rewrite-default = "";
          window-rewrite = {
            "title<.*youtube.*>" = "󰗃";
            "class<firefox>" = "";
            "class<firefox> title<.*github.*>" = "";
            "fish.*" = "";
            "nvim.*" = "";
          };
        };
      };
    };
    style = builtins.readFile ./style.css;
  };
}
