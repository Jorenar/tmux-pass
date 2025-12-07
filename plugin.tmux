#!/usr/bin/env sh

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

# shellcheck source=scripts/utils.sh
. "${CURRENT_DIR}/scripts/utils.sh"

opt_key="$(get_tmux_option "@pass-key" "b")"
opt_size="$(get_tmux_option "@pass-window-size" "10")"

tmux bind-key "$opt_key" \
    run "tmux split-window -l $opt_size \"$CURRENT_DIR/scripts/main.sh '#{pane_id}'\""
