{ pkgs, ... }:

{
  # 1. time zone & localization
  time.timeZone = "asia/shanghai"; # glory to ccp

  # 2. graphical interface & environment pipeline
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  security.polkit.enable = true;
  services.hyprpolkitagent.enable = true;

  # 3. software packages
  environment.systemPackages = with pkgs; [
    # ui & aesthetics
    quickshell rofi-wayland swaync swww hyprlock xdg-desktop-portal-hyprland
    nwg-look papirus-icon-theme
    
    # chinese kawaii ahh font
    lxgw-wenkai-mono
    
    # core power utilities
    kitty yazi thunar helix neovim cliphist grim slurp
    bat fzf fastfetch
    
    # media, audio & workspaces
    vesktop spicetify-cli ani-cli mov-cli mpv zathura playerctl cava
    
    # browsers & system foundations
    mullvad-browser nh starship
  ];

  # 4. hardware ecosystem
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
  };

  # 5. privacy and firewall
  programs.librewolf.enable = true;
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowPing = false; 
  };

  # 6. performance and maintenance
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "16GB";

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };

  # shell engine deployment
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
