# swiftbar-scripts

A collection of SwiftBar plugins for macOS, designed to add useful system and network utilities directly into your macOS menu bar.

📂 Included Scripts

🍺 Brew_Updates.1d.sh

   Purpose: Checks for outdated Homebrew packages and lets you upgrade them from the menu bar.
 
   Refresh Interval: Every day (1d).
   
   Features:
    - Shows the number of outdated packages.
	- Provides a menu option to upgrade all packages.
	- Displays direct links to Homebrew.

🌐 Nebula.1m.sh

   Purpose: Displays Nebula VPN interface IP addresses and quick helpers for managing Nebula from the menu bar.
 
   Refresh Interval: Every minute (1m).
   
   Features:
	- Lists active Nebula interfaces and their IPv4 addresses.
	- Provides quick commands to check Nebula status and version.
	- Convenient menu bar indicator for network state.


⚙️ install.sh

  Purpose: Installer script for quickly deploying these SwiftBar plugins.
  
  Features:
  -	Copies plugin scripts to your ~/Documents/SwiftBar (or your chosen SwiftBar plugins folder).
  - Ensures proper permissions.


📦 Installation
  1. Clone this repository:
```
     git clone https://github.com/zilvernet/swiftbar-scripts.git
```        
  2. Copy the scripts into your SwiftBar plugin folder:
```
	cd swiftbar-scripts
	./install.sh
```
  > By default, install.sh uses ~/Documents/SwiftBar.

  3.	Launch SwiftBar and point it to the plugins folder if you haven’t already.

 
🚀 Usage

  •	Homebrew Updates: Click the 🍺 icon in your menu bar to see and manage package updates.
 
  •	Nebula Control: Click the 🌐 icon to see Nebula network info and run helpers.


🔧 Requirements

  •	macOS with SwiftBar installed.
 
  •	Homebrew (brew) for the Brew_Updates.1d.sh plugin.
 
  •	Nebula installed for the Nebula.1m.sh plugin.

📜 License

MIT License – feel free to use and adapt these scripts.
