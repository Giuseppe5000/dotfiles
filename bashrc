# Alias
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
alias vi='vim'
alias vif='vim $(fzf)'

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Git status function
_git_status() {
    # Check if we are inside a Git working tree
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then

        # Define the colors for the Git status
        local GIT_COLOR="\[\e[1;33m\]" # Bold Yellow
        local RESET="\[\e[m\]"         # Reset

        local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)

        if [ -z "$branch_name" ]; then
            # Detached HEAD case
            local sha=$(git rev-parse --short HEAD 2>/dev/null)
            echo "${GIT_COLOR}(HEAD detached at $sha)${RESET} "
        else
            # Simple branch display
            echo "${GIT_COLOR}(${branch_name})${RESET} "
        fi
    fi
}

PROMPT_COMMAND='
    GIT_STATUS=$(_git_status)
    MAIN_PROMPT="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[m\]\$ "
    PS1="${GIT_STATUS}${MAIN_PROMPT}"
'