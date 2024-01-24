alias ls='ls --hyperlink=auto --color=auto'
alias grep='grep --color=auto'
alias clean='paru -Rsn $(paru -Qdtq)'
alias vi='vim'

autoload -Uz compinit
compinit
KEYTIMEOUT=1

echo -e "\033];zsh - $PWD \007"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# p10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
