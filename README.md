# .bash_files

This repo contains basic configuration for a BASH environment. It sets the 
coloring to use solarized. if available, enables tab completion for git 
commands, sets the prompt and defines some basic path options.

## Installation

To install this package, clone the repo to `~/.bash_files` and then symlink the
following files.

    $ git clone git@github.com:PhiloEpisteme/.bash_files.git ~/.bash_files
    # Backup your old settings. 
    $ cp ~/.bash_profile ~/.bash_profile_old 
    $ cp ~/.bashrc ~/.bashrc_old
    # Remove once installation is confirmed
    $ ln -s /path/to/.bash_files/.bash_profile ~/.bash_profile
    $ ln -s /path/to/.bash_files/.bashrc ~/.bashrc
    # Close all terminal windows or type `source ~/.bash_profile` in each.

## Local Changes

In order to make local modifications simply add your local version to 
`~/.bash_files/local/<name>rc` and then source `~/.bashrc`.

If you have local settings in your profile and/or rc files you can keep them by
moving them into `~/.bash_file/local` and ensure they end in rc. These will
automatically be sourced after the settings in these files and wil therefore
override any settings provided by this project.

### Note
If your original `~/.bash_profile` sources your original `~/.bashrc` you can move
your `~/.bashrc to ~/.bash_files/local/rc_local` and then move `~/.bash_profile`
to `~/.bash_files/local/bash_profile_rc` and change it to source `rc_local`
