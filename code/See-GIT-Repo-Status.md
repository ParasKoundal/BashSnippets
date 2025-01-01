git_dashboard() {
    echo "Repositories Updated Recently:"
    for dir in .; do
        [ -d "$dir/.git" ] && (
            cd "$dir" || return
            echo "$(basename "$dir"): $(git log -1 --format="%cr")"
        )
    done | column -t
}
# See GIT Repo Status
alias gdash="git_dashboard"