#!/bin/bash -e
clear

echo "============================================"
echo "Donni Richasdy Basic Server Installation"
echo "============================================"

echo "Adding Repository ..."
# repo for apt-fast
sudo add-apt-repository -y ppa:saiarcot895/myppa

echo "apt-get updating ..."
sudo apt-get update

echo "Donwload Accelerator Installation"
# aria2 associated to apt-fast
sudo apt-get install -y aria2
sudo apt-get install -y axel

echo "Installing apt-fast ..."
sudo apt-get install -y apt-fast

echo "Installing Git ..."
sudo apt-fast install -y git

echo "Installing curl ..."
sudo apt-fast install -y curl

echo "Installing NerdTree ..."
# http://chrisstrelioff.ws/sandbox/2014/05/29/install_and_setup_vim_on_ubuntu_14_04.html

sudo apt-fast install -y vim
mkdir -p ~/.vim/autoload ~/.vim/bundle

curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# " Pathogen
# execute pathogen#infect()
# call pathogen#helptags() " generate helptags for everything in 'runtimepath'
# syntax on
# filetype plugin indent on

echo -e "set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()

\" Pathogen
execute pathogen#infect()
call pathogen#helptags() \" generate helptags for everything in 'runtimepath'

syntax on
filetype plugin indent on" >> ~/.vimrc


cd ~

echo "========================="
echo "Installation is complete."
echo "========================================"
echo "copyright Donni Richasdy | richasdy.com"
echo "========================================"
echo "========================="

