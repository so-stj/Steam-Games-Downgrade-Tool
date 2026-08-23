# Steam Depot Version Downloader

[日本語版 README](README.ja.md)

A simple SteamCMD-based tool for downloading a specific Steam
Depot Manifest and building the selected game version separately
from the existing Steam installation.

The existing Steam installation is not modified.

## Features

- SteamCMD automatic detection
- Automatic SteamCMD download
- Steam Guard support
- Multiple Depot support
- Fixed Manifest downloads
- Separate working directory
- Separate output directory
- English / Japanese interface
- Basic output verification

## Requirements

- Windows 10 / 11
- Internet connection
- Steam account with access to the game
- SteamCMD

SteamCMD is downloaded automatically if it is not found.

## Quick Start

1. Open `SteamDepotVersionDownloader.bat`.
2. Edit the `USER CONFIGURATION` section.
3. Set the AppID.
4. Set the required Depot IDs.
5. Set the corresponding Manifest IDs.
6. Set `DEPOT_COUNT`.
7. Save the file.
8. Run the BAT file.
9. Log in to Steam when SteamCMD starts.

## Configuration

Only edit the section marked:

`USER CONFIGURATION`

Example:

```bat
set "GAME_NAME=Skyrim Special Edition"
set "VERSION_NAME=1.6.1170"

set "APPID=489830"

set "DEPOT_COUNT=3"

set "DEPOT1_ID=489831"
set "DEPOT1_MANIFEST=8442952117333549665"

set "DEPOT2_ID=489832"
set "DEPOT2_MANIFEST=8042843504692938467"

set "DEPOT3_ID=489833"
set "DEPOT3_MANIFEST=1914580699073641964"

```
## License

This project is licensed under the MIT License.
See [LICENSE](LICENSE) for details.

This license applies only to the source code and documentation
included in this repository.

It does not grant any rights to redistribute copyrighted game
content or other third-party content downloaded through this tool.
