{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/programs 
    ../../home/shell
  ];

  programs.git = {
    userName = "killuayz";
    userEmail = "2959243019@qq.com";
  };
}