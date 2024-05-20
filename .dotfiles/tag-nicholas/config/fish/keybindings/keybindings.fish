# Ctrl + G to easily commit all changes to the local Git Repository.

function git_commit_and_push
    git add -A
    git commit -v
    git push
end

bind \cg git_commit_and_push

# Ctrl + R to search through history using fzf.
bind \cr 'fzf'
