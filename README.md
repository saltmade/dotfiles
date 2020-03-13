# dotfiles
(•_•) ( •_•)>⌐■-■ (⌐■_■)

## ZSH
- I like to export certain env variables in the system zshenv file `/etc/zshenv` so they apply to all zshells, even if they don't load ~/.zshenv

## Font
I use a modded version of Operator Mono that I call Operator Code. To get the same:

1. Purchase the ScreenSmart version of Operator Mono
- [Why Operator Mono](https://www.typography.com/blog/introducing-operator)? I find it very easy to read, even at small sizes, its italics are great, and it's part of a useful family for other kinds of work, say, as a Sans serif for blog posts. I can't lie though, I've used Input Mono and FiraCode quite a bit.
- Why ScreenSmart? It's meant for rendering screen sizes, unlike Multipurpose and Office which are tuned differently.
- Why pay? Because creating good fonts is hard and takes a long time. If you're here, you're somebody who appreciates the work that goes into making something both functional and beautiful. You could always just use an open source font instead. Fira Code is [already patched this way](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode).

2. [Add in the dev ligatures](https://github.com/kiliman/operator-mono-lig). You could also [Ligaturize](https://github.com/ToxicFrog/Ligaturizer) it, but I haven't tried that method as the above is more specifically Operator-esque. You'll need font-forge for this mod and the following Nerd Fonts patcher (see the Ligaturizer README)

3. [Rename your fonts using fonttools](http://www.fontgeek.net/blog/?p=343). It's important you get your name in before using the Nerd Font patcher as attempting to change it after will result in conflicts between glyphs.

4. Download and apply the [Nerd Font patcher](https://github.com/ryanoasis/nerd-fonts#option-8-patch-your-own-font) to get many snazzy icons in your editor. I modify the `patch-fonts` script to ignore adding information to font name. Use `find . -name "OperatorCode*.otf" -exec ./font-patcher -c --careful {} \;` to do the hard work.

5. Make sure ligatures are turned on in your editor/terminal emulator and apply.

```
                                                                                
                                                                                
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
                                                                                
                                                                                
                                                                                
```
