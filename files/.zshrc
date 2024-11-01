# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Different PATH search variables
export PATH=$PATH:/opt/homebrew/bin:~/Documents/Github/school/lc3tools/build/bin
export C_INCLUDE_PATH=$(brew --prefix)/include/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/homebrew/include/

# lc3tools Commands
alias lc3convert="assembler"
alias lc3sim="simulator"

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# freeimage
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/opt/homebrew/opt/freeimage

# zsh helpers (theme, autocomplete, autosuggestions, syntax highlighting)
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
