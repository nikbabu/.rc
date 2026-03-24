############################################################
# HW Design default .cshrc file:
#
# Your environment setup files should consist of: .login ,  .cshrc , .my_cshrc 
#
# Preferably, .login and .cshrc files should remain untouched, and all user modifications 
# should be done to .my_cshrc file, including any alias setups and such. 
#
# The .my_cshrc file is sourced as the last command in the '.cshrc' file. This way, future 
# updates to .cshrc and .login files (as a result of environment changes) can be done without 
# any loss to user's own customizations.
#
#
#
############################################################
if ( $?login ) then
    unsetenv LOADEDMODULES*
    unsetenv _LMFILES_*
endif

if ( -e /usr/hw-tools/Modules_tcl/bin/modulecmd ) then

    source /usr/hw-tools/Modules_tcl/init/tcsh
    module add jni 

else

    if ($?prompt) then
        echo "*** Modules NOT found, using static env setup ***"
    endif

    set path = (/bin . /usr/local/bin /usr/ucb /usr/bin /sbin)
    set path = ($path /usr/sbin /usr/openwin/bin/ /usr/ccs/bin /usr/ccs/lib)

endif

#
#
#  misc things Modules does not setup (e.g. default editor, printer)

setenv EDITOR vi
setenv PRINTER your_printer_name  # change your_printer_name to something valid

set history = 400
limit coredumpsize 0
set filec

####################################
#
# Now source customizations:
#

if ( -e ~/.my_cshrc ) then
	source ~/.my_cshrc
endif


########################################## .my_cshrc

#!/bin/tcsh
if ($?prompt) then
set history=400                        # save last 400 commands
set savehist=20
set ellipsis
set nobeep
set autolist 
set autoexpand
set implicitcd
set color
set colorcat
set complete=enhance
set correct=all


setenv LESS Ri
setenv LANGUAGE en_US.UTF-8
setenv LANG en_US.UTF-8
setenv LC_ALL en_US.UTF-8
#set prompt = '%{\033[32m%}%M%{\033[37m%}:%{\033m%}%/%{\033[31m%} %! %{\033[35m%}$ ->%{\033[0m%} '
#set prompt='[%T]%n@%m %c3: '
set prompt = '%{\033[34m%}[%T]%{\033[32m%}%M%{\033[37m%}:%{\033m%}%c3 %{\033[35m%}:%{\033[0m%} '
set rprompt = '%{\033[32m%} %B%$WORKAREA%b%{\033[0m%}'


#module add keychain
####source /etc/profile.d/vte.sh
bindkey -k up history-search-backward
bindkey -k down history-search-forward
source  /usr/hw-tools/perforce/misc/p4-completion.csh
if ($?DISPLAY) then
module add vim
module add zellij/0.43.1
module unload nc
##module add perforce/2024.2
endif


## Fix for bracketed paste mode - ensure it is disabled at prompt and exec
## This prevents garbage characters when pasting if the mode was left on
##alias precmd 'printf "\033[?2004l"'
alias postcmd 'printf "\033[?2004l"'

source ~/.aliases.tcsh
module reload
endif

##test ! -e "$HOME/.x-cmd.root/local/data/tcsh/rc.tcsh" || source "$HOME/.x-cmd.root/local/data/tcsh/rc.tcsh" # boot up x-cmd.
##setenv ZELLIJ_AUTO_ATTACH 1




alias h history
alias ll "ls -alrt"
alias l ls-F
alias d dirs -v
alias tmuxa "tmux attach || tmux new"
alias c clear
alias p pwd
alias meld /usr/hw-tools/scripts/meld-1.8.6/bin/meld

#alias killsuspended 'bhist -s -u $USER |awk '\''{print $1}'\''| grep -v Summary | grep -v JOBID | xargs bkill'
#alias killpending 'bhist -p -u $USER |awk '\''{print $1}'\'' | grep -v Summary | grep -v JOBID | xargs bkill'

# Alias 'g' points to the gvim_wrapper script that handles file size checking
alias g '/homes/babun/.g_wrapper '
alias vi vim 

#alias vi /usr/bin/vim 
alias rg grep --color=always -ris --exclude-dir=run
alias pd- pushd +1 
alias pd 'pushd -v \!*'
#alias unlinkall "find -maxdepth 1 -type l -exec unlink {} \;"
#alias cleanlsf "ls -1t *lsfinfo | tail -n +5 | xargs -d '\n' rm" 
#alias biggest "du -sb * | sort -nr | cut -f2 | xargs du -sh"
#alias big10   "du -sb * | sort -nr | head | cut -f2 | xargs du -sh"
alias resource "~/.cshrc"
#alias cleandir " rm -r *simv* csrc* DVE* *_regress;rm *.* ;"
alias   cwdcmd  'setenv WORKAREA `/usr/hw-tools/scripts/getWORKAREA`'
setenv BFVerif  "/volume/bf-verif01/users/babun" 
setenv KFVerif  "/volume/kf-verif-s02/users/babun" 
setenv KFVerif1  "/volume/kf-verif01/users/babun" 
setenv XTVerif  "/volume/xt-verif-s2/users/babun" 
setenv XTVerif1 "/volume/xt-verif-s1/users/babun" 
alias bfverif   " cd /volume/bf-verif01/users/babun  " 
alias kfverif   " cd /volume/kf-verif01/users/babun  " 
alias xtverif   " cd /volume/xt-verif-s2/users/babun " 
alias xtverif1  " cd /volume/xt-verif-s1/users/babun " 
alias tcg_verif 'pd ${WORKAREA}/*/verif/*/*_tcg '
alias wo_verif  'pd ${WORKAREA}/*/verif/*/*_cell_wo'
alias fc_verif  'pd ${WORKAREA}/*/verif/*/*chip'


#alias  vnc_start 'vncserver -randr 3840x2160,3840x2000,3440x1440,2000x1200,1920x1080,1600x1200,1440x900,1024x768,1920x1015,2560x1375 -depth 24 -geometry 1920x1015 \!* '
alias disp1 'xrandr -s 2056x1285_vnc'
alias disp2 'xrandr -s 1920x1080_vnc'



alias dvt 'nc run -I -C simvision  dvt.sh -heap_size 16G -l /tmp/babun/dvt_log &> /tmp/babun_dbus'
alias srvr_ld ' grep --color=always "load average\|SERVER: " /usr/hw-tools/juniper/data/shellserver_user_list.dat'
alias my_vnc ' egrep "Current_VNC" /usr/hw-tools/juniper/data/shellserver_user_list.dat | grep $user'
################### MY ENV Variables 


setenv LD_LIBRARY_PATH "$HOME/local/lib:${LD_LIBRARY_PATH}"
setenv PATH "$HOME/bin:$HOME/local/bin:${PATH}"

unsetenv EDITOR
setenv EDITOR "gvim -f"


### Get Date in local timezone
setenv TZ Asia/Kolkata

if ($?DISPLAY) then
  if ($DISPLAY =~ "${HOSTNAME}:"*) then
  else
    setenv DISPLAY `hostname`$DISPLAY
  endif
else 
  if ($?DISPLAYNUM) then
    setenv DISPLAY `hostname`:$DISPLAYNUM
  endif
endif


###alias FC_chk 'jrun.pl -queue KF -vcomp "+define+JNPR_BLOCK_COVER_OFF" -build_rusage "mem=10000" -lsf_rusage "mem=10000" -regress $WORKAREA/$TREE/verif/kf/kfchip/tests/regress/kfchip_ci.regress'

if ( ! $?DISPLAY ) then
    if ( -d ~/.vnc ) then
        set latest_log = `ls -t ~/.vnc | grep "^${HOSTNAME}:.*\.log" | head -1`
        if ( "$latest_log" != "" ) then
            setenv DISPLAY $latest_log:r
        endif
    endif
endif



# remove the #.


#unset ignoreeof			# enable ^D for logout

# misc. home-grown commands:
#alias killsuspended 'bhist -s -u nikbabu |awk '\''{print $1}'\''| grep -v Summary | grep -v JOBID | xargs bkill'
#alias killpending 'bhist -p -u nikbabu |awk '\''{print $1}'\'' | grep -v Summary | grep -v JOBID | xargs bkill'
alias g gvim
alias vi /usr/bin/vim 
alias rgrep grep -ris
alias pd- pushd +1 
alias pd 'pushd -v \!*'
alias ncat sed \' \!:1 p \' -n \!:2 
alias unlinkall "find -maxdepth 1 -type l -exec unlink {} \;"
#alias cleanlsf "ls -1t *lsfinfo | tail -n +5 | xargs -d '\n' rm" 
alias biggest "du -sb * | sort -nr | cut -f2 | xargs du -sh"
alias big10   "du -sb * | sort -nr | head | cut -f2 | xargs du -sh"
#alias cleandir " rm -r *simv* csrc* DVE* *_regress;rm *.* ;"
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
#alias ns 'perl  /ws/disreedh-sjc/dopplere/bin/search_notes.pl --search'
#alias na 'perl /ws/disreedh-sjc/dopplere/bin/search_notes.pl --add'
#o
##PS1="\u@\h\$"'\[\033k\033\\\]'
##export PS1
# Source other rc files after this line.
