{ pkgs, ... }:

{
  # ===================================================================
  # 1. GRAPHICAL INTERFACE & ENVIRONMENT PIPELINE
  # ===================================================================
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Keeps your desktop session clean and organized
    xwayland.enable = true;
  };

  # Security & Authentication Agents
  security.polkit.enable = true;
  services.hyprpolkitagent.enable = true;

  # Master Software Packages Deployment Array
  environment.systemPackages = with pkgs; [
    # Glass Interface Ecosystem
    quickshell rofi-wayland swaync swww hyprlock xdg-desktop-portal-hyprland
    nwg-look papirus-icon-theme
    
    # Fonts
    lxgw-wenkai-mono
    
    # Core Power Utilities
    kitty yazi thunar helix neovim cliphist grim slurp
    
    # Media, Audio & Workspaces
    vesktop spicetify-cli ani-cli mov-cli mpv zathura playerctl cava
    
    # Browsers & System Foundations
    mullvad-browser nh starship
  ];

  # ===================================================================
  # 2. HARDWARE ECOSYSTEM BACKENDS
  # ===================================================================
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Audio Pipeline Configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # ===================================================================
  # 3. INTERNET STEALTH & REVENUE-FREE CONTENT BLOCKING
  # ===================================================================
  programs.librewolf.enable = true;

  # Local Offline DNS Sinkhole
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };

  # Firewall Lockdown
  networking.firewall = {
    enable = true;
    allowPing = false; 
  };

  # ===================================================================
  # 4. MEMORY & PERFORMANCE TUNING
  # ===================================================================
  
  # RAM-disk for building (Speeds up your system and saves SSD life)
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "16GB";

  # The One-Command Rule & Storage Cleanup
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };

  # Shell Engine Deployment
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
