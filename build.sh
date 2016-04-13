#!/bin/bash

# Gets the absolute path of the directory of this bash script. works in Linux & OSX
# https://gist.github.com/insanity54/fcc93e45cd297e56e1bb
# greets to https://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
# greets to https://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx

function detectplatform {
    platform='unknown'
    unamestr=`uname`
    if [[ "$unamestr" == 'Linux' ]]; then
       platform='linux'
    elif [[ "$unamestr" == 'Darwin' ]]; then
       platform='darwin'
    fi
}

function osxrealpath {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

function getbindir {
    if [[ $platform == 'linux' ]]; then
       echo "$(dirname "$(readlink -fm "$0")")"  # linux
    elif [[ $platform == 'darwin' ]]; then
       echo "$(dirname "$(osxrealpath $0)")"     # osx
    fi
}

detectplatform

rm -r $(getbindir)/roles/ipfs
rm -r $(getbindir)/roles/bootstrap
ansible-galaxy install -r $(getbindir)/requirements.yml -p $(getbindir)/roles
