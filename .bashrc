#
# ~/.bashrc
#

#adding scripts folder to path variable
#export PATH="$PATH:$HOME/Scripts"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#add auto cd when entering a file path
shopt -s autocd
#aliases
alias ls='ls --color=auto'
alias p='sudo pacman'
alias ci3='vim ~/.config/i3/config'
alias cpoly='vim ~/.config/polybar/config'
alias cmpd='vim ~/.config/mpd/mpd.conf'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias clc='clear'
alias school="cd ~/University/'School Year 2019-2020'/'Spring Term'"
alias cPitt="bash ./connectPitt.sh"
#alias thoth="./thoth.sh"
#tab completes both command and file names
complete -cf sudo
PS1='[\u@\h \W]\$ '

#keep at end of file
pfetch
