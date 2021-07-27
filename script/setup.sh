#!/bin/sh
# Bootstrap a Salt system
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/saltdotac/dotfiles/master/script/setup)"

# ref: https://askubuntu.com/a/30157/8698
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Commands that you don't want running as root would be invoked
# with: sudo -u $real_user
# So they will be run as the user who invoked the sudo command

echo "Bootstrapping a Salt system..."

read -p 'Github token: ' gh_token

# TODO automate installing CLI dev tools

# Get the dotfiles
cd ~
git init
git remote add origin https://github.com/saltdotac/dotfiles.git
git pull origin master

# Install brewfile
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

# Setup ssh
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/github_ed25519 -C "aloha@salt.ac"
gh auth login --with-token gh_token
gh ssh-key add github_ed25519 -t 'nomnom'

# Install NVM + Node

# TODO Automate changing Capslock to Cntl (https://apple.stackexchange.com/questions/13598/updating-modifier-key-mappings-through-defaults-command-tool)

echo "
                                                                                
                                                                                
                              ..                ...                             
                             ...                ...                             
                           ..DD.              ..OZ..                            
                         ...8888...           .8ZZZ..                           
                         ..888888.            8ZZZZZ.                           
                         .D8888888.         .$8OZZZZZ..                         
                       ..N88888888D..    ....Z8888ZZDN.                         
                       ..88888888887.    ...OZ8O888888+                         
                       .88888888888Z~.   ..ZZZ888888888O..                      
                    ...8888888888ZZZZ.....ZZZO88888888ZZ,.                      
                    ..88888888OOZZZZZZ...ZOZOZ88888ZZZZZZ.                      
                  ...8888888ZZZZZZZZZZO...OOOZ888OZZZOZOZZ..                    
                   .88888ZZZZZZZZZZZOOOO...OZZZZZZZZZZZZZZZ...                  
                   D88888ZOZZZZZZZZOOOOZO..,ZZZZZZZZZZZZZZZO..                  
                . ZZ888888ZZZOZZZZZOZOOZZZ..+OZZZZZZZZZZZZZZZ.                  
                .ZZZZZZ888OZOOZZZZZOZOOZZOZ..8ZZZZZZZZZZZZ$7$7...               
                8ZZZZZZZZOOZZ+8OOOOZZZZZZOZO..$ZZ.ZZZZZZ$$7$77Z..               
             ..7ZZZZZZZZZOOZ8..8ZZZZZZZOOZZZO..O..+ZZZZZZ$$7$7$$.               
             .DZZZZZZZZZZOZ8..  ZZZZZZZZ$ZZZZ8..   8ZZZZ$ZZZZ$$$O..             
             +OOZZZZZZZZZOZ...  .ZZZZ$$ZZ$ZZZZ$..  .8ZZZ$ZZ$7$7ZZ+.             
           ..DOZZZZZZZZZZZ.   .D..ZZZ$Z$ZZZZZZ78   ..OZZZ$$7$$$$$$.             
         ...8OOZZZZZZZZZZ  .. OZ...ZZZZZZZZZ$Z77...  .$ZZZZZ$$$ZZZZ..           
         ..O88OZZZZZZZZO.  ..8ZZO. .OZZZ$$77$$777..  ..ZZZZZZZZZZZZZ.           
         .ZZZZOZZZZZZZZ..  .?ZZZZZ...$$77Z77Z77777......ZZZZZZZZZZZZZ...        
      ...ZZZO$Z7ZZZZZZ.  ...ZZZZZZ7 .,Z$Z7IZ7777777..  ..ZZZZZZZZZO+OZ..        
      ..ZZZZ$$$7777ZZ.    .77ZZ77777. ........,,,:~=.  ...ZZZZZZZZO???+.        
      .O$ZZZZ$Z77777......77777777777..  ..................$ZZZZZZO?????..      
    ..ZZZZZZZZ$7777777$..777777777777Z....77777777777777ZZZZZZZZZZO??????.      
    .$7$Z$Z77777777777..7??777777????+...77777$$7777777$+?ZZZZZZ$7I+?????I      
  ..$7777Z77777777777..77?????I??????...7I+777$$$$$77$77?????Z?IIII??++?===.    
  ..777$$7$777777777..I77???????????...????I77$$$$$77777?????????II?++=====.. . 
  .777777$777777777..Z777??????????...???????I$7$7777$7$???????????=========. . 
..7777777777777777..?7777?????????...???+I????77777777??????????=============.. 
.7777777777777777...77777????????...??????????77777??????????=================. 
...................777777???????.....................................   ....... 
                ..7777777?????+.              ..~~~~~~=+=~~~~.                  
                .?77777I7??+??..................=????=========...               
             ...????IIII7????+=?????????+?????======+==+======+..               
             ..????????77??===+==+??????++++??========+=========.               
           . .??????????+============+??+?+=+===========~======~=..             
           ..I????????=?+==+=======?+??=+============~=========:~,.             
            +??????++++??===+======???++================~===::::::.             
         ..,??????++++?+++=========++====================~~:::::::~..           
         ..?????++++++++??================================~~:::::::=.           
         .?IIIIIII??I?IIIIIII+==============================~~~~~~~==           
"