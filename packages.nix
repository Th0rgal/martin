{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [
      neovim wget git pv nodejs brightnessctl system-config-printer
    ];
    variables.EDITOR = "nvim";
  };

  nixpkgs = {

    overlays = [
      (self: super: {
        neovim = super.neovim.override {
          viAlias = true;
          vimAlias = true;
          configure = {
              #customRC = ''
                # here your custom configuration goes!
              #'';
              packages.myVimPackage = with pkgs.vimPlugins; {
                start = [ vim-nix ];
                opt = [ ];
              };      
          };
        };
      })
    ];
  };

  services = {

    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "fr";
      xkbOptions = "eurosign:e";

      # Enable touchpad support.
      libinput.enable = true;

      # Enable lightdm
      displayManager.lightdm.enable = true;
      desktopManager.xterm.enable = true;
    };   

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint pkgs.gutenprintBin ];
    };

    # Enable ipfs
    ipfs.enable = false;

    # Optimize battery
    tlp.enable = true;

    # Enable bluetooth service
    blueman.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound.
  nixpkgs.config.pulseaudio = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  hardware.ledger.enable = true;

}
