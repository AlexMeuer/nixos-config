{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # https://github.com/Misterio77/nix-colors
  # imports = [
  #   nix-colors.homeManagerModules.default
  # ];
  imports = [
    ./fish.nix
    ./git.nix
    ./firefox.nix
  ];

  # colorScheme = nix-colors.colorSchemes.gruvbox;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override { fonts = [ "Hack" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    networkmanagerapplet

    neofetch
    lolcat
    tree
    fishPlugins.colored-man-pages
    fishPlugins.fzf-fish
    fzf
    fishPlugins.grc
    grc
    ranger
    gnupg
    ripgrep
    vlc
    mpv

    hyprshot
    hyprpicker

    spotify
    discord
    vesktop # Required for screensharing with audio on wayland. Run it with 'vesktop' command.
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  programs = {
    kitty = {
      enable = true;
      theme = "Gruvbox Material Dark Medium";
      font.name = "Hack Nerd Font Mono";
      shellIntegration.enableFishIntegration = true;
      # TODO: kitty config (as own module that I'll then import here)
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
        vim_keys = true;
      };
    };
    atuin = {
      enable = true;
      enableFishIntegration = true;
    };
    thefuck = {
      enable = true;
      enableFishIntegration = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;
    };
    waybar = {
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
	    persistent-workspaces = 6;
	    show-special = true;
	    format = "<sub<{icon}</sub>{windows}";
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
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Hack Nerd Font Mono 14";
    };
    # steam = {
    #   enable = true;
    #   gamescopeSession.enable = true;
    # };
    # xdg.mimApps.defaultApplications = {
    # "application/pdf" = [ "zathura.desktop" ];
    #  "image/*" = [ "sxiv.desktop" ];
    #  "video/*" = [ "mpv.desktop" ];
    # };
  };

  services = {
    mako = {
      enable = true;
      font = "Hack Nerd Font Mono 10";
      textColor = "#FFFFFFFF";
      borderColor = "#4C7899FF";
      backgroundColor = "#285577FF";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alex/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}