Keyboard Tiler
===================

What is it?
-----------
Some ruby to place windows via xdotool on the tiles of your screen representing the tiles(keys) of your keyboard. The keys from 1 down to Z over to / and up to 0 forms a 4x10 grid, giving us 40 tiles to work with.

Some examples:
``` 
1/ = Fullscreen
1p = Top Half of Screen
6p = Top Right of Screenreen
1g = Top Left of Screen
1n = Left Theree Fifths of Screen
7/ = Right Two Fifths of Screen
```

Usage
-----
Keyboard Tiler is just a simple script so installation is as simple as throwing the script in your $PATH. Ofcourse you can just run the script from it's directory like ```ruby keyboard-tiler.rb``` as well.

You must have xdotool installed for keyboard-tiler.rb to function.

### Usage with xchainkeys
Xchainkeys provides chorded/chained keybindings for X11. Xchainkeys can be used to hook into keyboard-tiler.rb very easily. I will assume you know how to install xchainkeys on your distrobution. Xchainkeys is in the AUR if you are using Arch.

- First edit the generate-xchains.rb script provided in utils to fit your needs 
- Generate the xchainkeys script : ```ruby generate xchains.rb > ~/.config/xchainkeys/xchainkeys.conf```
- That's it! Run ```xchainkeys && disown``` and your done. 
- Hit W-x and then two sucessive keys
- Add xchainkeys to your .xinitrc to have it autostart


### Usage with Dmenu & xbindkeys
(Dmenu)[http://tools.suckless.org/dmenu/] provides an excellent way to run the script in a chorded type of fashion but not having to run xchainkeys. If you're a loyal Dmenu user this option will appeal to you.

From a usability standpoint the only difference in using the script with Dmenu & xbindkeys is you have to press 1 extra keystroke for each resize, which is \[Enter\]

- Add the following to your .xbindkeys
	* ``` bash
"echo Hit 2 Keys and Enter | dmenu -b -p 'Grid Window Manager' | xargs -0 -I KEYS grid-wm 'KEYS'"
	m:0x40 + c:53
	Mod4 + x
```
- Start xbindkeys like ```xbindkeys```
- Hit W-s and then two sucessive key and enter
- Add xbindkeys to your .xinitrc to have it autostart
