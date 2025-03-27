{ config,lib, pkgs, ... }:
let 
  myAliases = {
    cat = "bat";
    ls = "eza --icons=always --color=always -a --git --no-filesize --no-time --no-user --no-permissions";

    fullClean = '' 
        nix-collect-garbage --delete-old

        sudo nix-collect-garbage -d

        sudo /run/current-system/bin/switch-to-configuration boot
    '';
    rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
    fullRebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/ && home-manager switch --flake ~/dotfiles/ -b backup";
    homeRebuild = "home-manager switch --flake ~/dotfiles/ -b backup";
};
in
{
  programs = {
    oh-my-posh = {
        enable = true;
        enableZshIntegration = true;
        settings = builtins.fromTOML (builtins.unsafeDiscardStringContext (builtins.readFile ../config/ohmyposh/zen.toml));
    };
    zoxide = {
        enable = true;
        enableZshIntegration = true;
    };
    fzf = {
        enable = true;
        enableZshIntegration = true;
    };
	zsh = {
		enable = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		enableCompletion = true;
		history = {
			size = 5000;
			path = "${config.xdg.dataHome}/.zsh_history";
			append = true;
			share = true;
			ignoreAllDups = true;
			ignoreDups = true;
			ignoreSpace = true;
		};
		initExtra = '' 
ZSH_DISABLE_COMPFIX=true
    export EDITOR=nvim
    if [ -n "$TTY" ]; then
      export GPG_TTY=$(tty)
    else
      export GPG_TTY="$TTY"
    fi

    export BUN_INSTALL=$HOME/.bun
    export PATH="$HOME/go/bin:$BUN_INSTALL/bin:$PATH"

    # SSH_AUTH_SOCK set to GPG to enable using gpgagent as the ssh agent.
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent

    bindkey -e

    # disable sort when completing `git checkout`
    zstyle ':completion:*:git-checkout:*' sort false

    # set descriptions format to enable group support
    # NOTE: don't use escape sequences here, fzf-tab will ignore them
    zstyle ':completion:*:descriptions' format '[%d]'

    # set list-colors to enable filename colorizing
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu no

    # preview directory's content with eza when completing cd
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'

    # switch group using `<` and `>`
    zstyle ':fzf-tab:*' switch-group '<' '>'

    # Keybindings
    bindkey -e
    bindkey '^p' history-search-backward
    bindkey '^n' history
    bindkey '^[w' kill-region

    zle_highlight+=(paste:none)

    setopt appendhistory
    setopt sharehistory
    setopt hist_ignore_space
    setopt hist_ignore_all_dups
    setopt hist_save_no_dups
    setopt hist_ignore_dups
    setopt hist_find_no_dups
    ''; 
   
		shellAliases = myAliases;
        oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "sudo"
      "docker"
      "golang"
      "kubectl"
      "kubectx"
      "rust"
      "command-not-found"
      "pass"
      "helm"
    ];
  };
   #     zplug = {
   # enable = true;
    # plugins = [
  #     { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
  #     { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
  #   ];
  # };
 
  	};
  };
}
