{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}"; 
    stateVersion = "25.05";
  };
  # 开启 Home Manager
  programs.home-manager.enable = true;
}