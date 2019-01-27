# dotfiles
(•_•) ( •_•)>⌐■-■ (⌐■_■)

## Font
I use a modded version of Operator Mono that I call Operator Code. To get the same:

1. Purchase the ScreenSmart version of Operator Mono
- [Why Operator Mono](https://www.typography.com/blog/introducing-operator)? I find it very easy to read, even at small sizes, its italics are great, and it's part of a useful family for other kinds of work, say, as a Sans serif for blog posts. I can't lie though, I've used Input Mono and FiraCode quite a bit.
- Why ScreenSmart? It's meant for rendering screen sizes, unlike Multipurpose and Office which are tuned differently.
- Why pay? Because creating good fonts is hard and takes a long time. If you're here, you're somebody who appreciates the work that goes into making something both functional and beautiful. You could always just use an open source font instead. Fira Code is [already patched this way](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode).

2. [Add in the dev ligatures](https://github.com/kiliman/operator-mono-lig). You could also [Ligaturize](https://github.com/ToxicFrog/Ligaturizer) it, but I haven't tried that method as the above is more specifically Operator-esque. You'll need font-forge for this mod and the following Nerd Fonts patcher (see the Ligaturizer README)

3. [Rename your fonts using fonttools](http://www.fontgeek.net/blog/?p=343). It's important you get your name in before using the Nerd Font patcher as attempting to change it after will result in conflicts between glyphs.

4. Download and apply the [Nerd Font patcher](https://github.com/ryanoasis/nerd-fonts#option-8-patch-your-own-font) to get many snazzy icons in your editor. I modify the `patch-fonts` script to ignore adding information to font name.

5. Make sure ligatures are turned on in your editor/terminal emulator and apply.
