# heavy-mountain

A game for [CalCADE: YYC Indie Game Jam][1].

[1]: https://www.meetup.com/Calgary-Game-Developers/events/235106939/

The inital mac version of this was developed by 3 of us over 3 days. Ian also
graciously wrote a windows port, so people could actually play it.

## How to install

Go to the [release page] here on github and download the verison you need for
your operating system.

On macOS, extract the `zip` to get the `.app`. 

On Windows, extract and `zip` and run `CalCade.exe`. If the sounds don't work,
see the note in the build instructions for windows.

Once it's running, use the arrow keys, you'll figure it out from there.

## Build Instructions

For the macOS version, you should be able to just build from Xcode.

On Windows, you should be able to just build from Visual Studio Community. If
the sound doesn't work, you might need to run this [DX installer][dxinstall].

Theres a FullScreenMode var in the windows verison that (if set) will play the
game at 1080p with black bars which would be good for an arcade machine.

[dxinstall]: https://github.com/isaacazuelos/heavy-mountain/raw/master/windows/dxwebsetup.exe

# Contributors

* Sound by [Kevin](http://greyscreen.bandcamp.com)
* Art by Marta
* Windows code by [Ian](http://github.com/poohshoes)
* macOS code by [Isaac](http://github.com/isaacazuelos)
