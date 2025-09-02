# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

export PYENV_HOME="$HOME/.pyenv"

_zsh_package_pyenv() {
  git clone "${GITHUB}/pyenv/pyenv.git"            "${PYENV_HOME}"
  git clone "${GITHUB}/pyenv/pyenv-doctor.git"     "${PYENV_HOME}/plugins/pyenv-doctor"
  git clone "${GITHUB}/pyenv/pyenv-installer.git"  "${PYENV_HOME}/plugins/pyenv-installer"
  git clone "${GITHUB}/pyenv/pyenv-update.git"     "${PYENV_HOME}/plugins/pyenv-update"
  git clone "${GITHUB}/pyenv/pyenv-virtualenv.git" "${PYENV_HOME}/plugins/pyenv-virtualenv"
  git clone "${GITHUB}/pyenv/pyenv-which-ext.git"  "${PYENV_HOME}/plugins/pyenv-which-ext"
}

# Вызов установки в фоне
if type git >/dev/null; then
  _zsh_package_pyenv
fi
