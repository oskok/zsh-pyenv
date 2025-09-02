# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_pyenv_package() {
  export PYENV_ROOT="${HOME}/.pyenv"

  typeset -r PYENV_VERSION=(
    '3.10'
    '3.11'
    '3.12'
    '3.13'
  )

  typeset -A ZSH_PYENV_DEFAULT
  ZSH_PYENV_DEFAULT=(
    "https://github.com/pyenv/pyenv.git"            "${PYENV_ROOT}"
  )

  typeset -A ZSH_PYENV_PLUGINS
  ZSH_PYENV_PLUGINS=(
    "https://github.com/pyenv/pyenv-doctor.git"     "${PYENV_ROOT}/plugins/pyenv-doctor"
    "https://github.com/pyenv/pyenv-installer.git"  "${PYENV_ROOT}/plugins/pyenv-installer"
    "https://github.com/pyenv/pyenv-update.git"     "${PYENV_ROOT}/plugins/pyenv-update"
    "https://github.com/pyenv/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"
    "https://github.com/pyenv/pyenv-which-ext.git"  "${PYENV_ROOT}/plugins/pyenv-which-ext"
  )

  ZSH_CURRENT_PATH=$(pwd)

  for k in "${(@k)ZSH_PYENV_DEFAULT}"; do
    if [[ ! -d $ZSH_PYENV_DEFAULT[$k] ]]; then
      git clone $k $ZSH_PYENV_DEFAULT[$k]
    else
      cd $ZSH_PYENV_DEFAULT[$k] && git pull
    fi
  done

  for k in "${(@k)ZSH_PYENV_PLUGINS}"; do
    if [[ ! -d $ZSH_PYENV_PLUGINS[$k] ]]; then
      git clone $k $ZSH_PYENV_PLUGINS[$k]
    else
      cd $ZSH_PYENV_PLUGINS[$k] && git pull
    fi
  done

  cd ${ZSH_CURRENT_PATH}

  export PATH="${PATH}:${PYENV_ROOT}/bin"
  export PATH="${PATH}:${PYENV_ROOT}/shims"
  rehash

  if type pyenv >/dev/null; then
    eval "$(pyenv init - zsh)"
    source ${PYENV_ROOT}/completions/pyenv.zsh
  fi

  if type pyenv >/dev/null; then
    for version in "${PYENV_VERSION[@]}"; do
      pyenv install ${version} --skip-existing
    done
    pyenv global $PYENV_VERSION
  fi
  rehash
}

# Вызов установки в фоне
if type git >/dev/null; then
  setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
  _zsh_pyenv_package > /dev/null 2>&1 &
  disown &>/dev/null
fi
