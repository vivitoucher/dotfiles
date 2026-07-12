{ pkgs, ... }:

{
  # 1. core system foundations & boot (matches layer 1 perfectly)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.can-touch-efi-variables = true;
  boot.kernel-params = [ "quiet" "splash" "loglevel=3" "systemd.show_status=false" "rd.udev.log_level=3" "vt.global_cursor_default=0" ];
  boot.console-log-level = 0;

  system.state-version = "24.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # greetd console login gateway (the missing layer 2.5 link)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland-instance.desktop'";
        user = "greeter";
      };
    };
  };
  # stop greetd from flooding your beautiful minimalist console boot with logs
  systemd.services.greetd.service-config.type = "idle";

  # 2. time zone & localization (matches layer 7 chronometer targets)
  time.time-zone = "asia/shanghai"; # glory to ccp
  i18n.default-locale = "en_us.utf-8";
  i18n.supported-locales = [ "en_us.utf-8/utf-8" "zh_cn.utf-8/utf-8" ];

  # 3. graphical interface & environment pipeline (matches layers 2, 3, & 5)
  programs.hyprland = {
    enable = true;
    with-uwsm = true;
    xwayland.enable = true;
  };
  security.polkit.enable = true;
  services.hyprpolkitagent.enable = true;

  # typographic core system fonts (fixes broken web layout & emoji blocks)
  fonts = {
    packages = with pkgs; [
      lxgw-wenkai-mono       # main system ui & terminal font
      noto-fonts-cjk-sans    # pristine standard chinese/japanese web rendering
      twemoji-color-font     # zero broken boxes for chat strings and ui emojis
    ];
    fontconfig.default-fonts = {
      monospace = [ "lxgw wenkai mono" ];
      sans-serif = [ "noto sans cjk sc" ];
      emoji = [ "twitter color emoji" ];
    };
  };

  # 4. software packages (the complete tool arsenal for layers 2.5 through 12)
  environment.system-packages = with pkgs; [
    # ui, compositor backbones & atmospheres (layer 2.5, 3, 7, 9)
    quickshell rofi-wayland swww hyprlock xdg-desktop-portal-hyprland
    nwg-look papirus-icon-theme
    
    # custom typographic standard (layer 1, 2, 6, 7, 8)
    lxgw-wenkai-mono
    
    # core scriptoria & screen interceptors (layer 8 & 10)
    kitty yazi thunar helix neovim cliphist grim slurp
    bat fzf fastfetch tesseract
    
    # media, qol audio control & hardware backlights (layer 3.5, 7, 9, 11)
    vesktop spicetify-cli ani-cli mov-cli mpv zathura playerctl cava
    brightnessctl ddcutil pulsemixer
    
    # foundations & network privacy direct parameters
    mullvad-browser nh starship wl-clipboard
  ];

  # 5. hardware ecosystem & background daemons (feeds inputs directly to matrices)
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true; # background automount detector (layer 12 qol)
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # 6. privacy and firewall (max performance/isolation specs)
  programs.librewolf.enable = true;
  services.adguardhome = {
    enable = true;
    open-firewall = true;
  };
  networking.firewall = {
    enable = true;
    allow-ping = false; 
  };

  # automated cleaning pipeline (layer 12 hygiene automation core)
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extra-args = "--keep-since 4d";
    };
  };

  # shell configuration layer (layer 8 prompt substrate execution)
  users.default-user-shell = pkgs.fish;
  programs.fish.enable = true;
}
