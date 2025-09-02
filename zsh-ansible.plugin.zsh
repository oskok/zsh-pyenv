# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_pyenv_package() {
  export PYENV_ROOT="${HOME}/.pyenv"

  git clone "https://github.com/pyenv/pyenv.git"            "${PYENV_ROOT}"
  git clone "https://github.com/pyenv/pyenv-doctor.git"     "${PYENV_ROOT}/plugins/pyenv-doctor"
  git clone "https://github.com/pyenv/pyenv-installer.git"  "${PYENV_ROOT}/plugins/pyenv-installer"
  git clone "https://github.com/pyenv/pyenv-update.git"     "${PYENV_ROOT}/plugins/pyenv-update"
  git clone "https://github.com/pyenv/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"
  git clone "https://github.com/pyenv/pyenv-which-ext.git"  "${PYENV_ROOT}/plugins/pyenv-which-ext"

  export PATH="${PATH}:${PYENV_ROOT}/bin"
  export PATH="${PATH}:${PYENV_ROOT}/shims"
  rehash
}

_zsh_pyenv_apply() {
  eval "$(pyenv init -)"

  source ${PYENV_ROOT}/completions/pyenv.zsh
}

# Вызов установки в фоне
if type git >/dev/null; then
  _zsh_pyenv_package
fi

if type pyenv >/dev/null; then
  _zsh_pyenv_apply
fi
