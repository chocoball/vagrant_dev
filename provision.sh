#!/usr/bin/env bash


home=/home/vagrant


###############################################################################
# install apt package
###############################################################################
apt-get update -y
apt-get install -y git tmux zsh htop vim gcc make openssl libssl-dev
apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev libffi-dev
apt-get install -y libcurl4-gnutls-dev libpng3 libjpeg-dev re2c libxml2-dev
apt-get install -y libtidy-dev libxslt-dev libmcrypt-dev libssl-dev



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
# install Python development environment
###############################################################################
if [ ! -d ${home}/.pyenv ]; then
    git clone https://github.com/yyuu/pyenv.git ${home}/.pyenv
    mkdir -p ${home}/.pyenv/versions ${home}/.pyenv/shims

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ${home}/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ${home}/.bashrc
    echo 'eval "$(pyenv init -)"' >> ${home}/.bashrc

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ${home}/.zshenv
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ${home}/.zshenv
    echo 'eval "$(pyenv init -)"' >> ${home}/.zshenv


    git clone https://github.com/yyuu/pyenv-virtualenv.git ${home}/.pyenv/plugins/pyenv-virtualenv

    echo 'eval "$(pyenv virtualenv-init -)"' >> ${home}/.bashrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ${home}/.zshenv
fi

###############################################################################
# install Ruby development environment
###############################################################################
if [ ! -d ${home}/.rbenv ]; then
    git clone https://github.com/sstephenson/rbenv.git ${home}/.rbenv

    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ${home}/.bashrc
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ${home}/.zshenv

    echo 'eval "$(rbenv init -)"' >> ${home}/.bashrc
    echo 'eval "$(rbenv init -)"' >> ${home}/.zshenv


    git clone https://github.com/sstephenson/ruby-build.git ${home}/.rbenv/plugins/ruby-build
fi



###############################################################################
# get dropbox
###############################################################################
if [ ! -d ${home}/.dropbox-dist ]; then
    cd ${home} && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    echo execute ./dropbox-dist/dropboxd
fi

###############################################################################
# get truecrypt
###############################################################################
if [ ! -f /tmp/truecrypt.tar.gz ]; then
    cd ${home}
    wget -O truecrypt.tar.gz "http://downloads.sourceforge.net/project/truecrypt/TrueCrypt/Other/TrueCrypt-7.2-Linux-console-x64.tar.gz?r=http%3A%2F%2Ftruecrypt.sourceforge.net%2FOtherPlatforms.html&ts=1429708695&use_mirror=cznic"
    tar zxf truecrypt.tar.gz
    rm -rf truecrypt.tar.gz
    echo execute ./truecrypt-7.2-setup-console-x64
fi

###############################################################################
# default shell set to zsh
###############################################################################
chsh -s /usr/bin/zsh vagrant

###############################################################################
# change owner to vagrant
###############################################################################
chown -R vagrant:vagrant ${home}/

