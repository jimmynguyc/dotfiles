#!/bin/bash

# vim-plug downloads plugins as git modules and we need to add them manually otherwise git will complain
vimplugdir=.vim/plugged
for d in $vimplugdir/*; do
  pushd $d
  url=$(git remote get-url --push origin)
  popd
  git submodule add -f $url $d
  git config -f .gitmodules submodule."$d".ignore dirty
done
