#!/usr/bin/sh
echo -e "\e[31m# simple shell script to add the my_commands alias to the alias file\e[0m"
echo "# ~/.bashrc.d/         dir will be created if it does not exist"
echo "# ~/.bashrc.d/aliases file will be created if it does not exist"


main_function() {

  # making sure the dir for aliases exists
  if [ -d ~/.bashrc.d ] ; then
    echo ". directory ~/.bashrc.d         exists, good."
  else
    echo ". mkdir ~/.bashrc.d"
    mkdir  ~/.bashrc.d
  fi

  # making sure the aliases file exists
  if [ -f ~/.bashrc.d/aliases ]
  then
    echo ". file      ~/.bashrc.d/aliases exists, good."
  else
    echo ". touch  ~/.bashrc.d/aliases"
    touch  ~/.bashrc.d/aliases
  fi

  # the key part, adding the alias to the aliases file
  line_to_add_to_aliases="alias my-commands='chosen_command=$(cat ~/.dotfiles/my-commands/commands_list.txt | fzf ) ; eval $chosen_command '"

  if grep -Fxq  "$line_to_add_to_aliases"   ~/.bashrc.d/aliases
  then
    echo ". alias found in file aliases; good, do nothing"
  else
    echo "! alias not found in file aliases; write it in"
    echo "$line_to_add_to_aliases"  >> ~/.bashrc.d/aliases
  fi

}

main_function
