#!/bin/bash

cd ~

echo "Downloading Neurender repository to $(pwd)/neurender"
git clone https://github.com/amoffatt/neurender.git

# Invoke credential request
echo "Enter your username and github Personal Access Token (configured for Content R&W access)"
cd neurender
git config --global credential.helper store

# Configure git name
read -p "Enter your name: " name
read -p "Enter your email address: " email
git config --global user.name "$name"
git config --global user.email "$email"

git push
