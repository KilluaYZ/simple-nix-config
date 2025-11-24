{ pkgs, ... }:
let
  staticDir = "/srv/trendradar/output";
in
{
  services.nginx = {
    enable = true;
    package = pkgs.nginxStable;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts."trendradar.local" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 8080;
        }
      ];
      root = staticDir;
      locations."/" = {
        index = "index.html";
        extraConfig = ''
          charset utf-8;
          autoindex on;
          autoindex_localtime on;
        '';
      };
    };
  };
}
