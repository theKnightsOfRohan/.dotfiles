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

    if [ -L "$tgt_path" ] && [ -e "$(readlink "$tgt_path")" ]; then
        echo "$df symlink already exists and is valid"
    else

        echo "$df symlink does not exist or is invalid"

        ln -s "$src_path" "$tgt_path"

        echo "Symlinked $df"
    fi
done

src_pth="$HOME/.dotfiles/upkeep"

tgt_path="/usr/local/bin/upkeep"

if [ -L "$tgt_path" ] && [ -e "$(readlink "$tgt_path")" ]; then
    echo "upkeep symlink already exists and is valid"
else
    echo "upkeep symlink does not exist or is invalid"

    sudo ln -s "$src_path" "$tgt_path"

    echo "Symlinked upkeep"
fi
