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
  documentation.enable = true;
  environment.shellAliases.system-info = "${lib.getExe pkgs.neofetch}";
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
  programs.htop.enable = true;
  programs.iftop.enable = true;
  programs.less.enable = true;
  programs.mtr.enable = true;
  programs.xonsh.enable = true;
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
    settings.format = "$character";
    settings.right_format = "$all";
    settings.scan_timeout = 10;
    settings.character.success_symbol = "[➜](bold green)";
    settings.character.error_symbol = "[➜](bold red)";
    settings.character.vicmd_symbol = "[](bold magenta)";
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

      hash -d current-sw=/run/current-system/sw
      hash -d booted-sw=/run/booted-system/sw

      bindkey '\C-x\C-e' edit-command-line
      bindkey '\C-k' up-line-or-history
      bindkey '\C-j' down-line-or-history
      bindkey '\C-h' backward-word
      bindkey '\C-l' forward-word

      source "${pkgs.skim}/share/skim/completion.zsh"
      source "${pkgs.skim}/share/skim/key-bindings.zsh"
      eval "$(${lib.getExe pkgs.direnv} hook zsh)"
      eval "$(${lib.getExe pkgs.navi} widget zsh)"
      eval "$(${lib.getExe pkgs.zoxide} init zsh)"
    '';
  };
}
