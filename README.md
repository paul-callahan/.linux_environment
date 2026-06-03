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

## prereqs:
```text
brew install zsh-completions zsh-autosuggestions powerlevel10k fzf
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.linux_environment/zsh/zsh-autosuggestions
```

## fonts
1. Download these four ttf files:
   - [MesloLGS NF Regular.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
   - [MesloLGS NF Bold.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
   - [MesloLGS NF Italic.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
   - [MesloLGS NF Bold Italic.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)
1. Double-click on each file and click "Install". This will make `MesloLGS NF` font available to all
   applications on your system.
1. Configure your terminal to use this font:
   - **iTerm2**: Type `p10k configure` and answer `Yes` when asked whether to install
     *Meslo Nerd Font*. Alternatively, open *iTerm2 → Preferences → Profiles → Text* and set *Font* to
     `MesloLGS NF`.
   - **Apple Terminal**: Open *Terminal → Preferences → Profiles → Text*, click *Change* under *Font*
     and select `MesloLGS NF` family.
See more at https://github.com/romkatv/powerlevel10k/blob/master/README.md#fonts
