{ config, pkgs, inputs, nixpkgs, ... }:

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
    ./term
    ./git.nix
    ./firefox.nix
    ./waybar
    ./music
    ./discord
  ];

  # colorScheme = nix-colors.colorSchemes.gruvbox;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
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

    gruvbox-gtk-theme

    vlc
    mpv

    hyprshot
    hyprpicker

    deluge

    protonvpn-gui
    protonvpn-cli

    obsidian
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
        vim_keys = true;
      };
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
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
