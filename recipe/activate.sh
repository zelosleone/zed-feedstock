#!/usr/bin/env bash
# Set XKB_CONFIG_ROOT for Zed when this conda env is active (Linux only)
if [ "$(uname)" = "Linux" ]; then
  export CONDA_ZED_XKB_CONFIG_ROOT_BACKUP="${XKB_CONFIG_ROOT-}"
  export XKB_CONFIG_ROOT="/usr/share/X11/xkb"
fi

