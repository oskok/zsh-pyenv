# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_pyenv_package() {
  export PYENV_ROOT="${HOME}/.pyenv"

  typeset -A ZSH_PYENV_SOURCES
  ZSH_PYENV_SOURCES=(
    "https://github.com/pyenv/pyenv.git"            "${PYENV_ROOT}/"
    "https://github.com/pyenv/pyenv-doctor.git"     "${PYENV_ROOT}/plugins/pyenv-doctor"
    "https://github.com/pyenv/pyenv-installer.git"  "${PYENV_ROOT}/plugins/pyenv-installer"
    "https://github.com/pyenv/pyenv-update.git"     "${PYENV_ROOT}/plugins/pyenv-update"
    "https://github.com/pyenv/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"
    "https://github.com/pyenv/pyenv-which-ext.git"  "${PYENV_ROOT}/plugins/pyenv-which-ext"
  )

for k in "${(@k)ZSH_PYENV_SOURCES}"; do
  local ZSH_PYENV_URL=$k
  local ZSH_PYENV_NAME=$(echo ${ZSH_PYENV_URL##*/} | cut -d. -f1)
  local ZSH_PYENV_PATH=$ZSH_PYENV_SOURCES[$k]

  git clone ${ZSH_PYENV_URL} ${PYENV_ROOT}/${ZSH_PYENV_NAME}/
done




  # setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
  # if [[ ! -d "${PYENV_ROOT}" ]]; then
  #   git clone "https://github.com/pyenv/pyenv.git"            "${PYENV_ROOT}" 2>&1
  #   git clone "https://github.com/pyenv/pyenv-doctor.git"     "${PYENV_ROOT}/plugins/pyenv-doctor"  2>&1
  #   git clone "https://github.com/pyenv/pyenv-installer.git"  "${PYENV_ROOT}/plugins/pyenv-installer" 2>&1
  #   git clone "https://github.com/pyenv/pyenv-update.git"     "${PYENV_ROOT}/plugins/pyenv-update"  2>&1
  #   git clone "https://github.com/pyenv/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"  2>&1
  #   git clone "https://github.com/pyenv/pyenv-which-ext.git"  "${PYENV_ROOT}/plugins/pyenv-which-ext" 2>&1
  # fi

  export PATH="${PATH}:${PYENV_ROOT}/bin"
  export PATH="${PATH}:${PYENV_ROOT}/shims"
  rehash
}

_zsh_pyenv_apply() {
  eval "$(pyenv init)"

  source ${PYENV_ROOT}/completions/pyenv.zsh
}

# Вызов установки в фоне
if type git >/dev/null; then
  _zsh_pyenv_package
fi

if type pyenv >/dev/null; then
  _zsh_pyenv_apply
fi
