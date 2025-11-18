#!/usr/bin/env sh

get_tmux_option () {
    val="$(tmux show-option -gqv "$1")"
    [ -z "$val" ] && echo "$2" || echo "$val"
}

is_cmd_exists () {
    command -v "$1" > /dev/null 2>&1
    return $?
}

get_cmd () {
    if command -v pbcopy >/dev/null; then
        echo 'pbcopy'
    elif command -v xsel >/dev/null ; then
        echo 'xsel -b'
    elif command -v xclip >/dev/null; then
        echo 'xclip -i'
    else
        return 1
    fi
}

copy_to_clipboard () {
    cmd="$(get_cmd)" || return 1
    printf '%s' "$1" | $cmd
}

clear_clipboard() {
    cmd="$(get_cmd)" || return 1
    tmux run-shell -b "sleep $1 && echo '' | $cmd"
}
