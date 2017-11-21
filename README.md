# misc-powershell
Miscellaneous PowerShell Scripts

## Get-RedditWallpapers.ps1
Added options, so you can now do things like this:
* .\Get-RedditWallpapers.ps1 -subReddit ultrahdwallpapers (Defaults to 'EarthPorn')
* .\Get-RedditWallpapers.ps1 -wallpaperRoot D:\alternateRoot (Defaults to 'C:\Wallpapers')
* .\Get-RedditWallpapers.ps1 -minWidth 1920 -minHeight 1200 (Defaults to '1920' x '1080')

This script will pull the latest 100 images down from a given subreddit, and remove ones that are the wrong orientation or low resolution.

It's a little rough around the edges. Feel free to improve upon it! I recently changed the script to use Ed Wilson's "Get-FileMetaData" function rather than "System.Drawing.Image" assembly.

## Get-LockScreenWallpapers.ps1
Windows 10 is constantly updating your lock screen with its curated, personalized slideshow of images in Windows Spotlight.

This script will copy all the wallpapers from "$env:LOCALAPPDATA\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets" and remove the unneccessary/smaller files in the directory and rename the file extensions automatically!

## New-GeneratedPassword.ps1
Creates one or more passwords. Options include password length, minimum number of non-alphanumeric characters, and number of passwords to be generated. Returns an array of values.
