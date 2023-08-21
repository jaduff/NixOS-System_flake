# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, ... }:

{
  # Enable flakes
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = ["nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = "Carnifex-nix";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-560d2bbf-03ca-4220-9357-59e0abc465ec".device = "/dev/disk/by-uuid/560d2bbf-03ca-4220-9357-59e0abc465ec";
  boot.initrd.luks.devices."luks-560d2bbf-03ca-4220-9357-59e0abc465ec".keyFile = "/crypto_keyfile.bin";

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
   services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
   services.printing.enable = true;
   services.printing.drivers = [ pkgs.foomatic-db-ppds-withNonfreeDb ];

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
};
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };

  users.users.jaduff = {
    isNormalUser = true;
    description = "James Duff";
    extraGroups = [ "networkmanager" "wheel" "docker" "input"];
#    packages = with pkgs; [
#      firefox
#    ];
#  };
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.flatpak.enable = true;
  # XDG portal for flatpack
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-kde
    ];
  };

  # List services that you want to enable:

  virtualisation.libvirtd.enable = true;

  programs.dconf.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
  vlc
  firefox
  lm_sensors
  cifs-utils
  iotop
  inetutils
  protonvpn-gui
  postgresql
  alacritty
  remmina
  oh-my-fish
  fish
  borgbackup
  vorta
  virt-manager
  tmux
  gh
  vim
  htop-vim
  git
  neovim
  libreoffice
  protonvpn-gui
  telegram-desktop
  krita
  inkscape
  gimp
  librewolf
  nextcloud-client
  kdeconnect
  kate
  kcalc
  joplin-desktop
  zettlr
  protonmail-bridge
  thunderbird
  anytype
  espanso
  skypeforlinux
#  (builtins.getFlake "github:jaduff/fflinuxprint-flake")
  (vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      vscode-extensions.ms-dotnettools.csharp
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }
    ];
  })
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];
}

