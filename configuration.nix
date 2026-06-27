{ pkgs, ... }:

{
  # 1. Core System Foundations & Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Absolute Layer 1 Muzzling: Forces a silent, pristine black boot canvas
  boot.kernelParams = [ "quiet" "splash" "loglevel=3" "systemd.show_status=false" "rd.udev.log_level=3" "vt.global_cursor_default=0" ];
  boot.consoleLogLevel = 0;

  # Core engine compatibility version
  system.stateVersion = "24.11";

  # Enable modern experimental features for tools like 'nh'
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 2. Time Zone & Localization
  time.timeZone = "asia/shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];

  # 3. Graphical Interface & Environment Pipeline
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  security.polkit.enable = true;
  services.hyprpolkitagent.enable = true;

  # 4. Software Packages (Pure baseline for the new setup)
  environment.systemPackages = with pkgs; [
    # UI & Aesthetics
    quickshell rofi-wayland swaync swww hyprlock xdg-desktop-portal-hyprland
    nwg-look papirus-icon-theme
    
    # Chinese Kawaii Mono Font
    lxgw-wenkai-mono
    
    # Core Power Utilities
    kitty yazi thunar helix neovim cliphist grim slurp
    bat fzf fastfetch tesseract # Added tesseract here to satisfy Layer 9 OCR engine requirements!
    
    # Media, Audio & Workspaces
    vesktop spicetify-cli ani-cli mov-cli mpv zathura playerctl cava
    
    # Browsers & System Foundations
    mullvad-browser nh starship wl-clipboard
  ];

  # 5. Hardware Ecosystem
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # 6. Privacy and Firewall (Max Privacy Directives)
  programs.librewolf.enable = true;
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowPing = false; 
  };

  # Optimized Automated System Cleaner Matching Layer 9
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d";
    };
  };

  # Shell Engine Deployment
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
