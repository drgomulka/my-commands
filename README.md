# my-commands
handy commands chooser with fzf or mapfile+select

fzf needs to be installed separately.

## install

Run this:

```sh
git clone https://github.com/drgomulka/my-commands.git ~/.dotfiles/my-commands
~/.dotfiles/my-commands/install_aliases.sh
```
## what does this do

Install script adds two aliases to your aliases file:

* my-commands-fzf
* my-commands-list

## my-commands-fzf

The idea here is to use `fzf` to choose a command from a prepared list of commands and to run it. All that is needed is: fzf installed, one alias and one text file with the list of commands. 

## my-commands-list

When no fzf is installed, the `mapfile` alternative can be used. 
It uses  mapfile -t items to rid the commands_list.txt file. Then it uses the bash select ITEM in [LIST] construct to do the selection of your favourite commands. Select by entering the number from the list.  
