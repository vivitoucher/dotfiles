{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # monitor configuration
      monitor = ",highrr,auto,1";

      # define default application execution commands
      "$terminal" = "nixGLIntel kitty";

      # interface scaling and gaps
      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgba(ffffffff)"; # clean white border
        "col.inactive_border" = "rgba(00000000)"; # hidden border
        layout = "dwindle";
      };

      # motion configuration
      animations = {
        enable = true;
        bezier = [ "smooth, 0.16, 1, 0.3, 1" ];
        animation = [
          "windows, 1, 7, smooth, slide"
          "workspaces, 1, 6, smooth, slide"
        ];
      };

      # master keystroke binds
      bind = [
        # core application launching
        "SUPER, RETURN, exec, $terminal"
        
        # window management
        "SUPER, Q, killactive,"
        "SUPER, M, exit,"
      ];
    };
  };
}
