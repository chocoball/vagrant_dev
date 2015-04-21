#!/bin/sh

sed -i -e "s/sorin/clint/g" /home/vagrant/.zpreztorc
sed -i -e "/zstyle ':prezto:load' pmodule/a\\  'history-substring-search' \\\\" /home/vagrant/.zpreztorc
sed -i -e "s/emacs/vi/g" /home/vagrant/.zpreztorc
sed -i -e "s/nano/vim/g" /home/vagrant/.zprofile

