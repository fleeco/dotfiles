#!/bin/bash

# Stow is so much cooler than chezmoi.  I prefer being able to just work in my dotfiles repo and see the changes rather
# than having to constantly chezmoi apply
stow -t ~ */
