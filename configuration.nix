# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports = [ # Include the results of the hardware scan.
     ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # AMDGPU driver
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };
  };

  # Switching to Hyperland
  # programs.hyprland.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  # Old DE stuff
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = { 
      layout = "pl";
      variant = "";
    };
  };
  # End of old DE stuff

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.morswin = {
    isNormalUser = true;
    description = "morswin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Python libraries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib # numpy
    libgcc  # sqlalchemy
    # that's where the shared libs go, you can find which one you need using 
    # nix-locate --top-level libstdc++.so.6  (replace this with your lib)
    # ^ this requires `nix-index` pkg
  ];

  # Fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Davinci Resolve and other stuff
  hardware.graphics = {
    enable = true;
    extraPackages32 = with pkgs.driversi686Linux; [ amdvlk ];
    extraPackages = with pkgs; [
      amdvlk
      libva
      libvdpau-va-gl
      rocm-opencl-icd
      rocm-opencl-runtime
      rocmPackages.clr
      rocmPackages.clr.icd
      rocmPackages.hipblas
      rocmPackages.rocblas
      rocmPackages.rocm-comgr
      rocmPackages.rocm-runtime
      rocmPackages.rocm-smi
      rocmPackages.rocsolver
      rocmPackages.rocsparse
      vaapiVdpau
    ];
  };

  virtualisation = {
    docker.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
  };
  # users.extraGroups.vboxusers.members = [ "morswin" ];

  services.i2pd = {
    enable = false;
  };

  # OBS
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment={
    systemPackages = with pkgs; [
      # # Hyperland (thanks Vimjoyer)
      # alacritty
      # dunst  # Notification deamon
      # kitty
      # libnotify  # dunst depends on this
      # rofi-wayland  # app launcher
      # swww  # wallpaper daemon
      # waybar  # the bar (hopefully not too high)
      # (waybar.overrideAttrs (oldAttrs: {
      #     mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	    #   })
      # )
      # # No longer Hyperland
      armcord
      # audacity
      bat
      blender
      brave
      btop
      bun
      clamtk
      davinci-resolve
      # delta
      discord
      docker_27
      droidcam
      dust
      eza
      fastfetch
      ffmpeg_7
      fish
      fishPlugins.grc
      fishPlugins.sponge
      fishPlugins.tide
      fishPlugins.z
      # gcc14
      git
      github-desktop
      gimp
      godot_4
      gource
      grc
      home-manager
      # hyperfine
      i2pd
      jp2a
      keepassxc
      # kitty
      krita
      libreoffice-qt6-fresh
      librewolf
      logisim
      lutris
      neovim
      nerdfonts
      nh  # Nix helper
      nix-index
      nodejs_22
      obs-studio
      obsidian
      # ollama
      patchelf
      # procs
      python311
      python311Packages.opencv4
      python311Packages.pip
      r2modman
      roboto
      roboto-mono
      roboto-serif
      roboto-slab
      rustup
      steam
      thunderbird
      tldr
      vlc
      vscodium
      # wget
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          droidcam-obs
          wlrobs
          obs-backgroundremoval 
          obs-pipewire-audio-capture
        ];
      })
    ];
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
