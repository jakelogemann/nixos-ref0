{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware.nix
    ./web-server.nix
    ./users.nix
    ./neovim.nix
    ./network.nix
    ./pkgs.nix
  ];

  boot.cleanTmpDir = true;
  documentation.enable = true;
  environment.shellAliases.gd = "git diff";
  environment.shellAliases.gs = "git status -sb";
  nix.settings.allow-dirty = false;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.warn-dirty = true;
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
  programs.neovim.configure.packages.system.start = with pkgs.vimPlugins; [vim-nix packer-nvim];
  programs.starship.enable = true;
  programs.tmux.enable = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.aggressiveResize = true;
  programs.tmux.plugins = with pkgs.tmuxPlugins; [nord];
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
  programs.zsh.syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "line"];
  programs.zsh.syntaxHighlighting.styles.alias = "fg=magenta,bold";
  services.do-agent.enable = true;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "prohibit-password";
  services.sshguard.enable = true;
  services.tailscale.enable = true;
  services.tailscale.permitCertUid = "jake.logemann@gmail.com";
  services.tailscale.port = 41641;
  services.openssh.allowSFTP = true;
  system.stateVersion = "22.05";
  zramSwap.enable = true;
}
