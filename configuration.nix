# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Speed up boot times by not waiting for a few things.
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  networking.hostName = "alex-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };

  # Enable hyprland, which uses wayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    # Hint eleactron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # If your cursor becomes invisible:
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "alex";
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Access is restricted to authorized personnel only.' --asterisks --time --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "alex";
      };
    };
  };

  console = {
    keyMap = "ie";
    earlySetup = true;
    colors = [
      "292828"
      "32302f"
      "504945"
      "665c54"
      "bdae93"
      "ddc7a1"
      "ebdbb2"
      "fbf1c7"
      "ea6962"
      "e78a4e"
      "d8a657"
      "a9b665"
      "89b482"
      "7daea3"
      "d3869b"
      "bd6f3e"
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex = {
    isNormalUser = true;
    description = "Alexander Meuer";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      "alex" = import ./modules/home-manager/alex.home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    libnotify
    linuxKernel.packages.linux_5_15.nvidia_x11_vulkan_beta_open
    ntfs3g
    pinentry
  ];

  programs = {
    bash = {
  interactiveShellInit = ''
if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
  exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
fi
'';
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
    gnupg.agent = {
      enable = true;
    };
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
  hardware.steam-hardware.enable = true;

  # List services that you want to enable:
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.syncthing = {
    # https://nixos.wiki/wiki/Syncthing
    enable = true;
    user = "alex";
    dataDir = "/home/alex/Documents";
    configDir = "/home/alex/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      #devices = {
      #  "Phone" = { id = "SRE44RO-PTG2K6Y-ZLBAMPP-QXZS62D-5B0D4C5-MQOZBU5-PUB2LMJ-I5U5IQT"; };
      #};
      #folders = {
      #  "Obsidian" = {                     # Name of folder in Syncthing, also the folder ID
      #    path = "/home/alex/repos/notes"; # Which folder to add to Syncthing
      #    devices = [ "Phone" ];           # Which devices to share the folder with
      #  };
      #};
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
