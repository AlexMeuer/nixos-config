{ pkgs, ... }: {
    imports = [
        ./spotify.nix
    ];

    services.mopidy = {
        enable = true;
        extensionPackages = with pkgs; [
	    mopidy-spotify
	    mopidy-soundcloud
	    mopidy-mpris
        ];
    };
}
