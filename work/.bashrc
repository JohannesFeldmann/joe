# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# switch off bluetooth
#rfkill block bluetooth

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#OWN COMMANDS

EDITOR="/usr/bin/emacsclient -a vi"

#General
alias apt='sudo apt-get install'

#PIK related
alias pik='ssh -CX johfeld@cluster.pik-potsdam.de'
alias pik1='ssh -CX johfeld@cluster01.pik-potsdam.de'
alias pik2='ssh -CX johfeld@cluster02.pik-potsdam.de'
alias tunnel='ssh -D9999 johfeld@cluster.pik-potsdam.de'
alias cluster='sshfs -C johfeld@cluster.pik-potsdam.de:/home/johfeld/ ~/cluster/'
alias scratch='sshfs -C johfeld@cluster.pik-potsdam.de:/scratch/ ~/scratch/'
alias cluster_all='sshfs -C johfeld@cluster.pik-potsdam.de:/home/ ~/cluster_all/'
alias iplex='sshfs -C johfeld@cluster.pik-potsdam.de:/iplex/ ~/iplex/'

alias pikdirs='scratch cluster iplex'
#shortcut directories (when "cluster"/"scratch" command is active)
alias sub='cd ~/cluster/pismpik02/src/pik/submission/submission_pig'
alias res02='cd ~/scratch/01/johfeld/pismoutput/pismpik02/'
alias res05='cd ~/scratch/01/johfeld/pismOut/pism05/'
alias ana='cd ~/cluster/pismpik02/pine_island/pig_analysis/'
alias fan_old='cd ~/cluster/pismpik02/pine_island/pig_analysis/FAN2'
alias src='cd ~/cluster/pismpik02/src/'
alias set='cd ~/cluster/pismpik02/pine_island/pig_setup/'
alias exp='cd ~/cluster/pismExperiments/'
alias tum='cd ~/iplex/01/tumble/johfeld/'
alias fan='cd ~/scratch/01/johfeld/pismOut/fans'
alias boot='cd ~/iplex/01/tumble/johfeld/pismInputFiles/pism05/PIG'

#applications
alias nc='ncview'
alias ok='okular'

alias yrm='yes | rm'
alias up='source ~/.bashrc | echo now executing ~/.bashrc'
alias cd..='cd ..'
alias rotation='jhead -autorot *.JPG' #rotate all .jpg-pictures in current folder
alias qqshowresults='ncview results/y*.nc &'

function cpnew () {
  mkdir ../$1
  cp runPism.sh ../$1
  cp subm.cmd ../$1
}

function cpst () {
  mkdir ../$1
  cp runPism_original.sh ../$1
  cp subm.cmd ../$1
  cp paramstudy ../$1
}

#PETSc 
#export PETSC_DIR=/usr/lib/petsc-3.1-p8
# export PETSC_DIR=/usr/lib/petscdir/3.1

# export PETSC_ARCH=linux-gnu-c-opt all
#export PETSC_ARCH=linux-gnu-c-opt all
#export PATH=$PETSC_DIR/externalpackages/mpich2-1.0.8/bin:$PATH

#PISM

#stable0.4
#export PETSC_DIR=/usr/lib/petsc-3.1-p8
#export PETSC_ARCH=linux-gnu-c-opt test
#export PATH=/usr/lib/petsc-3.1-p8/externalpackages/mpich2-1.0.8/bin/:$PATH
#export PATH=/home/joe/pism0.4/bin:$PATH

#Petsc with mpich
#petsc-3.2
export PETSC_DIR=/home/joe/soft/petsc-3.2-p7
export PETSC_ARCH=arch-linux2-c-opt
#export PATH=/usr/lib/petsc-3.1-p8/externalpackages/mpich2-1.0.8/bin/:$PATH

#petsc-3.1
#export PETSC_DIR=/home/joe/soft/petsc-3.1-p8
#export PETSC_ARCH=linux-gnu-c-opt
#export PATH=/usr/lib/petsc-3.1-p8/externalpackages/mpich2-1.0.8/bin/:$PATH
export PATH=$PETSC_DIR/$PETSC_ARCH/bin:$PATH
export PATH=/home/joe/pism05/bin/:$PATH
export PISM_PREFIX=/home/joe/pism05/bin/

#USE THIS MPI-VERSION:
#alias mpiexec "/home/joe/soft/petsc-3.2-p7/arch-linux2-c-opt/bin/mpiexec -n"

#stable0.5
export PISM_MPIDO="/home/joe/soft/petsc-3.2-p7/arch-linux2-c-opt/bin/mpiexec -n"

#stable0.5
#export PETSC_DIR=/usr/lib/petsc-3.2-p7
#export PETSC_ARCH=linux-gnu-opt 
#export PATH=$PETSC_DIR/$PETSC_ARCH/bin/:$PATH
#export PATH=/home/joe/pism0.5/bin:$PATH

#GIT
alias git='/usr/bin/git'
alias co='checkout'

#PISM codework
function pismedit () {
  cluster
  kate --start pismedit 
}

#ferret path
export PATH=~/soft/ferret/bin:$PATH
export PATHS=~/soft/ferret/ferret_paths:$PAT

#add to PATH
#export PATH=home/joe/soft:$PATH
export PATH=/home/joe/soft/texlive/2012/bin/i386-linux:$PATH
