Keyboard Tiler
===================

What is it?
-----------
Why not have the keyboard represent the grid/tiles of your screen? Well this is exactly that. It's a ruby script place windows on the tiles of your screen representing the tiles(keys) of your keyboard. The keys from 1 down to Z over to / and up to 0 forms a 4x10 grid, giving us 40 tiles to work with.

With this script you can have tiling functionality with simple keybindings in any floating WM. It has been tested on pekwm and openbox so far, though any window manager that places well with xdotool it should work with.

Some examples (look down at your keyboard and you'll get the idea):
- Fullscreen: `ruby keyboard-tiler.rb 1/`
- Half of Screen: `ruby keyboard-tiler.rb 1p`
- Right of Screen: `ruby keyboard-tiler.rb 6p`
- Left of Screen: `ruby keyboard-tiler.rb 1g`
- Theree Fifths of Screen: `ruby keyboard-tiler.rb 1n`
- Right Two Fifths of Screen: `ruby keyboard-tiler.rb 6/`

The best part? You can hook this into a chorded keymap program such as xchainkeys or just pipe it from dmenu. 

Usage
-----

**Prerequisites:** ruby, xdotool

Keyboard Tiler is just a simple script so using it is as simple as ```ruby keyboard-tiler.rb 1/``` (that would make a window fullscreen). You can also copy the script to your $PATH to have acessible anywhere.

### Usage with xchainkeys
[Xchainkeys](http://code.google.com/p/xchainkeys/) provides chorded/chained keybindings for X11. Xchainkeys can be used to hook into keyboard-tiler.rb very easily. Installation details for xchainkeys can be found [here](http://code.google.com/p/xchainkeys/).

- First edit the ```generate-xchains.rb``` script provided in utils to fit your needs 
- Generate the xchainkeys script : ```ruby generate xchains.rb > ~/.config/xchainkeys/xchainkeys.conf```
- That's it! Run ```xchainkeys && disown``` and your done. 
- Hit W-x and then two sucessive keys
- Add xchainkeys to your ```.xinitrc``` to have it autostart


### Usage with Dmenu & xbindkeys
[Dmenu](http://tools.suckless.org/dmenu/) provides an excellent way to run the script in a chorded type of fashion but not having to run xchainkeys. If you're a loyal Dmenu user this option will appeal to you.


- Add the following to your ```.xbindkeys```
``` 
"echo Hit 2 Keys and Enter | dmenu -b -p 'Grid Window Manager' | xargs -0 -I KEYS grid-wm 'KEYS'"
	m:0x40 + c:53
	Mod4 + x
```
- Start xbindkeys like ```xbindkeys```
- Hit ```W-x``` and then two sucessive key and enter
- Add xbindkeys to your ```.xinitrc``` to have it autostart

Bugs, Comments, Improvements?
-----------------------------
- Feel free to fork this repo and issue a pull request to me.
