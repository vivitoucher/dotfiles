{ pkgs, nixgl, ... }:

{
  # core user definitions
  home.username = "vivi";
  home.homeDirectory = "/home/vivi";
  home.stateVersion = "24.11";

  # connect architectural structural modules
  imports = [
    ../../modules/rice/hyprland.nix
    ../../modules/rice/kitty.nix
    ../../modules/rice/helix.nix
    ../../modules/rice/yazi.nix
    ../../modules/quickshell/default.nix
  ];

  # let home manager install and manage itself
  programs.home-manager.enable = true;

  # target package pool for new setups
  home.packages = [
    pkgs.helix
    pkgs.fastfetch
    pkgs.yazi
    pkgs.bat
    pkgs.fzf
    pkgs.lxgw-wenkai
    nixgl.packages.${pkgs.system}.nixGLIntel
  ];

  # shell engine configurations
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
    '';
  };

  # modern prompt wrapper
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
