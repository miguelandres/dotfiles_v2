#!/bin/bash

# Notice this is meant to run from dotfiles_v2/, not from dotfiles_v2/mac
cd mac/Workflows/Services || exit 1

for workflow in */
do
	workflow=${workflow%/}
	full_path=$(pwd)/"$workflow"
	ln -s -F -f "$full_path" "$HOME/Library/Services/$full_path"
done
