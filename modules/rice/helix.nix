{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      # minimal visual layout
      editor = {
        line-numbers = "relative"; # clean context tracking
        cursorline = true;
        scrolloff = 5;
        color-modes = true;
        
        # strip down interface noise
        statusline = {
          left = [ "mode" "spinner" "file-name" ];
          right = [ "position" "total-line-counts" ];
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    
    # monochrome styling overrides
    themes = {
      flat_white = {
        "inherits" = "base16_transparent";
        "ui.background" = { fg = "#ffffff"; };
        "ui.text" = { fg = "#ffffff"; };
        "ui.cursor" = { fg = "#000000"; bg = "#ffffff"; };
        "ui.selection" = { bg = "#333333"; };
        "ui.statusline" = { fg = "#ffffff"; bg = "#1a1a1a"; };
        "warning" = "#ffffff";
        "error" = "#ffffff";
        "info" = "#ffffff";
        "hint" = "#ffffff";
      };
    };
  };
}
