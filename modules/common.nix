#
# Common config, settings shared by every one of my nix systems
#

{ config, pkgs, lib, ...  }:

{
  # -- Bootloader --------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # -- Always enable networking ------------------------------------------------
  networking.networkmanager.enable = true;
  # TODO hostname is set per-host

  # -- We're always west coast best coast --------------------------------------
  time.timeZone = "America/Los_Angeles"; 
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # -- Always use SSH ----------------------------------------------------------
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;  # keys only
      PermitRootLogin = "no";
    };
  };

  # -- Always have me as a user, and give me sudo through wheel ---------------- 
  users.users.chris = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      # "ssh-ed25519 AAAA... chris@wherever"  # TODO: add my actual pubkey
    ];
    shell = pkgs.bash;  # or pkgs.zsh, pkgs.fish, etc.
  };

  # Allow sudo for wheel group
  security.sudo.wheelNeedsPassword = true;

  # -- Common Packages ---------------------------------------------------------
  environment.systemPackages = with pkgs; [
    # Core utils
    btop
    file
    fd
    git
    htop
    psmisc
    ripgrep
    tmux
    tree
    unzip
    vim
    wget
    zip

    # Dev
    gcc
    gnumake

    # Networking
    dig
    ethtool
    nmap
    tcpdump

    # Internal interfaces
    i2c-tools
    pciutils
    usbutils

    # Other stuff
    hyfetch   # neofetch fork for nixos
  ];

  # -- Nix settings ------------------------------------------------------------
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimize-store = true;
  };

  # Automatic garbage collection: keeps store from growing unbounded
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Allow unfree drivers
  nixpkgs.config.allowUnfree = true;

  # System state version
  system.stateVersion = "26.05";

}

