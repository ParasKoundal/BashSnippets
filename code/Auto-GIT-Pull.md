# Automatically pull latest changes when changing directories
# Track the last git pull time
GIT_PULL_LAST_RUN=0
GIT_PULL_COOLDOWN=300  # Cooldown in seconds
function auto_git_pull() {
    # Find the Git root directory
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    # Exit if not inside a Git repository
    if [ -z "$git_root" ]; then
        return
    fi
    # Check if cooldown period has passed
    local current_time
    current_time=$(date +%s)
    if (( current_time - GIT_PULL_LAST_RUN < GIT_PULL_COOLDOWN )); then
        return
    fi
    # Update the last run timestamp
    GIT_PULL_LAST_RUN=$current_time

    # Perform git pull at the root
    echo "Pulling latest changes in $git_root..."
    (cd "$git_root" && git pull)
}

# Override the `cd` command
cd() {
    builtin cd "$@" && auto_git_pull
}