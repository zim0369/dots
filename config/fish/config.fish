# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty &>/dev/null
    end
end
 
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
alias v="lvim"
alias du="dust"
alias fm="ranger"
alias rgi="rg -i"
alias rmi="rm -i"
alias ll="ls -lh"
alias la="ls -lha"
alias sv="sudo nvim"
alias pac="sudo pacman"
alias reb="systemctl reboot"
alias pow="systemctl poweroff"
alias off="xset dpms force off"
alias drag="dragon-drag-and-drop"
alias sus="systemctl suspend && slock"
alias cf="cd ~/.config/nvim/lua/plugins"
alias copy="xsel -b < " 

# source $HOME/.config/fish/skim.fish
# skim_key_bindings

starship init fish | source
