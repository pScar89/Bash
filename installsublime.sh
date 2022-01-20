#!/bin/bash

mkdir /usr/local/share/keyrings
mkdir /home/beast/tempdir

wget https://download.sublimetext.com/sublimehq-pub.gpg -P /home/beast/tempdir

gpg --no-default-keyring --keyring /home/beast/tempdir/temp-keyring.gpg --import /home/beast/tempdir/sublimehq-pub.gpg
gpg --no-default-keyring --keyring /home/beast/tempdir/temp-keyring.gpg --export --output /home/beast/tempdir/sublimeKey.gpg

cp /home/beast/tempdir/sublimeKey.gpg /usr/local/share/keyrings/

echo "deb [signed-by=/usr/local/share/keyrings/sublimeKey.gpg] https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

rm -r /home/beast/tempdir

apt-get update -y
apt-get install sublime-text -y