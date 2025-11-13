# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
  # ========================================================================
  # System Level Configuration
  # ========================================================================
  # FIXME: Add the rest of your current configuration
  # boot configurations
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # network configurations
  networking.proxy.default = "http://station.killuayz.top:20172";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  # =========================================================================

  # system packages
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    curl
    ncurses
    vscode
    vscode.fhs
    (vscode-with-extensions.override {
      vscodeExtensions =
        with vscode-extensions;
        [
          bbenoist.nix
          ms-python.python
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "remote-ssh-edit";
            publisher = "ms-vscode-remote";
            version = "0.47.2";
            sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
          }
        ];
    })
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.isoimagewriter
    kdiff3
    kdePackages.partitionmanager
    hardinfo2
    wayland-utils
    wl-clipboard
    nixfmt-rfc-style
  ];

  i18n.defaultLocale = "zh_CN.UTF-8";

  # TODO: Set your hostname
  networking.hostName = "asus";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    ziyang = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      isNormalUser = true;
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCYA4Ox5ljYsh/x6dozk59Ov7FvEJbUgDRq9OwmQiDAHZY4UnBgk67dYjDpkRYzoRNmNA5MKtF3A6hCraeFGtGsCaSAJSXZgPZRvXWpPUVbKhBnV7B5esGxGRHW3NQGusQrRJHyxhY7pUDDozoxipquN2EsuGA7zLiQCZ/kYc1I0ruyyjlVE8ILSFD8CUPp9Oy4BTie2bF6RzxX0slYbx8OARm2N/aNNnyM9bLWtAMtfidgkghhu6Qh9MCoEQpnYgGDcwzGtEVhGzWm5s1szga1qTKDRhnK5T7mexsgSiAdENsc6xYjDgPZKftBDFh3QFOSYYliWeYXFonAE9qs9VHBxo+w89iEz9DzR0sLy3aKRmaDtgNAP5jKAnmu6MDMLBp+nzkocdd2TK4ZwRqbWqlc+44L9zGz+yLS9WhGQZ0LA4TcjGlQsIQeinEfbZls+zabDGV4lRv4QNBdSYgdERG5Sfmsbz0xf+XGcBZvEWhmsprIy2gF6NR0DaMgUkwSCvE= ziyang@DESKTOP-IAESBB8"
      ];
      hashedPassword = "$6$SSpIKNnheK9B5vzE$v42bKAYFp/pX0EqfSWYBIjGXvAY2tcyMkAV9J.uXaxPAzf/mQOWHSTypCHhHbByQbt6kzwjJ.TZKGrOpYX0WJ0";
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services = {
    openssh = {
      enable = true;
      settings = {
        # Opinionated: forbid root login through SSH.
        PermitRootLogin = "no";
        # Opinionated: use keys only.
        # Remove if you want to SSH using passwords
        # PasswordAuthentication = yes;
      };
    };
    # I use plasma 6
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
