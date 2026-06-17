{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    # structural settings
    settings = {
      # typography
      font_family = "LXGW WenKai Mono";
      font_size = "13.0";
      adjust_column_width = "-1";
      
      # window padding and style
      window_padding_width = "14";
      hide_window_decorations = "yes";
      confirm_os_window_close = "0";
      
      # pure monochrome palette
      foreground = "#ffffff";
      background = "#000000";
      selection_foreground = "#000000";
      selection_background = "#ffffff";
      
      # standard ansi mappings to crisp white tones
      color0 = "#1a1a1a";
      color8 = "#333333";
      color1 = "#ffffff";
      color9 = "#ffffff";
      color2 = "#ffffff";
      color10 = "#ffffff";
      color3 = "#ffffff";
      color11 = "#ffffff";
      color4 = "#ffffff";
      color12 = "#ffffff";
      color5 = "#ffffff";
      color13 = "#ffffff";
      color6 = "#ffffff";
      color14 = "#ffffff";
      color7 = "#cccccc";
      color15 = "#ffffff";
    };
  };
}
