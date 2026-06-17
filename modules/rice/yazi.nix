{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "name";
        ratio = [ 1 3 4 ]; # clean columnar spacing
      };
    };
  };
}
