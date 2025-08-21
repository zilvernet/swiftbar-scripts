PLUGIN_DIR="$HOME/Documents/Swiftbar"

mkdir -p "$PLUGIN_DIR"

curl -L -o "$PLUGIN_DIR/Brew_Updates.1d.sh" \
  https://raw.githubusercontent.com/zilvernet/swiftbar-scripts/refs/heads/main/Brew_Updates.1d.sh

curl -L -o "$PLUGIN_DIR/Nebula.1m.sh" \
  https://raw.githubusercontent.com/zilvernet/swiftbar-scripts/refs/heads/main/Nebula.1m.sh

chmod +x "$PLUGIN_DIR"/*.sh
