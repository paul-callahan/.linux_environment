# .linux_environment

bash:
```shell
cd ~
cp .bash_profile .bash_profile.bak
cp .bashrc .bashrc.bak

ln -s .linux_environment/bash/.bash_profile
ln -s .linux_environment/bash/.bashrc
```

or zsh
```shell
mv ~/.zshenv ~/.zshenv.bak
~/.linux_environment/zsh/make_links.sh
```

prereqs:
```text
brew install zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.linux_environment/zsh/zsh-autosuggestions
git clone powerlevel10k into /usr/local
```
