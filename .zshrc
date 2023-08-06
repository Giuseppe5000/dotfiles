alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias vi='nvim'
alias clean='paru -Rsn $(paru -Qdtq)'

autoload -Uz compinit
compinit

echo -e "\033];zsh - $PWD \007"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
DISABLE_AUTO_TITLE="true"

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# p10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
