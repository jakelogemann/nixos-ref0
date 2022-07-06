{
  config,
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
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  documentation.enable = false;
  environment.shellAliases.ga = "git add";
  environment.shellAliases.gb = "git branch";
  environment.shellAliases.gci = "git commit";
  environment.shellAliases.gco = "git checkout";
  environment.shellAliases.gd = "git diff";
  environment.shellAliases.gf = "git fetch";
  environment.shellAliases.git-vars = "${lib.getExe pkgs.bat} -l=ini --file-name 'git var -l' <(git var -l)";
  environment.shellAliases.gl = "git log";
  environment.shellAliases.grb = "git rebase";
  environment.shellAliases.grm = "git rm";
  environment.shellAliases.gs = "git status -sb";
  environment.shellAliases.gsw = "git switch";
  environment.shellAliases.l = "ls -alh";
  environment.shellAliases.la = "${lib.getExe pkgs.lsd} -a";
  environment.shellAliases.ll = "${lib.getExe pkgs.lsd} -l";
  environment.shellAliases.lla = "${lib.getExe pkgs.lsd} -la";
  environment.shellAliases.ls = lib.getExe pkgs.lsd;
  environment.shellAliases.lt = "${lib.getExe pkgs.lsd} --tree";
  environment.shellAliases.system-info = "${lib.getExe pkgs.neofetch}";
  environment.variables.EDITOR = lib.getExe pkgs.neovim;
  nix.allowedUsers = lib.mkForce [ "root" "jake" "christine" ];
  nix.autoOptimiseStore = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = ''--max-freed "$((30 * 1024**3 - 1024 * $(df -P -k /nix/store | tail -n 1 | ${pkgs.gawk}/bin/awk '{ print $4 }')))"'';
  nix.optimise.automatic = true;
  nix.optimise.dates = ["daily"];
  nix.settings.allow-dirty = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.http-connections = 0;
  nix.settings.warn-dirty = false;
  nix.trustedUsers = lib.mkForce [ "root" ];
  powerManagement.cpuFreqGovernor = "powersave";
  programs.bandwhich.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.enableLsColors = true;
  programs.htop.enable = true;
  programs.iftop.enable = true;
  programs.less.enable = true;
  programs.mtr.enable = true;
  programs.xonsh.enable = true;
  security.allowUserNamespaces = true;
  security.forcePageTableIsolation = true;
  security.rtkit.enable = true;
  security.virtualisation.flushL1DataCache = "always";
  services.acpid.enable = true;
  services.do-agent.enable = true;
# services.earlyoom.enable = true;
# services.earlyoom.freeMemThreshold = 10;
# services.earlyoom.freeSwapThreshold = 10;
  services.fwupd.enable = true;
  services.journald.extraConfig = lib.concatStringsSep "\n" ["SystemMaxUse=1G"];
  services.journald.forwardToSyslog = false;
  services.openssh.allowSFTP = true;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "prohibit-password";
  services.sshguard.enable = true;
  services.tailscale.enable = true;
  services.tailscale.permitCertUid = "jake.logemann@gmail.com";
  services.tailscale.port = 41641;
  system.stateVersion = "22.05";
  virtualisation.oci-containers.backend = "podman";
  zramSwap.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  programs.git = {
    config.alias.aliases = "!git config --get-regexp '^alias\.' | sed -e 's/^alias\.//' -e 's/\ /\ =\ /'";
    config.alias.amend = "git commit --amend --no-edit";
    config.alias.amendall = "git commit --all --amend --edit";
    config.alias.amendit = "git commit --amend --edit";
    config.alias.b = "branch -lav";
    config.alias.force-push = "push --force-with-lease=+HEAD";
    config.alias.fp = "fetch --all --prune";
    config.alias.lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    config.alias.lglc = "log --not --remotes --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    config.alias.lglcd = "submodule foreach git log --branches --not --remotes --oneline --decorate";
    config.alias.loga = "log --graph --decorate --name-status --all";
    config.alias.quick-rebase = "rebase --interactive --root --autosquash --auto-stash";
    config.alias.remotes = "!git remote -v | sort -k3";
    config.alias.st = "status -uno";
    config.commit.gpgSign = false;
    config.core.editor = lib.getExe pkgs.neovim;
    config.core.pager = lib.getExe pkgs.delta;
    config.init.defaultBranch = "main";
    config.interactive.difffilter = "${lib.getExe pkgs.delta} --color-only";
    config.pull.ff = true;
    config.pull.rebase = true;
    config.url."https://github.com/".insteadOf = ["gh:" "github:"];
    enable = true;
    lfs.enable = true;
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    newSession = true;
    keyMode = "vi";
    baseIndex = 1;
    reverseSplit = true;
    secureSocket = true;
    shortcut = "b";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [pain-control onedark-theme sensible];
  };

  programs.starship = {
    enable = true;
    settings.add_newline = false;
    # settings.format = "$character";
    # settings.right_format = "$all";
    settings.scan_timeout = 10;
    settings.character.success_symbol = "[➜](bold green)";
    settings.character.error_symbol = "[➜](bold red)";
    settings.character.vicmd_symbol = "[](bold magenta)";
    settings.git_status.disabled = true;
    settings.hostname.ssh_only = true;
    settings.jobs.symbol = "⊕";
    settings.python.symbol = "py ";
    settings.nodejs.symbol = "js ";
    settings.golang.symbol = "go ";
    settings.username.disabled = true;
    settings.localip.disabled = true;
    settings.ruby.symbol = "rb ";
    settings.rust.symbol = "rs ";
    #settings.character.continuation_prompt = "[▶▶](dim cyan)";
  };

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "root" "line"];
    syntaxHighlighting.styles.alias = "fg=magenta,bold";
    autosuggestions.extraConfig.ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = "20";
    autosuggestions.highlightStyle = "fg=cyan";
    autosuggestions.strategy = ["completion"];
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "AUTO_CD"
      "AUTO_PUSHD"
      "HIST_IGNORE_DUPS"
      "SHARE_HISTORY"
      "HIST_FCNTL_LOCK"
      "EXTENDED_HISTORY"
      "RM_STAR_WAIT"
      "CD_SILENT"
      "CHASE_DOTS"
      "CHASE_LINKS"
      "PUSHD_IGNORE_DUPS"
      "PUSHD_MINUS"
      "PUSHD_SILENT"
      "PUSHD_TO_HOME"
      "COMPLETE_ALIASES"
      "EXTENDED_HISTORY"
      "BASH_AUTO_LIST"
      "INC_APPEND_HISTORY"
      "INTERACTIVE_COMMENTS"
      "MENU_COMPLETE"
      "HIST_SAVE_NO_DUPS"
      "HIST_IGNORE_SPACE"
      "HIST_EXPIRE_DUPS_FIRST"
    ];
    histSize = 100000;
    interactiveShellInit = ''
      autoload -U edit-command-line; zle -N edit-command-line;
      autoload -U select-word-style && select-word-style bash;

      hash -d current-sw=/run/current-system/sw
      hash -d booted-sw=/run/booted-system/sw

      bindkey '\C-a' beginning-of-line
      bindkey '\C-e' end-of-line
      bindkey '\C-x\C-e' edit-command-line
      bindkey '\C-k' up-line-or-history
      bindkey '\C-j' down-line-or-history
      bindkey '\C-h' backward-word
      bindkey '\C-l' forward-word

      source "${pkgs.skim}/share/skim/completion.zsh"
      source "${pkgs.skim}/share/skim/key-bindings.zsh"
      eval "$(direnv hook zsh)"
      eval "$(navi widget zsh)"
      eval "$(zoxide init zsh)"
    '';
  };

  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;
    "kernel.perf_event_paranoid" = 3;
    "kernel.randomize_va_space" = 2;
    "kernel.sysrq" = 0;
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;
    "net.ipv4.conf.all.accept_redirects" = 1;
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.all.proxy_arp" = 0;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "vm.swappiness" = 1;
    "net.ipv6.conf.default.accept_redirects" = 0;
  };
}
