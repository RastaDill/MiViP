# MiViP
Minimum Vim set for Python

## Install for GNU\Linux
For install script do command:  
```bash
cp ./.vimrc ~/.vimrc
```
If have nvim:  
```bash
mkdir ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
```

### Packages requirement:
* [python3-jedi](https://github.com/davidhalter/jedi)
* [python3-flake8](https://gitlab.com/pycqa/flake8)
* python3-neovim (or [pynvim](https://github.com/neovim/pynvim))
* manager plugins [Plug](https://github.com/junegunn/vim-plug)

After install all requirement packages open nvim and do command:
```bash
:PlugInstall
```
Reboot nvim
Enjoy
