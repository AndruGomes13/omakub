#!/bin/bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Install CLI tools (fzf, ripgrep, bat, eza, fd, zoxide, starship, zsh + plugins)
# Supports: macOS (brew), Linux with sudo (apt), Linux without sudo (prebuilt binaries)
# ---------------------------------------------------------------------------

LOCAL_BIN="$HOME/.local/bin"
LOCAL_SHARE="$HOME/.local/share"

# --- Table of GitHub-released tools ----------------------------------------
# Format: repo  binary  x86_64-pattern  aarch64-pattern
GITHUB_TOOLS=(
  "BurntSushi/ripgrep    rg   x86_64-unknown-linux-musl  aarch64-unknown-linux-gnu"
  "sharkdp/bat           bat  x86_64-unknown-linux-musl  aarch64-unknown-linux-gnu"
  "eza-community/eza     eza  x86_64-unknown-linux-musl  aarch64-unknown-linux-musl"
  "sharkdp/fd            fd   x86_64-unknown-linux-musl  aarch64-unknown-linux-gnu"
)

# --- Helpers ---------------------------------------------------------------

github_install() {
  local repo="$1" binary_name="$2" x86_pattern="$3" arm_pattern="$4"

  local pattern
  if [[ "$ARCH" == "x86_64" ]]; then
    pattern="${x86_pattern}\.tar\.gz"
  else
    pattern="${arm_pattern}\.tar\.gz"
  fi

  echo "  Installing: $binary_name..."
  local url
  # Replacing the grep -oP line with a portable sed alternative
  url=$(curl -sL "https://api.github.com/repos/$repo/releases/latest" \
    | grep "browser_download_url" \
    | grep "$pattern" \
    | head -1 \
    | sed 's/.*"browser_download_url": "\(.*\)".*/\1/')

  if [[ -z "$url" ]]; then
    echo "    WARNING: could not find download URL for $binary_name"
    return 1
  fi
  curl -sL "$url" | tar xz -C "$TMPDIR"
  find "$TMPDIR" -name "$binary_name" -type f -exec install -m 755 {} "$LOCAL_BIN/" \;
}

clone_or_pull() {
  local repo_url="$1" dest="$2"
  local name
  name=$(basename "$dest")
  if [[ ! -d "$dest" ]]; then
    echo "  Clonning: $name..."
    git clone --depth 1 "$repo_url" "$dest" 2>/dev/null
  else
    echo "  Pulling: $name"
    git -C "$dest" pull --quiet 2>/dev/null
  fi
}

# --- macOS -----------------------------------------------------------------

install_macos() {
  brew install fzf ripgrep bat eza zoxide fd
  brew install zsh-autosuggestions zsh-syntax-highlighting starship
}

# --- Linux (with sudo) ----------------------------------------------------

install_linux_sudo() {
  sudo apt install -y fzf ripgrep bat eza zoxide plocate apache2-utils fd-find
  sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting
  curl -sS https://starship.rs/install.sh | sh -s -- -y >/dev/null 2>&1
}

# --- Linux (no sudo) ------------------------------------------------------

install_linux_nosudo() {
  mkdir -p "$LOCAL_BIN" "$LOCAL_SHARE"
  TMPDIR=$(mktemp -d)
  trap 'rm -rf "$TMPDIR"' EXIT

  echo "Installing tools to $LOCAL_BIN (no-sudo mode)..."

  # fzf
  echo "  fzf..."
  clone_or_pull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"
  "$HOME/.fzf/install" --bin --no-update-rc --no-completion --no-key-bindings >/dev/null 2>&1
  install -m 755 "$HOME/.fzf/bin/fzf" "$LOCAL_BIN/"

  # GitHub-released tools (table-driven)
  for entry in "${GITHUB_TOOLS[@]}"; do
    read -r repo binary x86 arm <<< "$entry"
    github_install "$repo" "$binary" "$x86" "$arm"
  done

  # zoxide (has its own installer)
  echo "  Installing: Zoxide"
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh \
    | BIN_DIR="$LOCAL_BIN" sh >/dev/null 2>&1

  # starship (has its own installer)
  echo "  Installing: Starship"
  curl -sS https://starship.rs/install.sh \
    | sh -s -- -y -b "$LOCAL_BIN" >/dev/null 2>&1

  # zsh plugins
  clone_or_pull "https://github.com/zsh-users/zsh-autosuggestions" \
    "$LOCAL_SHARE/zsh-autosuggestions"
  clone_or_pull "https://github.com/zsh-users/zsh-syntax-highlighting" \
    "$LOCAL_SHARE/zsh-syntax-highlighting"

  echo "  Done."
}

# --- Main dispatch ---------------------------------------------------------

if [[ "$(uname)" == "Darwin" ]]; then
  install_macos
elif [[ "${USER_INSTALL:-}" == "true" ]]; then
  install_linux_nosudo
else
  install_linux_sudo
fi
