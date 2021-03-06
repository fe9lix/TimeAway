# TimeAway

![TimeAway](https://github.com/fe9lix/TimeAway/blob/gh-pages/images/timeaway-window.png?raw=true)

![TimeAway](https://github.com/fe9lix/TimeAway/blob/gh-pages/images/timeaway-menu.png?raw=true)

TimeAway is a very simple tool running in the background and logging the time when you lock and unlock the screen. 
I've built it for looking up how long I've been away from my machine, for example when I come back from lunch. 
Since I tend to forget stopping and restarting time tracking tools but always lock the screen when I leave my machine, I can retrospectively look up my "away times" in the status bar. 
TimeAway optionally also displays a popup as a reminder when you unlock the screen.

## Installation
TimeAway runs on OSX (tested on OSX 10.10). Download the [latest release](https://github.com/fe9lix/TimeAway/releases/latest).

Unzip the file and copy the .app file into your program folder. When you start the app, an icon should appear in the status bar.
If you you want to launch TimeAway on startup (which is advisable), just add it to your login items (`Apple Logo/System Preferences/Accounts/Login Items/+`).


## Usage
Start the app, then lock your screen (`CTRL` + `SHIFT` + `Eject/Power`) and unlock again. Check the logged time in the status bar menu.
(If you don't see a password prompt after unlocking, you can adjust the setting in `Apple Logo/System Preferences/Security & Privacy/General/Require password...` and select a low value such as 5 sec.)


The menu contains five items:
- `Show Recent`: Displays the recent lock/unlock event and its duration. Pressing `CMD` + `C` copies the duration to the clipboard.
- `Show When Unlocked`: If enabled, displays the window each time the screen is unlocked.
- `History`: Shows the past 20 lock/unlock events and their durations. Selecting an entry copies the duration to the clipboard. Selecting the last entry (`Clear Entries`) removes all events.
- `About`: Opens this page in the web browser.
- `Quit`: Exits the application.

## License
The MIT License (MIT)
