# Zsh config: custom prompt with git branch, sync status, and venv name that
# survives virtual environment activation/deactivation without flickering.

# ==============================================================================
# VIRTUAL ENVIRONMENT
# ==============================================================================
# Prevent Python virtual environments from overwriting our custom prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# ==============================================================================
# PROMPT & GIT INTEGRATION
# ==============================================================================
# Load Zsh's built-in version control system information
autoload -Uz vcs_info

# vcs_info hook — runs before each prompt
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' git:(%b)'
setopt PROMPT_SUBST

# Check sync status against origin/main
git_sync_status() {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] || return
  local counts
  counts=$(git rev-list --left-right --count HEAD...origin/main 2>/dev/null)
  [[ -z "$counts" ]] && return
  local ahead behind
  read -r ahead behind <<< "$counts"
  if [[ $ahead -gt 0 && $behind -gt 0 ]]; then
    echo " %F{yellow}↑${ahead}%f%F{red}↓${behind}%f"
  elif [[ $ahead -gt 0 ]]; then
    echo " %F{yellow}↑${ahead}%f"
  elif [[ $behind -gt 0 ]]; then
    echo " %F{red}↓${behind}%f"
  else
    echo " %F{green}✓%f"
  fi
}

# Safely extract and display the active Python virtual environment
venv_status() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "(%F{green}$(basename "$VIRTUAL_ENV")%f) "
  fi
}

# Wrap activate/deactivate so our prompt always survives
_set_prompt() {
  PROMPT='$(venv_status)%n@%m %1~%F{cyan}${vcs_info_msg_0_}%f$(git_sync_status) %# '
}

activate() {
  source "${1:-.venv}/bin/activate"
  _set_prompt
}

deactivate() {
  # call the real deactivate if it exists
  if typeset -f _orig_deactivate > /dev/null; then
    _orig_deactivate
    unfunction _orig_deactivate
  fi
  _set_prompt
}

# Stash the real deactivate after a venv is sourced directly
# (handles `source .venv/bin/activate` called without our wrapper)
precmd() {
  vcs_info
  if typeset -f deactivate > /dev/null && ! typeset -f _orig_deactivate > /dev/null; then
    # A venv was activated externally; capture its deactivate and wrap it
    eval "$(typeset -f deactivate | sed 's/^deactivate /_orig_deactivate /')"
    eval "$(typeset -f deactivate)"  # redefine with our wrapper above
    _set_prompt
  fi
}

# ==============================================================================
# GIT BRANCH SWITCHER
# ==============================================================================
switch() {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] || { echo "Not a git repository."; return; }
  local branch
  branch=$(git branch --format='%(refname:short)' | fzf --height 40% --reverse --prompt="Switch to branch: ")
  if [[ -n "$branch" ]]; then
    git checkout "$branch"
  fi
}

# ==============================================================================
# INITIAL PROMPT
# ==============================================================================
_set_prompt
