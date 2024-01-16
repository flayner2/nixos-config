{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;

    policies = {
      # Extensions
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
	"{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
	  installation_mode = "force_installed";
	};
	"addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
	  installation_mode = "force_installed";
	};
	"amptra@keepa.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepa/latest.xpi";
	  installation_mode = "force_installed";
	};
        "{32cc9e81-bf60-45c0-a698-54a52ce03279}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/gruvbox-material-dark/latest.xpi";
	  installation_mode = "force_installed";
	};
      };
    };
  };
}
