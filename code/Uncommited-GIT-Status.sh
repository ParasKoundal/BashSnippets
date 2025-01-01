# Indicate if there are uncommitted changes in status bar
git_dirty() {
    [[ -n $(git status --porcelain 2>/dev/null) ]] && echo "-GitItNow"
}
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$\[\033[00m\] \$(git_dirty)\$"