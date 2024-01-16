{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Policies
    policies = {
      DisableSetDesktopBackground = true;
      SearchBar = "unified";
      OfferToSaveLogins = false;
    };

    profiles.maycon = {
      isDefault = true;

      # Search
      search = {
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
	
	default = "DuckDuckGo";
	privateDefault = "DuckDuckGo";
	force = true;
      };

      # User settings
      settings = {
        # Performance settings
        "gfx.webrender.all" = true; # Force enable GPU acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes

	# General settings
	"app.shield.optoutstudies.enabled" = false;
	"browser.bookmarks.restore_default_bookmarks" = false;
	"browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.discovery.enabled" = false;
	"browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
	"browser.shell.checkDefaultBrowser" = false;
	"browser.tabs.loadBookmarksInBackground" = true;
	"browser.toolbars.bookmarks.visibility" = "always";
	"browser.urlbar.placeholderName" = "DuckDuckGo";
	"datareporting.policy.dataSubmissionEnable" = false;
        "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
	"privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
	"ui.systemUsesDarkTheme" = 1;
      };
    };
  };
}
