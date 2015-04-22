#!/usr/bin/env bash


home=/home/vagrant


###############################################################################
# install apt package
###############################################################################
apt-get update -y
apt-get install -y git tmux zsh htop vim


###############################################################################
# cloning prezto
###############################################################################
if [ ! -d ${home}/.zprezto ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ${home}/.zprezto
fi

###############################################################################
# create sym-link zsh setting files
###############################################################################
for file in ${home}/.zprezto/runcoms/z*
do
    if [ ! -e ${home}/.${file##*/} ]; then
        ln -s ${file} ${home}/.${file##*/}
    fi
done

###############################################################################
# default shell set to zsh
###############################################################################
chsh -s /usr/bin/zsh vagrant

###############################################################################
# copy configration files
###############################################################################
cp -f /vagrant/conf/tmux.conf ${home}/.tmux.conf
cp -f /vagrant/conf/vimrc ${home}/.vimrc

###############################################################################
# create .vim/bundle directory
###############################################################################
if [ ! -d ${home}/.vim/bundle ]; then
    mkdir -p ${home}/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ${home}/.vim/bundle/neobundle.vim
fi

###############################################################################
# zpreztorc modified
###############################################################################
if [ ! -e ${home}/zpreztorc_modified ]; then
    sed -i -e "s/sorin/clint/g" ${home}/.zpreztorc
    sed -i -e "/zstyle ':prezto:load' pmodule/a\\  'history-substring-search' \\\\" ${home}/.zpreztorc
    sed -i -e "s/emacs/vi/g" ${home}/.zpreztorc
    sed -i -e "s/nano/vim/g" ${home}/.zprofile
    touch ${home}/zpreztorc_modified
fi


###############################################################################
# change owner to vagrant
###############################################################################
chown -R vagrant:vagrant ${home}/

