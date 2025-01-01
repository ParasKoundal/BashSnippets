# Quick Git commit
quick_commit() {
    git add --all *
    git commit -m "${1:-Quick update}"
    git push
    echo "======== Changes committed and pushed. Testing Status ========"
    git status
}
# Quickly Commit. Example Usage : gitfast "My Comment" . If no comment is given the default comment is "Quick update"
alias gitfast="quick_commit"