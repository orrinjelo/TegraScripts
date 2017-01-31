#!/bin/bash
# Define some colors first:
gray='\[\e[0;30m\]'
red='\[\e[0;31m\]'         
RED='\[\e[1;31m\]'         
yellow='\[\e[0;33m\]'      
YELLOW='\[\e[1;33m\]'      
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
blue='\[\e[0;34m\]'        
BLUE='\[\e[1;34m\]'        
magenta='\[\e[0;35m\]'
MAGENTA='\[\e[1;35m\]'
cyan='\[\e[0;36m\]'        
CYAN='\[\e[1;36m\]'        
NC='\[\e[0m\]'              # No Color
# --> Nice. Has the same effect as using "ansi.sys" in DOS.

#-------------------------------------------------------------
# Shell Prompt                                                
#-------------------------------------------------------------

# are we an interactive shell?
export GIT_PS1_SHOWCOLORHINTS=1
#export PROMPT_COMMAND='__git_ps1 "\u@\h:\W" "\\\$ "'

export PROMPT_COMMAND='__git_ps1 "\u@h:\w" "\\$RUNCH "'

if [ "$PS1" ]; then
  case $TERM in
  xterm*)      
    PROMPT_COMMAND='__git_ps1 "[$CYAN\@$NC] $MAGENTA\u$BLUE@$yellow\h $YELLOW\w$NC" $(if [ $? -ne 0 ]; then echo "$RED\\\$$NC\040 "; else echo "$GREEN\\\$$NC\040 "; fi); printf "\033]0;%s@%s:%s %s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}" $(__git_ps1)'
    ;;                                                                                                                                                   
  screen)                                                                                                                                                      
    PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'                                                                    
    ;;                                                                                                                                                         
  dumb)
    unset PROMPT_COMMAND
    PS1='__git_ps1 "[$CYAN\@$NC] $MAGENTA\u$BLUE@$yellow\h $YELLOW\w$NC" $(if [ $? -ne 0 ]; then echo "$RED\\\$$NC\040 "; else echo "$GREEN\\\$$NC\040 "; fi); printf "\033]0;%s@%s:%s %s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}" $(__git_ps1)'
    ;;
  esac
  # Turn on checkwinsize
  shopt -s checkwinsize
fi

