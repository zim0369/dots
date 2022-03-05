#!/usr/bin/env bash

## ANSI Colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
DEFAULT_FG="$(printf '\033[39m')"  DEFAULT_BG="$(printf '\033[49m')" BOLD="$(tput bold)" NORMAL="$(tput sgr0)"

## Directories
KITTY_DIR="$HOME/.config/kitty"
LIGHT_DIR="/usr/local/share/pretty-kitty/colors/light"
DARK_DIR="/usr/local/share/pretty-kitty/colors/dark"
WALL_DIR="/usr/local/share/pretty-kitty/wallpapers"
FONTS_DIR="/usr/local/share/fonts/pretty-kitty"

## Banner
banner () {
    clear
    printf '\n%s' "
    ${ORANGE}☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴
    ${CYAN}██▓▒­░⡷⠂${RED} 𝓟𝓻𝓮𝓽𝓽𝔂 𝓚𝓲𝓽𝓽𝔂 ${BLUE}🐈 ${CYAN}⠐⢾░▒▓██ 
    ${ORANGE}☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴☴
    "
}

exit_on_signal_SIGINT () {
    { printf "\n\n%s\n" "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}Script interrupted" 2>&1; reload_settings; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM () {
    { printf "\n\n%s\n" "    ${BOLD}${MAGENTA} ⚫ ${NORMAL} ${BLUE}Script terminated" 2>&1; reload_settings; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
    return
}
 
check_files () {
    shopt -s nullglob dotglob 
    if [[ "$1" = light ]]; then
        light=( "${LIGHT_DIR}"/*.conf )
        printf "%d\n" ${#light[@]} 
    elif [[ "$1" = dark ]]; then
        dark=( "${DARK_DIR}"/*.conf )
        printf "%d\n" ${#dark[@]} 
    elif [[ "$1" = walls ]]; then
        walls=( "${WALL_DIR}"/*.png )
        printf "%d\n" ${#walls[@]} 
    elif [[ "$1" = fonts ]]; then
        fonts=( "${FONTS_DIR}"/*.ttf )
        printf "%d\n" ${#fonts[@]} 
    fi
    unset light dark walls fonts 
    return
}

total_light=$(check_files light)
total_dark=$(check_files dark)
total_wall=$(check_files walls)
total_fonts=$(check_files fonts)

## Reload Settings
reload_settings () {
    printf '\n%s' "    ${BOLD}${GREEN} ✔️ ${NORMAL} ${BLUE}Reloading Settings...";
    kitty @ set-colors --all "$KITTY_DIR/colors.conf" > /dev/null
    return
}
 
## Print Message 
restart_kitty () {
    printf '\n%s' "    ${BOLD}${RED} ! ${NORMAL} ${BLUE}Please Restart Kitty";
    return
}
invalid_option () {
    printf '\n%s' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}Invalid Option, Try Again"
    return
}

select_light () {
    if ! cd "$LIGHT_DIR"; then
        printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}${LIGHT_DIR} doesn't exist${BLUE}";
        exit 1 
    fi 
    scheme=$( fzf ) 
    printf '\n%s' "    ${BOLD}${RED} ♥ ${NORMAL} ${BLUE}You selected: ${scheme##*/}"
    if ! cp --force "${LIGHT_DIR}/${scheme}" "${KITTY_DIR}/colors.conf" &>/dev/null; then
        printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}Failed to apply theme${BLUE}";
        return 1
    fi
	{ reload_settings; reset_color; exit; }
}
 
select_dark () {
    if ! cd "$DARK_DIR"; then
        printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}${DARK_DIR} doesn't exist${BLUE}";
        exit 1 
    fi 
    scheme=$( fzf ) 
    printf '\n%s' "    ${BOLD}${RED} ♥ ${NORMAL} ${BLUE}You selected: ${scheme##*/}"
    if ! cp --force "${DARK_DIR}/${scheme}" "${KITTY_DIR}/colors.conf" &>/dev/null; then
        printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}Failed to apply theme${BLUE}";
        return 1
    fi
	{ reload_settings; reset_color; exit; }
}
 
apply_font_family () {
    if ! grep -Ewq 'font_family' "${KITTY_DIR}/kitty.conf"; then
        banner 
		printf '\n%s\n' "    ${BOLD}${RED} ➕ ${NORMAL} ${BLUE}Adding font_family option to config..."
		printf '\n%s' "font_family" >> "${KITTY_DIR}/kitty.conf"
        sleep 1; 
	fi
    if ! cd "$FONTS_DIR"; then
        printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}${FONTS_DIR} doesn't exist${BLUE}";
        exit 1 
    fi 
    font_ttf=$( fzf )
    font_name=$(fc-list | grep -i $font_ttf | head -n 1 | cut -d':' -f2)
    printf '\n%s' "    ${BOLD}${RED} ♥ ${NORMAL} ${BLUE}Changing font to: $font_name"
    sed -ie "s/.*font_family.*/font_family $font_name/g" "$KITTY_DIR/kitty.conf"
    { restart_kitty; reload_settings; exit; }
}
 
apply_font_size () {
    if ! grep -Ewq 'font_size' "${KITTY_DIR}/kitty.conf"; then
        banner 
		printf '\n%s\n' "    ${BOLD}${RED} ➕ ${NORMAL} ${BLUE}Adding font_size option to config..."
		printf '\n%s' "font_size" >> "${KITTY_DIR}/kitty.conf"
        sleep 1; 
	fi
    printf "\n" 
    read -r -p "    ${BLACKBG}${BOLD}${WHITE} Enter Font Size (Default is 10) ${WHITEBG}${RED} ► ${NORMAL} " font_size;
    printf '\n%s' "    ${BOLD}${RED} ♥ ${NORMAL} ${BLUE}Setting size to: $font_size"
    sed -ie "s/.*font_size.*/font_size ${font_size:-10}/g" "$KITTY_DIR/kitty.conf"
    { restart_kitty; reload_settings; exit; }
}
 
select_wall () {
    if ! cd "$WALL_DIR"; then
        printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}${WALL_DIR} doesn't exist${BLUE}";
        exit 1 
    fi 
    wallpaper=$( fzf ) 
	if ! grep --quiet 'background_image' "${KITTY_DIR}/kitty.conf"; then
        banner
		printf '\n%s\n' "    ${BOLD}${RED} ➕ ${NORMAL} ${BLUE}Adding background_image option to kitty config..."
		printf '\n%s' "#background_image" >> "${KITTY_DIR}/kitty.conf"
	fi
    sed -ie "s|.*background_image.*|background_image $wallpaper|g" "$KITTY_DIR/kitty.conf"
    printf '\n%s' "    ${BOLD}${GREEN} ✔️ ${NORMAL} ${BLUE}Wallpaper Set To: ${wallpaper##*/}"
}
 
random_light () {
    random_scheme="$(find "$LIGHT_DIR" -type f -name "*.conf" | shuf -n 1)"
    printf '\n%s' "    ${BOLD}${GREEN} ✔️ ${NORMAL} ${BLUE}Theme Set To: ${random_scheme##*/}"
	if ! cp --force "${random_scheme}" "${KITTY_DIR}/colors.conf" &>/dev/null; then
        printf '%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}Failed to apply theme!" >&2
		return 1
	fi
    { reload_settings; reset_color; exit; }
}
 
random_dark () {
    random_scheme="$(find "$DARK_DIR" -type f -name "*.conf" | shuf -n 1)"
    printf '\n%s' "    ${BOLD}${GREEN} ✔️ ${NORMAL} ${BLUE}Theme Set To: ${random_scheme##*/}"
	if ! cp --force "${random_scheme}" "${KITTY_DIR}/colors.conf" &>/dev/null; then
        printf '%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}Failed to apply theme!" >&2
		return 1
	fi
    { reload_settings; reset_color; exit; }
}
 
random_wallpaper () {
	if ! grep --quiet 'background_image' "${KITTY_DIR}/kitty.conf"; then
        banner 
		printf '%s\n' "    ${BOLD}${RED} ➕ ${NORMAL} ${BLUE}Adding background_image option to kitty config..."
		printf "#background_image" >> "${KITTY_DIR}/kitty.conf"
	fi
    wallpaper="$(find "$WALL_DIR" -type f -name "*.png" | shuf -n 1)"
    sed -ie "s|.*background_image.*|background_image $wallpaper|g" "$KITTY_DIR/kitty.conf"
    printf '\n%s' "    ${BOLD}${GREEN} ✔️ ${NORMAL} ${BLUE}Wallpaper Set To: ${wallpaper##*/}"
    { restart_kitty; reload_settings; reset_color; exit; }
}
 
remove_wall () {
    sed -ie "s|.*background_image.*|#background_image|g" "$KITTY_DIR/kitty.conf"
    { restart_kitty; reload_settings; reset_color; exit; }
}

kitty_wall () {
    printf '\n%s\n' "
    ${WHITEBG}${BOLD}${BLACK} S ${DEFAULT_BG}${NORMAL} ${BLUE}Select Wallpaper ($total_wall)
    ${BLACKBG}${BOLD}${WHITE} R ${DEFAULT_BG}${NORMAL} ${BLUE}Remove Wallpaper
    "
    { printf "\n"; read -r -n 1 -p "    ${BLACKBG}${BOLD}${WHITE} Select Option ${WHITEBG}${RED} ► ${DEFAULT_BG}${NORMAL}"; printf "\n"; }
     
    if [[ "$REPLY" =~ ^[s/S/r/R/q/Q]$ ]]; then      #validate input
        if [[ "$REPLY" =~ ^[s/S]$ ]]; then
            select_wall
            { reload_settings; reset_color; exit; }
        elif [[ "$REPLY" =~ ^[r/R]$ ]]; then
            remove_wall
            { reload_settings; reset_color; exit; }
        fi 
    else
        invalid_option 
        { sleep 1; banner; kitty_wall; }
    fi
}

upload_imgur () {
    printf '\n%s\n\n' "    ${BOLD}${GREEN} ▲ ${BLUE}Upload image/s to Imgur${NORMAL}";
    if command -v imgur >/dev/null 2>&1; then
        read -r -e -p "    ${BLACKBG}${BOLD}${WHITE} Specify Path to Image ${WHITEBG}${RED} ► ${DEFAULT_BG}${NORMAL} " image_path;
        banner;
        printf '\n%s\n\n' "    ${BOLD}${MAGENTA} ⚫ ${NORMAL} ${BLUE}Preparing to upload ${GREEN}${image_path}...${BLUE}";
        image_path="${image_path/#\~/$HOME}" 
        kitty +kitten icat "$image_path"
        imgur "$image_path"
    else
        printf '%s\n' "    ${BOLD}${RED} !${BLUE}] ${BLUE}Installing imgur script...${BLUE}";
        if ! sudo wget --show-progress https://raw.githubusercontent.com/tremby/imgur.sh/main/imgur.sh -O /usr/local/bin/imgur; then
            sudo rm /usr/local/bin/imgur 
            printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}Failed to retrieve imgur script...${BLUE}";
            exit; 
        else
            sudo chmod +x /usr/local/bin/imgur 
            { banner; upload_imgur; }
        fi 
    fi
exit;
} 

import_files () {
    printf '\n%s\n' "    ${WHITEBG}${BOLD}${BLACK} L ${DEFAULT_BG}${NORMAL} ${BLUE}Local File (Enter path to file)
    ${BLACKBG}${BOLD}${WHITE} I ${DEFAULT_BG}${NORMAL} ${BLUE}Internet File (Enter File URL)"
    { printf "\n"; read -r -n 1 -p "    ${BLACKBG}${BOLD}${WHITE} Select Option ${WHITEBG}${RED} ► ${DEFAULT_BG}${NORMAL}" option; printf "\n"; }

    temp_file=$(mktemp /tmp/kitty_XXXXXXXXXX.conf)

    if [[ "$option" =~ ^[l/L/i/I]$ ]]; then
        if [[ "$option" =~ ^[l/L]$ ]]; then
            read -r -e -p "    ${BLACKBG}${BOLD}${WHITE} Enter Path To Color-scheme ${WHITEBG}${RED} ► ${DEFAULT_BG}${NORMAL} " file_path;
            cat "$file_path" > "$KITTY_DIR/colors.conf"
            { reload_settings; reset_color; exit; }
        elif [[ "$option" =~ ^[i/I]$ ]]; then
            read -r -p "    ${BLACKBG}${BOLD}${WHITE} Enter Color-scheme URL ${WHITEBG}${RED} ► ${DEFAULT_BG}${NORMAL} " file_link;
            wget -o /tmp/log -O "$temp_file" "$file_link"
            cat "$temp_file" > "$KITTY_DIR/colors.conf"
            { reload_settings; reset_color; exit; }
        fi
    else
        invalid_option
        { sleep 2; banner; import_files; }
    fi
}
 
update_pkitty () {
    banner; 
    printf '\n%s' "    ${BOLD}${RED} ! ${NORMAL} ${BLUE}UPDATING..."
    printf '\n%s' "    ${BLUE}"
	if [[ ! -d $HOME/pretty-kitty ]]; then
        git clone https://github.com/zim0369/pretty-kitty "$HOME/pretty-kitty" 
        if ! cd "$HOME/pretty-kitty"; then
            printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}${HOME}/pretty-kitty doesn't exist${BLUE}";
            exit 1 
        fi 
    else
        printf '\n%s' "    ${BOLD}${RED} ! ${NORMAL} ${BLUE}Directory Exists..."
        if ! cd "$HOME/pretty-kitty"; then
            printf '\n%s\n' "    ${BOLD}${RED} ❌ ${NORMAL} ${BLUE}${HOME}/pretty-kitty doesn't exist${BLUE}";
            exit 1 
        fi 
        git pull
	fi
    chmod +x ./* 
    sh install 
	{ reload_settings; reset_color; exit; }
}
 
interface() {
until [[ "$REPLY" =~ ^[q/Q]$ ]]; do
    banner
    printf '\n%s' "
    ${BLACKBG}${BOLD}${WHITE} D ${DEFAULT_BG}${NORMAL}${BLUE} Select Dark Theme(${total_dark})
    ${WHITEBG}${BOLD}${BLACK} L ${DEFAULT_BG}${NORMAL}${BLUE} Select Light Theme(${total_light})
    ${BLACKBG}${BOLD}${WHITE} F ${DEFAULT_BG}${NORMAL}${BLUE} Font Family(${total_fonts})
    ${WHITEBG}${BOLD}${BLACK} S ${DEFAULT_BG}${NORMAL}${BLUE} Font Size
    ${BLACKBG}${BOLD}${WHITE} J ${DEFAULT_BG}${NORMAL}${BLUE} Random Dark Theme
    ${WHITEBG}${BOLD}${BLACK} K ${DEFAULT_BG}${NORMAL}${BLUE} Random Light Theme
    ${BLACKBG}${BOLD}${WHITE} W ${DEFAULT_BG}${NORMAL}${BLUE} Wallpaper(${total_wall})
    ${WHITEBG}${BOLD}${BLACK} G ${DEFAULT_BG}${NORMAL}${BLUE} Upload Image/s
    ${BLACKBG}${BOLD}${WHITE} U ${DEFAULT_BG}${NORMAL}${BLUE} Update pkitty
    ${WHITEBG}${BOLD}${BLACK} I ${DEFAULT_BG}${NORMAL}${BLUE} Import Files
    ${BLACKBG}${BOLD}${WHITE} Q ${DEFAULT_BG}${NORMAL}${BLUE} Quit
    "

    { printf "\n"; read -r -n 1 -p "${BOLD}    ${BLACKBG}${WHITE} Select Option ${WHITEBG}${RED} ► ${DEFAULT_BG}${NORMAL}"; printf "\n"; banner; }

    if [[ "$REPLY" =~ ^[j/J/k/K/d/D/l/L/f/F/s/S/w/W/g/G/u/U/u/U/i/I/q/Q]$ ]]; then      #validate input
        if [[ "$REPLY" =~ ^[d/D]$ ]]; then
            select_dark
        elif [[ "$REPLY" =~ ^[l/L]$ ]]; then
            select_light
        elif [[ "$REPLY" =~ ^[f/F]$ ]]; then
            apply_font_family
        elif [[ "$REPLY" =~ ^[s/S]$ ]]; then
            apply_font_size
        elif [[ "$REPLY" =~ ^[j/J]$ ]]; then
            random_dark
        elif [[ "$REPLY" =~ ^[k/K]$ ]]; then
            random_light
        elif [[ "$REPLY" =~ ^[w/W]$ ]]; then
            kitty_wall
        elif [[ "$REPLY" =~ ^[g/G]$ ]]; then
            upload_imgur
        elif [[ "$REPLY" =~ ^[i/I]$ ]]; then
            import_files
        elif [[ "$REPLY" =~ ^[u/U]$ ]]; then
            update_pkitty
        fi
    else
        # invalid_option
        sleep 2
    fi
done
{ printf '\n%s\n' "    ${BOLD}${MAGENTA} ⚫ ${NORMAL} ${BLUE}Bye Bye, Have A Nice Day!"; reload_settings; reset_color; exit 0; }
} 

show_help() {
	cat << EOF
Randomly select & apply an kitty color theme

USAGE: ${0##*/} [OPTIONS]

OPTIONS:
	-h, --help 		Show this help message
	-d, --dark 		Only select dark themes
	-l, --light 	Only select light themes
    -u, --upload 	Upload to imgur
EOF
}

main() {
	local opts
	opts="$(getopt --options hdlu --longoptions help,dark,light,upload --name "${0##*/}" -- "${@}")"
	
	eval set -- "${opts}"
	while true; do
		case "${1}" in
			-h | --help ) 	show_help; exit 0;;
			-d | --dark ) 	random_dark; exit 0;;
			-l | --light ) 	random_light; exit 0;;
			-u | --upload ) upload_imgur; exit 0;;
			-- ) 			shift; break;;
			* ) 			break;;
		esac
		shift
	done
     
	if ! [ -s "${KITTY_DIR}/kitty.conf" ]; then
		printf '\n%s' "    ${BOLD}${MAGENTA} ⚫ ${NORMAL} ${BLUE}Cannot find kitty configuration: '${KITTY_DIR}/kitty.conf'${BLUE}";
		printf '\n%s' "    ${BOLD}${MAGENTA} ⚫ ${NORMAL} ${BLUE}Creating one for you...${BLUE}";
	    cp -r /usr/local/share/pretty-kitty/kitty.conf "$KITTY_DIR"
        { restart_kitty; reset_color; exit; }
	fi
     
	if ! grep --quiet 'colors\.conf' "${KITTY_DIR}/kitty.conf"; then
        banner
		printf '\n%s' "    ${BOLD}${RED} ➕ ${NORMAL} ${BLUE}Adding colors.conf import to kitty config..."
		printf '\n%s' "include ${KITTY_DIR}/colors.conf" >> "${KITTY_DIR}/kitty.conf"
        { restart_kitty; reset_color; exit; }
	fi
    
    interface
	
	return 0
}

main "${@}"
