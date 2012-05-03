Keyboard Tiler
===================
What is it?
-----------
Why not have your keyboard represent the grid/tiles of your screen? This is a ruby script to place windows on the tiles of your screen representing the tiles(keys) of your keyboard. The keys from 1 down to Z over to / and up to 0 forms a 4x10 grid, giving us 40 tiles to work with.

With this script you can have tiling functionality with simple keybindings in any floating WM. It has been tested on Pekwm and Openbox so far, though any window manager that works well with xdotool should work.

Some examples (look down at your keyboard and you'll get the idea):
- Fullscreen: `ruby keyboard-tiler.rb 1/`
- Top Half of Screen: `ruby keyboard-tiler.rb 1p`
- Top Right of Screen: `ruby keyboard-tiler.rb 6p`
- Right Half of Screen: `ruby keyboard-tiler.rb 6/`

The best part? You can hook this into a chorded keymap program such as xchainkeys or just pipe it from dmenu.


Usage
-----

**Prerequisites:** ruby, xdotool

Keyboard Tiler is just a simple script so using it is as simple as ```ruby keyboard-tiler.rb 1/``` (that would make a window fullscreen). You can also copy the script to your $PATH to have accessible anywhere. I'd recommend throwing it in a personal bin folder (like ```~/bin```).

### Usage with xchainkeys
[Xchainkeys](http://code.google.com/p/xchainkeys/) provides chorded/chained keybindings for X11. Xchainkeys can be used to hook into keyboard-tiler.rb very easily. Installation details for xchainkeys can be found [here](http://code.google.com/p/xchainkeys/).

- Once xchainkeys is installed, edit the ```generate-xchains.rb``` script provided in utils to fit your needs 
- Generate xchainkeys config using provided script: ```ruby generate-xchains.rb > ~/.config/xchainkeys/xchainkeys.conf```
	* Optional: "moded" option: ```ruby generate-xchains.rb moded > ~/.config/xchainkeys/xchainkeys.conf```
- That's it! Run ```xchainkeys && disown``` and your done. 
- Hit W-x (or your specified hotkey) and then two sucessive keys
- Add xchainkeys to your ```.xinitrc``` to have it autostart


### Usage with Dmenu & xbindkeys
[Dmenu](http://tools.suckless.org/dmenu/) provides an excellent way to run the script in a chorded type of fashion but not having to run xchainkeys. If you're a loyal Dmenu user this option will appeal to you.

- Add the following to your ```~/.xbindkeys```


``` bash
"echo Hit 2 Keys and Enter | dmenu -b -p 'Keyboard Tiler' | xargs -0 -I KEYS ruby ~/bin/keyboard-tiler.rb 'KEYS'"
m:0x40 + c:53
Mod4 + x
```
- Start xbindkeys like ```xbindkeys```
- Hit ```W-x``` and then two sucessive key and enter
- Add xbindkeys to your ```.xinitrc``` to have it autostart

Todos
-----
- **Multi-monitor Support**: Currently keyboard-tiler only supports 1-2 monitors.

Contributing
------------
- All feedback is welcome!
- Feel free to fork this repo create a topic branch and issue me a pull request.

More Info & Links
-----------------
- [Project Page on My Site](http://userbound.com/projects/keyboard-tiler)
- [A Python Port](https://github.com/ShadowKyogre/keyboard-tiler) by ShadowKyogre
