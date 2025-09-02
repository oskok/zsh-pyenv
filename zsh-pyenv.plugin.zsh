# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_pyenv_package() {

  export PYENV_ROOT="${HOME}/.pyenv"

  if [[ ! -d ${PYENV_ROOT} ]]; then
    git clone https://github.com/pyenv/pyenv.git              "${PYENV_ROOT}"
    git clone https://github.com/pyenv/pyenv-doctor.git       "${PYENV_ROOT}/plugins/pyenv-doctor"
    git clone https://github.com/pyenv/pyenv-installer.git    "${PYENV_ROOT}/plugins/pyenv-installer"
    git clone https://github.com/pyenv/pyenv-update.git       "${PYENV_ROOT}/plugins/pyenv-update"
    git clone https://github.com/pyenv/pyenv-virtualenv.git   "${PYENV_ROOT}/plugins/pyenv-virtualenv"
    git clone https://github.com/pyenv/pyenv-which-ext.git    "${PYENV_ROOT}/plugins/pyenv-which-ext"
  fi

  export PATH="${PATH}:${PYENV_ROOT}/bin"
  export PATH="${PATH}:${PYENV_ROOT}/shims"
  rehash
  echo

  eval "$(pyenv init - zsh)"
  source ${PYENV_ROOT}/completions/pyenv.zsh

}

# -----------------------------------------------------------------------------

_zsh_pyenv_install() {

  typeset -r ZSH_PYENV_VERSION=(
    '3.10'
    '3.11'
    '3.12'
    '3.13'
  )

  if type pyenv >/dev/null; then
    for version in "${ZSH_PYENV_VERSION[@]}"; do
      pyenv install ${version} --skip-existing
      echo
    done
    pyenv global $ZSH_PYENV_VERSION
  fi

  rehash
  echo

}

# -----------------------------------------------------------------------------

_zsh_pyenv_update() {

  if type pyenv >/dev/null; then
    pyenv update &
  fi

}

# -----------------------------------------------------------------------------

# Вызов установки в фоне
if type git >/dev/null; then
  _zsh_pyenv_package # > /dev/null 2>&1 &
  _zsh_pyenv_install
  _zsh_pyenv_update &
fi
