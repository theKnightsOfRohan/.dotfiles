#!/bin/zsh

dotfiles=(
    ".config"
    ".fig"
    ".p10k.zsh"
    ".zshrc"
)

for df in $dotfiles; do
    src_path="$HOME/.dotfiles/files/$df"

    tgt_path="$HOME/$df"

    ln -s "$src_path" "$tgt_path"

    echo "Symlinked $df"
done
