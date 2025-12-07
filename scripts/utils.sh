#!/usr/bin/env sh
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2025       Jorenar
# Copyright (C) 2018-2025  Rafael Bodill

get_tmux_option () {
    val="$(tmux show-option -gqv "$1")"
    [ -z "$val" ] && echo "$2" || echo "$val"
}

get_cmd () {
    if command -v pbcopy >/dev/null; then
        echo 'pbcopy'
    elif command -v wl-copy >/dev/null; then
        echo 'wl-copy'
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
