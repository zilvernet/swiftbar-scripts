#!/bin/bash
# <swiftbar.title>Nebula Control</swiftbar.title>
# <swiftbar.version>1.0</swiftbar.version>
# <swiftbar.author>rp</swiftbar.author>
# <swiftbar.desc>Run Nebula helpers from the menu bar</swiftbar.desc>
# <xbar.title>Nebula Control</xbar.title>
# <xbar.version>1.0</xbar.version>

# Menu bar title

# Function to parse interfaces with only IPv4
show_ips() {
  prefix=$1
  header=$2
  echo "$header"
  ifconfig | awk -v pfx="$prefix" '
    /^[a-z0-9]+:/ {iface=$1; sub(":", "", iface)}
    $1=="inet" && $2 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ && iface ~ "^"pfx {
      print iface ": " $2
    }' | sort -u
}

echo "🌐"
echo "---"
echo "Nebula Network:"

# Submenus (run in Terminal so sudo/nano can prompt interactively)
echo "Edit config… | bash=/usr/bin/sudo param1=/etc/nebula/config-nebula.sh terminal=true"
echo "Restart Nebula | bash=/usr/bin/sudo param1=/etc/nebula/restart-nebula.sh terminal=true refresh=true"

# Nebula utunX
show_ips "utun" ""

# Local enX
echo "---"
show_ips "en" "Local Network:"

# ZeroTier fethX
echo "---"
show_ips "feth" "ZeroTier Network:"

# Separator and public IP
echo "---"
PUBLIC_IP=$(curl -s ifconfig.me)
echo "Public: $PUBLIC_IP"
