# Different PATH search variables
export PATH=$PATH:/opt/homebrew/bin:/Users/rohanseth/Library/Python/3.9/bin:/Users/rohanseth/node_modules/.bin:~/go/bin:~/.local/share/bob/nvim-bin
export C_INCLUDE_PATH=$C_INCLUDE_PATH:$(brew --prefix)/include/:$(brew --prefix)/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/homebrew/include/:$(brew --prefix)/lib/
export CPATH=$CPATH:/opt/homebrew/include
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/lib
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"

export EDITOR='nvim'

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# freeimage
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/opt/homebrew/opt/freeimage

# zsh helpers (theme, autocomplete, autosuggestions, syntax highlighting)
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias resource="source ~/.zshrc"

alias cdg="cd ~/Documents/GitHub"
alias cdp="cd ~/Documents/Github/personal"
alias cds="cd ~/Documents/Github/school"
alias cdot="cd ~/.dotfiles"
alias cdc="cd ~/.dotfiles/files/.config/nvim"
alias cdw="cd ~/Documents/GitHub/Spurlock"

alias lg="lazygit"

alias prelab="git fetch release;git merge release/main -m \"prelab: merge release\" --allow-unrelated-histories"

alias gcc="gcc-15"
alias g++="g++-15"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/rohanseth/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
