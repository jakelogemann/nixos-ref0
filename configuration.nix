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
  environment.shellAliases.ga = "git add";
  environment.shellAliases.grm = "git rm";
  environment.shellAliases.gb = "git branch";
  environment.shellAliases.gl = "git log";
  environment.shellAliases.gci = "git commit";
  environment.shellAliases.gco = "git checkout";
  environment.shellAliases.gd = "git diff";
  environment.shellAliases.gsw = "git switch";
  environment.shellAliases.gf = "git fetch";
  environment.shellAliases.grb = "git rebase";
  environment.shellAliases.git-vars = "${lib.getExe pkgs.bat} -l=ini --file-name 'git var -l' <(git var -l)";
  environment.shellAliases.gs = "git status -sb";
  environment.shellAliases.l = "ls -alh";
  environment.shellAliases.la = "${lib.getExe pkgs.lsd} -a";
  environment.shellAliases.ll = "${lib.getExe pkgs.lsd} -l";
  environment.shellAliases.lla = "${lib.getExe pkgs.lsd} -la";
  environment.shellAliases.ls = lib.getExe pkgs.lsd;
  environment.shellAliases.lt = "${lib.getExe pkgs.lsd} --tree";
  environment.variables.EDITOR = lib.getExe pkgs.neovim;
  nix.autoOptimiseStore = true; 
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = ''--max-freed "$((30 * 1024**3 - 1024 * $(df -P -k /nix/store | tail -n 1 | ${pkgs.gawk}/bin/awk '{ print $4 }')))"'';
  nix.optimise.automatic = true;
  nix.optimise.dates = ["daily"];
  nix.settings.allow-dirty = false;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.warn-dirty = true;
  programs.bandwhich.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.enableLsColors = true;
  programs.git.config.aliases.aliases = "!git config --get-regexp '^alias\.' | sed -e 's/^alias\.//' -e 's/\ /\ =\ /'";
  programs.git.config.aliases.amend = "git commit --amend --no-edit";
  programs.git.config.aliases.amendall = "git commit --all --amend --edit";
  programs.git.config.aliases.amendit = "git commit --amend --edit";
  programs.git.config.aliases.b = "branch -lav";
  programs.git.config.aliases.force-push = "push --force-with-lease=+HEAD";
  programs.git.config.aliases.fp = "fetch --all --prune";
  programs.git.config.aliases.lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
  programs.git.config.aliases.lglc = "log --not --remotes --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
  programs.git.config.aliases.lglcd = "submodule foreach git log --branches --not --remotes --oneline --decorate";
  programs.git.config.aliases.loga = "log --graph --decorate --name-status --all";
  programs.git.config.aliases.quick-rebase = "rebase --interactive --root --autosquash --auto-stash";
  programs.git.config.aliases.remotes = "!git remote -v | sort -k3";
  programs.git.config.aliases.st = "status -uno";
  programs.git.config.commit.gpgSign = false;
  programs.git.config.core.editor = lib.getExe pkgs.neovim;
  programs.git.config.core.pager = lib.getExe pkgs.delta;
  programs.git.config.init.defaultBranch = "main";
  programs.git.config.interactive.difffilter = "${lib.getExe pkgs.delta} --color-only";
  programs.git.config.pull.ff = true;
  programs.git.config.pull.rebase = true;
  programs.git.config.url."https://github.com/".insteadOf = ["gh:" "github:"];
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.htop.enable = true;
  programs.iftop.enable = true;
  programs.less.enable = true;
  programs.mtr.enable = true;
  programs.neovim.configure.packages.system.start = with pkgs.vimPlugins; [vim-nix packer-nvim];
  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.withPython3 = true;
  programs.starship.enable = true;
  programs.tmux.aggressiveResize = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.enable = true;
  programs.tmux.keyMode = "vi";
  programs.tmux.newSession = true;
  programs.tmux.plugins = with pkgs.tmuxPlugins; [nord];
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
  services.openssh.allowSFTP = true;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "prohibit-password";
  services.sshguard.enable = true;
  services.tailscale.enable = true;
  services.tailscale.permitCertUid = "jake.logemann@gmail.com";
  services.tailscale.port = 41641;
  system.stateVersion = "22.05";
  zramSwap.enable = true;
}
