#!/bin/zsh

packages=(
    "cjson"
    "cmake"
    "csvlens"
    "gcc"
    "gh"
    "git"
    "glow"
    "gradle"
    "jq"
    "lazygit"
    "libgit2"
    "make"
    "ncurses"
    "neofetch"
    "neovim"
    "node"
    "pkg-config"
    "powerlevel10k"
    "qt@5"
    "ripgrep"
    "sdl2"
    "tldr"
    "tree"
    "wget"
    "xmake"
    "zig"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

brew install "${packages[@]}"
