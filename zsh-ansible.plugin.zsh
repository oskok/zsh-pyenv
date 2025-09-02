# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_package_pyenv() {
  git clone "https://github.com/pyenv/pyenv.git"            "${HOME}/.pyenv"
  git clone "https://github.com/pyenv/pyenv-doctor.git"     "${HOME}/.pyenv/plugins/pyenv-doctor"
  git clone "https://github.com/pyenv/pyenv-installer.git"  "${HOME}/.pyenv/plugins/pyenv-installer"
  git clone "https://github.com/pyenv/pyenv-update.git"     "${HOME}/.pyenv/plugins/pyenv-update"
  git clone "https://github.com/pyenv/pyenv-virtualenv.git" "${HOME}/.pyenv/plugins/pyenv-virtualenv"
  git clone "https://github.com/pyenv/pyenv-which-ext.git"  "${HOME}/.pyenv/plugins/pyenv-which-ext"
}

# Вызов установки в фоне
if type git >/dev/null; then
  _zsh_package_pyenv
fi

if [[ -f "${HOME}/.pyenv/bin/pyenv" ]]; then
  export PYENV_ROOT="${PYENV_HOME}"
  export PATH="${PATH}:${PYENV_ROOT}/bin"
  export PATH="${PATH}:${PYENV_ROOT}/shims"
fi
