#
#  So much of this is based off of:
#  http://natelandau.com/my-mac-osx-bash_profile/
#
#  Editor is set to Atom...
#
alias edit='atom'                           # edit:         Opens any file in atom

# general aliases
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias fancy="git diff --color | diff-highlight | diff-so-fancy"

httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}


#   ---------------------------
#   4.  SEARCHING
#   ---------------------------


alias qfind="find . -iname "                 # qfind:    Quickly search for file

dfind () {
    echo "Directory find, case insensitive, wildcarded contains search:"
    find -type d -iname "*$1*"
}

#most commonly used grep


#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
  echo -e "\nYou are logged on ${RED}$HOST"
  echo -e "\nAdditionnal information:$NC " ; uname -a
  echo -e "\n${RED}Users logged on:$NC " ; w -h
  echo -e "\n${RED}Current date :$NC " ; date
  echo -e "\n${RED}Machine stats :$NC " ; uptime
  echo -e "\n${RED}Current network location :$NC " ; scselect
  echo -e "\n${RED}Public facing IP Address :$NC " ;myip
  #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
  echo
}


#
#  NPM globals on a new system
#

npmglobals() {
  echo "Installing npm modules globally:"
  sudo npm install -g bower
  sudo npm install -g node-debug
  sudo npm install -g grunt-cli
  sudo npm install -g gulp
  sudo npm install -g express-generator
  sudo npm install -g yo

}



#################################
#### WORK STUFF
#################################

CUBE_DIR="C:/Development/gitproj/cube-env/"
DYNAMIS_DIR="C:/Development/gitproj/Dynamis"

mklinks() {
  ln -s $DYNAMIS_DIR dynamis
  ln -s $CUBE_DIR cube
}

### worj dev env
pullcubemaster() {
  cd $CUBE_DIR

  echo "Cube common"
  cd cube-common
  git checkout master
  git pull upstream master
  cd ..

  echo "Cube Impl"
  cd cube-impl
  git checkout master
  git pull upstream master
  cd ..

  echo "Cube WS Clients"
  cd cube-ws-clients
  git checkout master
  git pull upstream master
  cd ..

  echo "Cube mt container"
  cd cube-mt-container
  git checkout master
  git pull upstream master
  cd ..

  echo "Cube resources"
  cd cube-resources
  git checkout master
  git pull upstream master
  cd ..
}


### worj dev env
pullcube() {
  cd $CUBE_DIR

  echo "Cube common"
  cd cube-common

  git pull upstream master
  cd ..

  echo "Cube Impl"
  cd cube-impl
  git pull upstream master
  cd ..

  echo "Cube WS Clients"
  cd cube-ws-clients
  git pull upstream master
  cd ..

  echo "Cube mt container"
  cd cube-mt-container
  git pull upstream master
  cd ..

  echo "Cube resources"
  cd cube-resources
  git pull upstream master
  cd ..
}


pushcubeoriginmaster() {
  cd $CUBE_DIR

  echo "Cube common"
  cd cube-common
  git checkout master
  git push origin master
  cd ..

  echo "Cube Impl"
  cd cube-impl
  git checkout master
  git push origin master
  cd ..

  echo "Cube WS Clients"
  cd cube-ws-clients
  git checkout master
  git push origin master
  cd ..

  echo "Cube mt container"
  cd cube-mt-container
  git checkout master
  git push origin master
  cd ..

  echo "Cube resources"
  cd cube-resources
  git checkout master
  git push origin master
  cd ..
}


pushcubeorigincurrent() {
  cd $CUBE_DIR

  echo "Cube common"
  cd cube-common
  git push
  cd ..

  echo "Cube Impl"
  cd cube-impl
  git push
  cd ..

  echo "Cube WS Clients"
  cd cube-ws-clients
  git push
  cd ..

  echo "Cube mt container"
  cd cube-mt-container
  git push
  cd ..

  echo "Cube resources"
  cd cube-resources
  git push
  cd ..
}




# Git opts
configgit() {
  git config --global core.editor nano
  git config --global url."https://".insteadOf git://
  # lol ... work
  git config --global http.sslVerify false
  # save password, for HTTPS access
  git config --global credential.helper store
}

pulldynamis() {
  cd $DYNAMIS_DIR
  git stash
  git pull upstream master
  git stash apply

  echo "Done with dynamis update"

}

pushdynamisorigin() {
  cd $DYNAMIS_DIR
  git push origin master

}
