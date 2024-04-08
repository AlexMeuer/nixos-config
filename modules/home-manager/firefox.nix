{ pkgs, inputs, ... }:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{ 
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.alex = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        gruvbox-dark-theme
        vimium
        darkreader
        gruvbox-dark-theme
        ublock-origin
	proton-vpn
	privacy-badger
	# onepassword-password-manager
      ];
      settings = {
        "browser.startup.page" = 3;
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "browser.topsites.contile.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "extensions.pocket.enabled" = false;
	"intl.regional_prefs.use_os_locales" = true;
      };
    };
    /* ---- POLICIES ---- */
    # Check about:policies#documentation for options.
    policies = {
      DisableMasterPasswordCreation = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
	EmailTracking = true;
      };
      PasswordManagerEnabled = false;
    };
  };
}

