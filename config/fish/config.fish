if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_user_key_bindings
        for mode in insert default visual
            bind -M $mode \cf forward-char
            bind -M $mode \cw forward-word
            bind -M $mode \e\[3~ backward-kill-word
            bind -M $mode \cc backward-kill-line repaint
            bind -M $mode \cz "fg"
            bind -M $mode \et "gela t; commandline -f repaint"
        end
    end
end

fzf_configure_bindings --directory=\cd

alias l="ls"
alias x="exit"
alias v="nvim"
alias fm="ranger"
alias rmi="rm -i"
alias ll="ls -lh"
alias la="ls -lha"
alias sv="sudo nvim"
alias pac="sudo pacman"
alias reb="systemctl reboot"
alias pow="systemctl poweroff"
alias drop="dragon-drag-and-drop"
alias sus="systemctl suspend && slock"
alias cf="cd ~/.config/nvim/lua/plugins"
alias copy="xsel -b < " 

starship init fish | source 
