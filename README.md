# .bash_files

This repo contains basic configuration for a BASH environment. It sets the coloring
to use solarized. if available, enables tab completion for git commands, sets the
prompt and defines some basic path options.

## Installation

To install this package, clone the repo to ~/.bash_files and then symlink the following
files.

    ln -s /path/to/.bash_files/.bash_profile ~/.bash_profile
    ln -s /path/to/.bash_files/.bashrc ~/.bashrc

## Local Changes

In order to make local modifications simply add your local version to ~/.bash_files/local/<name>rc
and then source ~/.bashrc.

