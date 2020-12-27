#!/usr/bin/env bash

target="$ZSH_CUSTOM/plugins/pfinder"
files="pfinder.plugin.zsh pfGetPath.sh pfsymlinkFromPF.sh pfsymlinkToPF.sh README.md"

# Create the plugin root
[ ! -d $target ] && mkdir $target

# Sync all the release files to $ZSH_CUSTOM
for f in ${files}; do
	rsync -u "$f" "${target}/"
done
