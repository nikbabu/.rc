# Generic $dotdir/cshrc_USER
# Engineering Services (ES)
#
# Replace this file with your department's custom cshrc_USER file, if any.

##
# Things the user might wish to set.

umask 002				       # no write by group or other

## sample code that you may want to activate or modify:
# The following variables are already configured with the default values in
# the cshrc file. To activate a command line that's been "commented out",
# remove the #.
set history=200                        # save last 200 commands
set savehist=20
#unset ignoreeof			# enable ^D for logout
#set prompt="${USER}@${HOST}% "                 # shell prompt format
set ellipsis
set nobeep
set prompt = "%n@%B%c3%b%>"
# misc. home-grown commands:
alias h history
alias ll "ls -al"
alias l ls-F
alias d dirs -v
alias tmuxa "tmux attach || tmux new"
set autolist 
set color
set colorcat
set complete=enhance
set correct=all
alias c clear
alias p pwd
alias killsuspended 'bhist -s -u nikbabu |awk '\''{print $1}'\''| grep -v Summary | grep -v JOBID | xargs bkill'
alias killpending 'bhist -p -u nikbabu |awk '\''{print $1}'\'' | grep -v Summary | grep -v JOBID | xargs bkill'
alias g gvim
alias vi /usr/bin/vim 
alias rgrep grep -ris
alias pd- pushd +1 
alias pd 'pushd -v \!*'
alias ncat sed \' \!:1 p \' -n \!:2 
alias unlinkall "find -maxdepth 1 -type l -exec unlink {} \;"
alias cleanlsf "ls -1t *lsfinfo | tail -n +5 | xargs -d '\n' rm" 
alias biggest "du -sb * | sort -nr | cut -f2 | xargs du -sh"
alias big10   "du -sb * | sort -nr | head | cut -f2 | xargs du -sh"
alias cleandir " rm -r *simv* csrc* DVE* *_regress;rm *.* ;"
if ( -f ~/.inputrc ) source ~/.inputrc
if ($?DISPLAY) then
  #vncconfig -nowin &
#else if ($?STY) then
#  echo "Already In screen. Not reattaching"
#else
#  echo "Attaching to Screen"
#  screen -d -r
#endif
endif
##
#if [[$PATH == ?*fluxbox?]]
#setenv PATH $PATH":$HOME/share:$HOME/stage/usr/local/share/fluxbox/styles"
alias  GPBC pushd /auto/dopplere/view/head_dopplere_G0\!:1/pbc
alias  GTOP pushd /auto/dopplere/view/head_dopplere_G0\!:1/top
alias ns 'perl  /ws/disreedh-sjc/dopplere/bin/search_notes.pl --search'
alias na 'perl /ws/disreedh-sjc/dopplere/bin/search_notes.pl --add'
#o
##PS1="\u@\h\$"'\[\033k\033\\\]'
##export PS1
# Source other rc files after this line.
