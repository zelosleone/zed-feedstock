#!/usr/bin/env bash
# Restore previous XKB_CONFIG_ROOT when deactivating this conda env (Linux only)
if [ "$(uname)" = "Linux" ]; then
  if [ -n "${CONDA_ZED_XKB_CONFIG_ROOT_BACKUP-}" ]; then
    export XKB_CONFIG_ROOT="${CONDA_ZED_XKB_CONFIG_ROOT_BACKUP}"
  else
    unset XKB_CONFIG_ROOT
  fi
  unset CONDA_ZED_XKB_CONFIG_ROOT_BACKUP
fi

