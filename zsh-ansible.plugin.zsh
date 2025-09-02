# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_pyenv_package() {
  export PYENV_ROOT="${HOME}/.pyenv"

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

  for k in "${(@k)ZSH_PYENV_DEFAULT}"; do
    if [[ ! -d $ZSH_PYENV_DEFAULT[$k] ]]; then
      git clone $k $ZSH_PYENV_DEFAULT[$k]
    else
    fi
  done

  for k in "${(@k)ZSH_PYENV_PLUGINS}"; do
    if [[ ! -d $ZSH_PYENV_PLUGINS[$k] ]]; then
      git clone $k $ZSH_PYENV_PLUGINS[$k]
    else
    fi
  done

  export PATH="${PATH}:${PYENV_ROOT}/bin"
  export PATH="${PATH}:${PYENV_ROOT}/shims"
  rehash
}

_zsh_pyenv_apply() {
  eval "$(pyenv init - zsh)"

  source ${PYENV_ROOT}/completions/pyenv.zsh
}

# Вызов установки в фоне
if type git >/dev/null; then
  _zsh_pyenv_package
fi

if type pyenv >/dev/null; then
  _zsh_pyenv_apply
fi
