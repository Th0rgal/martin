{ pkgs, ... }: {

  nix.trustedUsers = [ "root" "martin" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.martin = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "video" "audio" "plugdev" ];
    };
  };
}
