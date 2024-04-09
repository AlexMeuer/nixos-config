{ pkgs, ... }: {
    imports = [
        ./spotify.nix
    ];

    services.mopidy = {
        enable = true;
        extensionPackages = with pkgs; [
	    mopidy-local
	    mopidy-spotify
	    mopidy-soundcloud
	    mopidy-mpd
	    mopidy-mpris
        ];
    };
}
