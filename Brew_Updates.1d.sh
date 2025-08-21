#!/bin/bash
# <swiftbar.title>Homebrew Updates</swiftbar.title>
# <swiftbar.version>1.3</swiftbar.version>
# <swiftbar.author>Your Name</swiftbar.author>
# <swiftbar.desc>Shows outdated Homebrew packages and lets you upgrade from the menu. Also toggles Stage Manager.</swiftbar.desc>

# Make sure PATH includes Homebrew locations when run from SwiftBar
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

# Find brew (works on Intel and Apple Silicon)
my_brew="$(command -v brew)"

# ---------- STAGE MANAGER HELPERS ----------
sm_read_state() {
  # returns 1 if enabled, 0 if disabled/unknown
  local v
  v="$(/usr/bin/defaults read com.apple.WindowManager GloballyEnabled 2>/dev/null || echo 0)"
  [[ "$v" == "1" ]] && echo 1 || echo 0
}

sm_set() {
  # $1 = true|false
  /usr/bin/defaults write com.apple.WindowManager GloballyEnabled -bool "$1"
  # Applying immediately:
  /usr/bin/killall Dock >/dev/null 2>&1
}
# ------------------------------------------

# Handle menu actions
case "$1" in
  # ---------- STAGE MANAGER ACTIONS ----------
  stage_toggle)
    if [[ "$(sm_read_state)" -eq 1 ]]; then
      sm_set false
    else
      sm_set true
    fi
    exit 0
    ;;
  stage_on)
    sm_set true
    exit 0
    ;;
  stage_off)
    sm_set false
    exit 0
    ;;
  # ---------- HOMEBREW ACTIONS ----------
  brew_upgrade_all_bg)
    "$my_brew" update >/dev/null 2>&1
    "$my_brew" upgrade >/dev/null 2>&1
    exit 0
    ;;
  brew_upgrade_all_term)
    /usr/bin/osascript -e 'tell app "Terminal"
      do script "'"$my_brew"' update; '"$my_brew"' upgrade; exit"
    end tell' >/dev/null 2>&1
    exit 0
    ;;
  brew_upgrade_one_bg)
    [[ -n "$2" ]] && "$my_brew" upgrade "$2" >/dev/null 2>&1
    exit 0
    ;;
  brew_upgrade_one_term)
    [[ -n "$2" ]] && /usr/bin/osascript -e 'tell app "Terminal"
      do script "'"$my_brew"' upgrade '"$2"'"
    end tell' >/dev/null 2>&1
    exit 0
    ;;
esac

# If Homebrew not found, still show Stage Manager controls
if [[ -z "$my_brew" ]]; then
  echo "🍺?"
else
  # Count outdated packages (quiet is faster & cleaner)
  packages_out="$("$my_brew" outdated --quiet | wc -l | tr -d '[:space:]')"

  # Show icon in the menu bar
  if [[ "$packages_out" -gt 0 ]]; then
    echo "⬆️"
  else
    echo "✅"
  fi
fi

echo "---"

# ---------- STAGE MANAGER MENU ----------
sm_state="$(sm_read_state)"
if [[ "$sm_state" -eq 1 ]]; then
  echo "Stage Manager: ON | sf=bolt.fill"
  echo "--Turn OFF | bash=$0 param1=stage_off terminal=false refresh=true"
  echo "--Toggle | bash=$0 param1=stage_toggle terminal=false refresh=true"
else
  echo "Stage Manager: OFF | sf=bolt.slash.fill"
  echo "--Turn ON | bash=$0 param1=stage_on terminal=false refresh=true"
  echo "--Toggle | bash=$0 param1=stage_toggle terminal=false refresh=true"
fi
echo "---"
# ---------------------------------------

# ---------- HOMEBREW MENU ----------
if [[ -n "$my_brew" ]]; then
  if [[ "$packages_out" -gt 0 ]]; then
    echo "Upgrade all ($packages_out) in Terminal… | bash=$0 param1=brew_upgrade_all_term terminal=false refresh=true"
    echo "Upgrade all ($packages_out) in background… | bash=$0 param1=brew_upgrade_all_bg terminal=false refresh=true"
    echo "---"
    echo "Outdated packages:"
    while IFS= read -r pkg; do
      [[ -z "$pkg" ]] && continue
      echo "--$pkg"
      echo "----Upgrade $pkg in Terminal… | bash=$0 param1=brew_upgrade_one_term param2=$pkg terminal=false refresh=true"
      echo "----Upgrade $pkg in background… | bash=$0 param1=brew_upgrade_one_bg param2=$pkg terminal=false refresh=true"
    done < <("$my_brew" outdated --quiet)
    echo "---"
    echo "Refresh | refresh=true"
  else
    echo "Nothing to update"
    echo "Refresh | refresh=true"
  fi
fi
