#!/usr/bin/sh
echo "\e[33m# simple shell script to add the my-commands alias to the alias file\e[0m"
echo '# ~/.bashrc.d/         dir will be created if it does not exist and system is Fedora style'
echo '# ~/.bashrc.d/aliases file will be created if it does not exist and system is Fedora style'
echo '# ~/.bash_aliases file will be created if it does not exist and system is Ubuntu style'

string_fzf="alias my-fzf-commands='chosen_command=\$(cat ~/.dotfiles/my-commands/commands_list.txt | fzf ) ; eval \$chosen_command '"
string_sel="alias my-sel-commands='PS3=\"Select command: \"; mapfile -t items < ~/.dotfiles/my-commands/commands_list.txt; select item in \"\${items[@]}\"; do eval \$item;break; done'"  >> ~/.bash_aliases


fedora_style(){
# for Fedora
    echo '. mkdir -p ~/.bashrc.d'
    mkdir -p  ~/.bashrc.d
    echo '. touch -a ~/.bashrc.d/aliases'
    touch -a  ~/.bashrc.d/aliases

  if grep -Fq  "my-commands"  ~/.bashrc.d/aliases
  then
    echo '. my-commands tag found in file ~/.bashrc.d/aliases; good, do nothing'
  else
    # the key part, adding the alias to the aliases file
    echo '! alias not found in file ~/.bashrc.d/aliases; write it in'
    echo '#### my-commands ####'   >> ~/.bashrc.d/aliases
    echo "$string_fzf"   >> ~/.bashrc.d/aliases
    echo "$string_sel"   >> ~/.bashrc.d/aliases
    # echo "alias my-fzf-commands='chosen_command=\$(cat ~/.dotfiles/my-commands/commands_list.txt | fzf ) ; eval \$chosen_command '"   >> ~/.bashrc.d/aliases
    # echo "alias my-sel-commands='PS3=\"Select command: \"; mapfile -t items < ~/.dotfiles/my-commands/commands_list.txt; select item in \"${items[@]}\"; do eval \$item;break; done'"  >> ~/.bashrc.d/aliases
  fi
}

ubuntu_style(){
  # for Ubuntu style bash_aliases
    echo '. touch -a ~/.bash_aliases'
    touch -a ~/.bash_aliases

  if grep -Fq  "my-commands"   ~/.bash_aliases
    then
      echo '. my-commands tag found in file  ~/.bash_aliases; good, do nothing'
    else
      # the key part, adding the alias to the aliases file
      echo '! alias not found in file ~/.bash_aliases; write it in'
      echo '#### my-commands ####'   >> ~/.bash_aliases
      echo "$string_fzf"   >> ~/.bash_aliases
      echo "$string_sel"   >> ~/.bash_aliases
  fi
}

main_function() {

  if grep -Fq  '~/.bash_aliases'   ~/.bashrc
    then
      echo '. .bashrc calls on .bash_aliases: this system is Ubuntu style'
      ubuntu_style
   fi

  if grep -Fq  '~/.bashrc.d/aliases' ~/.bashrc
    then
      echo '. .bashrc calls on .bashrc.d/aliases: this system is Fedora style'
      fedora_style
  fi
}

#run the main function
main_function
