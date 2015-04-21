#!/bin/sh

for file in /home/vagrant/.zprezto/runcoms/z*
do
	if [ ! -e /home/vagrant/.${file##*/} ]; then
		ln -s ${file} /home/vagrant/.${file##*/}
	fi
done

