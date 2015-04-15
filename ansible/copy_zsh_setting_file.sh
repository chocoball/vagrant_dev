#!/bin/sh

for file in /home/vagrant/.zprezto/runcoms/z*
do
	ln -s ${file} /home/vagrant/.${file##*/}
done

