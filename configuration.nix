{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./web-server.nix
    ./users.nix
  ];

  boot.cleanTmpDir = true;
  documentation.enable = true;
  environment.shellAliases.gd = "git diff";
  environment.shellAliases.gs = "git status -sb";
  environment.systemPackages = with pkgs; [ vim tmux alejandra tailscale ];
  networking.domain = "lgmn.io";
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.autoLoadConntrackHelpers = true;
  networking.firewall.checkReversePath = "loose";
  networking.firewall.enable = true;
  networking.firewall.interfaces.eth0.allowedTCPPorts = [22 80 443];
  networking.firewall.interfaces.eth0.allowedUDPPorts = [ 41641 ];
  networking.firewall.interfaces.eth1.allowedTCPPorts = [];
  networking.firewall.interfaces.eth1.allowedUDPPorts = [];
  networking.firewall.pingLimit = "--limit 1/minute --limit-burst 5";
  networking.hostName = "ref";
  nix.settings.allow-dirty = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.warn-dirty = false;
  programs.bandwhich.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.enableLsColors = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.htop.enable = true;
  programs.iftop.enable = true;
  programs.less.enable = true;
  programs.mtr.enable = true;
  programs.neovim.enable = true;
  programs.neovim.withPython3 = true;
  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.configure.packages.system.start = with pkgs.vimPlugins; [ vim-nix packer-nvim ];
  programs.starship.enable = true;
  programs.tmux.enable = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.aggressiveResize = true;
  programs.tmux.plugins = with pkgs.tmuxPlugins; [ nord ];
  programs.tmux.newSession = true;
  programs.tmux.keyMode = "vi";
  programs.tmux.terminal = "tmux-256color";
  programs.xonsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableGlobalCompInit = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.syntaxHighlighting.highlighters =["main" "brackets" "pattern" "line"]; 
  programs.zsh.syntaxHighlighting.styles.alias = "fg=magenta,bold";
  services.do-agent.enable = true;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "prohibit-password";
  services.sshguard.enable = true;
  services.tailscale.enable = true;
  services.tailscale.permitCertUid = "jake.logemann@gmail.com";
  services.tailscale.port = 41641;
  system.stateVersion = "22.05";
  users.defaultUserShell = pkgs.zsh;
  users.users.root.shell = lib.mkForce pkgs.zsh;
  zramSwap.enable = true;
}
