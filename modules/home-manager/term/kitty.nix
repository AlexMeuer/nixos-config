{ pkgs, inputs, ... }: {
  programs = {
    kitty = {
      enable = true;
      # theme = "Gruvbox Material Dark Medium";
      font.name = "Hack Nerd Font Mono";
      # font.size = 14;
      shellIntegration.enableFishIntegration = true;
      darwinLaunchOptions = [
        "--single-instance"
        "--directory ~"
      ];
      keybindings = {
        # vim-kitty-navigator
        # https://github.com/knubie/vim-kitty-navigator
        "ctrl+j" = "kitten pass_keys.py bottom ctrl+j";
        "ctrl+k" = "kitten pass_keys.py top    ctrl+k";
        "ctrl+h" = "kitten pass_keys.py left   ctrl+h";
        "ctrl+l" = "kitten pass_keys.py right  ctrl+l";
      };
      settings = {
        hide_window_decorations = true;

        # My Gruvbox colour scheme
        background = "#282828";
        foreground = "#d4be98";

        selection_background = "#d4be98";
        selection_foreground = "#282828";

        cursor = "#a89984";
        cursor_text_color = "background";

        active_tab_background = "#282828";
        active_tab_foreground = "#d4be98";
        active_tab_font_style = "bold";

        inactive_tab_background = "#282828";
        inactive_tab_foreground = "#a89984";
        inactive_tab_font_style = "normal";

        color0 = "#665c54";
        color8 = "#928374";

        color1 = "#ea6962";
        color9 = "#fb4934";

        color2 = "#a9b665";
        color10 = "#b8bb26";

        color3 = "#fe8019";
        color11 = "#fabd2f";

        color4 = "#458588";
        color12 = "#83a598";

        color5 = "#b16286";
        color13 = "#d3869b";

        color6 = "#689d6a";
        color14 = "#8ec07c";

        color7 = "#ebdbb2";
        color15 = "#fbf1c7";
      };
    };

  };
}
