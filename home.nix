{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "morswin";
  home.homeDirectory = "/home/morswin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # wayland.windowManager.hyprland = {
  #   settings = {
  #     enable = true;
  #   };
  #   systemd.enable = true;
  # };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = pkgs.hyprland;
  #   # plugins = [
  #   #   pkgs.hyprlandPlugins.waybar
  #   # ];
  # };

  programs = {
    helix = {
      enable = true;
      settings = {  # Why it doesn't work?
        # theme = "gruvbox";
        theme = "ao";
        editor = {
          line-number = "relative";
        };
      };
    };
    kitty.enable = true;
    obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.droidcam-obs
        pkgs.obs-studio-plugins.wlrobs
        pkgs.obs-studio-plugins.obs-backgroundremoval
        pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      ];
    };
  };
  # programs.fish.enable = true;
  # # # users.defaultUserShell = pkgs.fish;
  # programs.fish.shellInit = ''command fastfetch --logo "~/Pictures/logo/Nixos-Pepe.txt"'';

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # System UX
    pkgs.bat  # Prettier cat
    pkgs.btop  # Prettier htop
    pkgs.eza
    pkgs.fastfetch
    pkgs.kitty  # Shell emulator aka. console
    pkgs.nh  # Nixos helper - a nicer way to update system
    pkgs.opentabletdriver  # Drivers to graphical tablet
    pkgs.tldr
    pkgs.vlc  # Video player
    # System Administration ?
    pkgs.clamtk  # Antivirus
    pkgs.keepassxc  # Password manager
    pkgs.lynis  # Security auditing tool
    # Development
    pkgs.bun
    pkgs.git
    pkgs.github-desktop
    pkgs.gource
    pkgs.helix
    pkgs.nodejs_23
    pkgs.php
    pkgs.python314
    pkgs.rustup
    pkgs.vscodium
    pkgs.zig
    # University | Office
    pkgs.brave  # A browser
    pkgs.libreoffice-qt6-fresh  # Libreoffice suit
    pkgs.librewolf  # A browser
    pkgs.logisim  # A tool for designing circuits
    pkgs.umlet  # A tool for making UML diagrams
    # Content Creation
    pkgs.audacity  # Audio recorder and editor
    pkgs.droidcam
    pkgs.gimp
    pkgs.godot_4
    pkgs.jp2a   # Ascii art generator
    pkgs.kdePackages.kdenlive  # Video edito
    pkgs.krita
    # pkgs.obs-studio  # Declared in programs.obs-studio section, if uncommented causes conflicts
    pkgs.obsidian
    pkgs.texliveFull
    # Gaming
    pkgs.logmein-hamachi
    pkgs.lutris
    pkgs.prismlauncher
    pkgs.r2modman
    pkgs.superTuxKart
    pkgs.steam
    pkgs.wine
    pkgs.xclicker
    # Communication
    pkgs.discord
    pkgs.discord-screenaudio
    pkgs.simplex-chat-desktop
    pkgs.thunderbird
    pkgs.whatsapp-for-linux

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # stylix = {
  #   enable = true;
  #   fonts = {
  #     serif = {
  #       package = pkgs.minecraftia;
  #       name = "Minecraftia";
  #     };
  #   };
  # };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/morswin/etc/profile.d/hm-session-vars.sh
  #
  # home.sessionVariables = {
    # EDITOR = "emacs";
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
