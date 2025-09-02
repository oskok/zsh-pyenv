# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

export PYENV_HOME="$HOME/.pyenv"

_zsh_package_pyenv() {
  git clone "https://github.com/pyenv/pyenv.git"            "${PYENV_HOME}"
  git clone "https://github.com/pyenv/pyenv-doctor.git"     "${PYENV_HOME}/plugins/pyenv-doctor"
  git clone "https://github.com/pyenv/pyenv-installer.git"  "${PYENV_HOME}/plugins/pyenv-installer"
  git clone "https://github.com/pyenv/pyenv-update.git"     "${PYENV_HOME}/plugins/pyenv-update"
  git clone "https://github.com/pyenv/pyenv-virtualenv.git" "${PYENV_HOME}/plugins/pyenv-virtualenv"
  git clone "https://github.com/pyenv/pyenv-which-ext.git"  "${PYENV_HOME}/plugins/pyenv-which-ext"
}

# Вызов установки в фоне
if type git >/dev/null; then
  _zsh_package_pyenv
fi
