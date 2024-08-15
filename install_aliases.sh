#!/usr/bin/sh
echo -e "\e[31m# simple shell script to add the my-commands alias to the alias file\e[0m"
echo "# ~/.bashrc.d/         dir will be created if it does not exist"
echo "# ~/.bashrc.d/aliases file will be created if it does not exist"
echo "# ~/.bash_aliases file will be created if it does not exist"


fedora_style() {
# for Fedora
  if grep -Fxq  $1    ~/.bashrc.d/aliases
  then
    echo ". alias found in file ~/.basrc.d/aliases; good, do nothing"
  else
    echo "! alias not found in file ~/.basrc.d/aliases; write it in"
    echo $1   >> ~/.bashrc.d/aliases
  fi


}

ubuntu_style(){


# for Ubuntu
 if grep -Fxq  $1   ~/.bash_aliases
  then
    echo ". alias found in file  ~/.bash_aliases; good, do nothing"
  else
    echo "! alias not found in file ~/.bash_aliases; write it in"
    echo $1   >> ~/.bash_aliases
  fi
}



main_function() {

  # making sure the dir for aliases exists
  if [ -d ~/.bashrc.d ] ; then
    echo ". directory ~/.bashrc.d         exists, good."
  else
    echo ". mkdir ~/.bashrc.d"
    mkdir  ~/.bashrc.d
  fi

  # making sure the aliases file exists for Fedora
  if [ -f ~/.bashrc.d/aliases ]
  then
    echo ". file      ~/.bashrc.d/aliases exists, good."
  else
    echo ". touch  ~/.bashrc.d/aliases"
    touch  ~/.bashrc.d/aliases
  fi

  # making sure the aliases file exists for Ubuntu
  if [ -f ~/.bash_aliases ]
  then
    echo ". file      ~/.bash_aliases exists, good."
  else
    echo ". touch  ~/.bash_aliases"
    touch  ~/.bash_aliases
  fi

  # the key part, adding the alias to the aliases file
  line_to_add_to_aliases="alias my-commands='chosen_command=\$(cat ~/.dotfiles/my-commands/commands_list.txt | fzf ) ; eval \$chosen_command '"

fedora_style "$line_to_add_to_aliases"

ubuntu_style "$line_to_add_to_aliases"

}




#run the main function
main_function
