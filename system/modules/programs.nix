{ config, pkgs, ... }: 

{

 xdg.portal = {
    enable = true;
    wlr.enable = false;
    xdgOpenUsePortal = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
 };

 programs = {
	steam = { 
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

    hyprland = {
        enable = true;

        xwayland = {
            enable = true;
        };

        portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    gnupg = {
		agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};

    tmux = {
        enable = true;
        escapeTime = 0;
        
        plugins = with pkgs; [
            tmuxPlugins.vim-tmux-navigator
            tmuxPlugins.resurrect
            tmuxPlugins.continuum
            tmuxPlugins.nord
	    tmuxPlugins.sensible
        ];

        extraConfig = ''
            #--------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------

# Use Vi mode
setw -g mode-keys vi

# Increase scrollback buffer size
set -g history-limit 10000

# Start window and pane numbering from 1 for easier switching
set -g base-index 1
setw -g pane-base-index 1

# Allow automatic renaming of windows
set -g allow-rename on
# set -g automatic-rename off

# Renumber windows when one is removed.
set -g renumber-windows on

# Improve colors
set -g default-terminal "xterm-256color"

# Enable undercurl
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'

# Enable undercurl colors
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

# Allow the mouse to resize windows and select tabs
set -g mouse on

# Allow tmux to set the terminal title
set -g set-titles on

# Monitor window activity to display in the status bar
setw -g monitor-activity on

# A bell in another window should cause a bell in the current window
set -g bell-action any

# Don't show distracting notifications
set -g visual-bell off
set -g visual-activity off

# Focus events enabled for terminals that support them
set -g focus-events on

# Useful when using sharing a session with different size terminals
setw -g aggressive-resize on

# don't detach tmux when killing a session
set -g detach-on-destroy off

# address vim mode switching delay (http://superuser.com/a/252717/65504)
set -s escape-time 0

set -as terminal-features ",*:RGB"
# set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
#--------------------------------------------------------------------------
# Status line
#--------------------------------------------------------------------------

set -g @catppuccin_flavour "mocha"

#--------------------------------------------------------------------------
# Key Bindings
#--------------------------------------------------------------------------

# -r means that the bind can repeat without entering prefix again
# -n means that the bind doesn't use the prefix

set -g prefix C-a

# Send prefix to a nested tmux session by doubling the prefix
bind C-a send-prefix

# 'PREFIX r' to reload of the config file
unbind r
bind r source-file ~/.tmux.conf\; display-message '~/.tmux.conf reloaded'

# Allow holding Ctrl when using using prefix+p/n for switching windows
bind C-p previous-window
bind C-n next-window

# Move around panes like in vim
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# Smart pane switching with awareness of vim splits
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"

# Switch between previous and next windows with repeatable
bind -r n next-window
bind -r p previous-window

# resize panes more easily
bind H resize-pane -L 5
bind L resize-pane -R 5
bind J resize-pane -D 5
bind K resize-pane -U 5

# resize panes more easily with Ctrl
bind -r C-H resize-pane -L 5
bind -r C-L resize-pane -R 5
bind -r C-J resize-pane -D 5
bind -r C-K resize-pane -U 5

# Move the current window to the next window or previous window position
bind -r N run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) + 1)"
bind -r P run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) - 1)"

# Switch between two most recently used windows
bind Space last-window

# switch between two most recently used sessions
bind b switch-client -l

# break pane out of window
bind-key B break-pane -d

# put pane back into window
bind-key E command-prompt -p "join pane from: "  "join-pane -h -s '%%'"

# allow to copy to system clipboard
bind-key y run -b "tmux show-buffer | xclip -selection clipboard"\; display-message "copied tmux buffer to system clipboard"

# open lazygit in a new window with prefix+g
bind-key g new-window -n lazygit -c "#{pane_current_path}" "lazygit"

# open an application in a new window with prefix+o, and allow me to provide the app name
bind-key o command-prompt -p "open app: " "new-window '%%'"

# show a promp to kill a window by id with prefix+X
bind-key X command-prompt -p "kill window: " "kill-window -t '%%'"

# use prefix+| (or prefix+\) to split window horizontally and prefix+- or
# (prefix+_) to split vertically also use the current pane path to define the
# new pane path
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# change the path for newly created windows
bind c new-window -c "#{pane_current_path}"

bind C-e display-popup -E "\
    tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
    sed '/^$/d' |\
    fzf --reverse --header jump-to-session |\
    xargs tmux switch-client -t"

# Move tmux status bar to top
bind-key C-k run-shell "tmux set-option -g status-position top;"
# Move tmux status bar to bottom
bind-key C-j run-shell "tmux set-option -g status-position bottom;"        '';
    };

    zsh.enable = true;
	mtr.enable = true;
 };
 environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;

}
