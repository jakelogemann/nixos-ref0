{ modulesPath, pkgs, lib, ... }:
{
  services.caddy = {
    enable = true;
    globalConfig = ''
debug
auto_https ignore_loaded_certs
servers :443 {
  protocol {
    experimental_http3
  }
}
servers :80 {
  protocol {
    allow_h2c
  }
}
'';
    extraConfig = ''
      ref.lgmn.io, lgmn.io {
        respond "Hello!"
      }
    '';

  };
}
