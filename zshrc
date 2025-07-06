alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
alias vi='vim'
alias vif='vim $(fzf)'

autoload -Uz compinit
compinit
KEYTIMEOUT=1

echo -e "\033];zsh - $PWD \007"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# p10k
source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
