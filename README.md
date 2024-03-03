## Minimal Countdown (macOS)

Minimal Countdown is a minimalistic countdown screen saver for macOS. Shows the timer while you take a rest for a while. 

![Screenshot](vendors/mc-screenshot-01s.png)
![Screenshot](vendors/mc-screenshot-03s.png)
![Screenshot](vendors/mc-screenshot-04s.png)
![Screenshot](vendors/mc-screenshot-05s.png)


## Features

- [x] Use `Options...` to customize the screen saver
- [x] Set the date and time for your timer (if the date is in the past, the timer increases)
- [x] Add a short message to display above the timer
- [x] Show or hide the message
- [x] Change text color
- [x] Dim the color if you like
- [x] Select a style for your timer to display days, hours, minutes and even seconds
- [x] Localization - English

## Configurations
![Configurations](vendors/mc-screenshot-02s.png)

## Compatibility
Minimal Countdowns screen saver requires OS X Ventura or later.


## Stack 
`Swift only`, `no storyboards`, `AppKit`, `ScreenSaver`, `ScreenSaverDefaults`

## Downloads
### [Minimal Countdown Screen Saver (.zip)](https://github.com/SKemenov/MinimalCountdown/releases/download/1.0/MinimalCountdown.saver.zip)
### [Minimal Countdown Screen Saver (.zip)](/releases/download/1.0/MinimalCountdown.saver.zip)

## How to install
1. Download zip file, unzip it and double-click `MinimalCountdown.ssaver`
2. You can choose to install this screen saver only into your account or for all users
3. Close `System Settings` and reopen it
4. My current build is not yet notarized so you may see macOS notification _"MinimalCountdown.saver can’t be opened because Apple cannot check it for malicious software."_
5. To fix this issue click `Show in Finder` button, macOS opens `Screen Savers` folder in the Finder
6. Click `Ok` to close the notification alert and `System Settings` window too
7. Hold `Shift` and after that right-click `MinimalCountdown.ssaver` file, then select `Open` in the context menu
8. In the new notification window please click `Open` button
9. Customize the settings to fit your imagination
10. Enjoy it!

**Note:**
If you doubt about this issue, you may clone my repo and try to build the screen saver by yourself.

<!---
## How to build
1. Clone the git
2. Open the project in Xcode and build it
3. Make an archive and take `MinimalCountdown.ssaver` from there 
4. Double-click `MinimalCountdown.ssaver` file to add it into the `System Settings`
--->

## How to re-install
1. Delete screen saver in `System Settings` (right-click && `Delete "MinimalCountdown"` && `Move to Trash`)
2. Close `System Settings` window
3. Restart WallpaperAgent `killall kill WallpaperAgent` via the Terminal (or just restart you computer)
4. Install the new version of `MinimalCountdown.ssaver`



## I appreciate your ideas!

- [Sam Soffes](https://github.com/soffes/Countdown)
- [Aerial](https://github.com/AerialScreensaver/ScreenSaverMinimal)
- [Mirko Fetter](https://github.com/mirkofetter/ScreenSaverMinimal/tree/master)
- [Eskil Gjerde Sviggum](https://github.com/Eskils/JellyfishSaver)
- `Apple docs`, `stack overflow` and `medium`.
