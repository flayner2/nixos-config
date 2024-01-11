{ config, ... }:
let 
  wallpaper-path = "~/Wallpapers/wallpaper.png";
in
{
  # Script to setup wallpaper
  xdg.configFile."hypr/set-bg.sh" = {
    executable = true;
    text = /* bash */ ''
      #!/usr/bin/env bash
      swww img -t none ${wallpaper-path}
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Monitor definitions (desktop)
      monitor = [
        "HDMI-A-1, preferred, 1360x0, 1"
	"HDMI-A-2, preferred, 0x0, 1"
      ];
      
      # Exec script for startup apps
      exec-once = [
        "sleep 0.1; swww init"
        "~/.config/hypr/set-bg.sh"
	"nm-applet --indicator"
	"waybar" 
	"dunst"
      ];

      # Default env vars
      env = [ 
        "XCURSOR_SIZE, 24" 
	"QT_QPA_PLATFORM, xcb" # Fixes RStudio blank screen
      ];

      # Keyboard and mouse configurations
      input = {
	# Keyboard
        kb_layout = "br";
	follow_mouse = 1;

	# Mouse
	sensitivity = 0;
      };
      
      # General appearance
      general = with config.colorScheme.colors; {
        gaps_in = 5;
	gaps_out = 0;
	border_size = 2;

	layout = "dwindle";
	allow_tearing = false;

	"col.inactive_border" = "0xff${base03}"; 
	"col.active_border" = "0xff${base0B}"; 
      };

      # Decorations
      decoration = {
        rounding = 8;
	drop_shadow = false;

	blur = {
          enabled = true;
          xray = true;
	};
      };

      # Disable animations
      animations.enabled = false;

      # Dwindle layout (aka dynamic tyling)
      dwindle = {
        pseudotile = true;
	preserve_split = true;
	force_split = 2; # Always split to the right/bottom
      };

      # Misc 
      misc = {
        # Disable anime wallpaper
	disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };

      # Binds
      binds = {
        # i3 style back-and-forth switching
	# when you try to switch to the active workspace
        workspace_back_and_forth = true;
      };

      # Window rules
      windowrulev2 = [
	"workspace 0, title:(Spotify.*)"
        "workspace 2, class:(firefox)"
	"workspace 3, class:(rstudio)"
      ];

      # Super key
      "$mod" = "SUPER";

      # Mouse bindings
      # mouse:272 LMB
      # mouse:273 RMB
      bindm = [
        "$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
      ];

      # Keyboard bindings
      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mod, RETURN, exec, alacritty"
        "$mod SHIFT, Q, killactive, "
        "$mod SHIFT, E, exit, "
        "$mod, D, exec, rofi -show combi -combi-modes \"window,run\" -show-icons"
        "$mod, SPACE, togglefloating, "
	"$mod, F, fullscreen"
        #"$mod, P, pseudo, # dwindle" # No idea what this does
        "$mod, J, togglesplit, # dwindle" # Switches the split direction
	", Print, exec, grimblast copy area"
        
        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

	# Move focused window in a monitor
	"$mod SHIFT, left, movewindow, l"
	"$mod SHIFT, right, movewindow, r"
	"$mod SHIFT, up, movewindow, u"
	"$mod SHIFT, down, movewindow, d"

	# Switch active workspace between monitors
	"$mod, P, movecurrentworkspacetomonitor, -1"
        
        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move active window to a workspace with mod + SHIFT + [0-9]
	# Instead, using 'movetoworkspacesilent' will move the window to
	# the workspace without switching to it
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
        
        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];
    };
  };
}
