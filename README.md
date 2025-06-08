# My Dotfiles

This repository contains my personal dotfiles and configurations for Zsh, terminal tools, and applications.

## Overview

These dotfiles configure:
*   **Zsh**: Using Sheldon for plugin management, with a custom `steeef.zsh-theme`.
*   **Package Management**: Homebrew via `Brewfile`.
*   **Terminal Applications**: Configurations for Ghostty.
*   **Secrets**: A `.secrets` file for sensitive information (created if not present).
*   **(Add other major components like VSCode, iTerm, Raycast if configured here)**

## Prerequisites

Before you begin, ensure you have the following installed:
*   **Git**: To clone this repository.
*   **Homebrew**: For managing packages on macOS. (If you\'re on a different OS, you\'ll need to adapt the Homebrew steps).
*   **Sheldon**: A fast Zsh plugin manager. Installation instructions can be found [here](https://sheldon.cli.rs/Installation.html).
*   **Zsh**: Should be installed and set as your default shell. Most macOS versions come with Zsh. To set it as default: `chsh -s $(which zsh)`

## Setup on a New Machine

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/your_username/dotfiles.git ~/dotfiles 
    # Replace your_username with your actual GitHub username
    cd ~/dotfiles
    ```

2.  **Run the Setup Script**:
    This script will create symbolic links for essential configuration files.
    ```bash
    ./setup.sh
    ```

3.  **Install Homebrew Packages**:
    If you\'re on a different OS, you\'ll need to adapt the Homebrew steps.
    Then, install all the packages listed in the `Brewfile`:
    ```bash
    brew bundle install --global # Uses the Brewfile symlinked by setup.sh to ~/Brewfile
    ```

4.  **Install Sheldon**:
    Follow the official Sheldon installation guide: [Sheldon Installation](https://sheldon.cli.rs/Installation.html).
    Once Sheldon is installed, it will automatically use the `~/dotfiles/sheldon/plugins.toml` (symlinked to `~/.config/sheldon/plugins.toml`) when Zsh starts.

5.  **Restart Your Terminal**:
    Close and reopen your terminal, or source your Zsh configuration (`source ~/.zshrc`) for changes to take effect.

## Zsh Configuration

### How Zsh Works (Briefly)

Zsh (Z shell) is a powerful shell that is highly configurable. Here are the main files used in this setup:

*   **`.zshenv`**: Sourced on all invocations of Zsh. Typically used for setting environment variables like `PATH`. This setup symlinks `~/dotfiles/.zshenv` to `~/.zshenv`.
*   **`.zshrc`**: Sourced for interactive shells. Used for configuring shell options, functions, aliases, prompts, and running commands that should only occur in an interactive session. This setup symlinks `~/dotfiles/.zshrc` to `~/.zshrc`.
*   **`~/.config/sheldon/plugins.toml`**: This is Sheldon\'s configuration file, specifying which plugins and themes to load. Our `setup.sh` symlinks `~/dotfiles/sheldon/plugins.toml` here.
*   **`.zsh/` directory**: This directory within `~/dotfiles` contains custom Zsh scripts, functions, and themes, including `steeef.zsh-theme`.

### Theme: `steeef.zsh-theme`

The `steeef.zsh-theme` file is located in the `~/dotfiles/.zsh/` directory.
It is automatically loaded by **Sheldon** due to the following configuration in `~/dotfiles/sheldon/plugins.toml`:

```toml
[plugins.local-zsh]
local = "~/dotfiles/.zsh" # Sheldon is configured to look in this local directory
use = ["*.zsh", "*.zsh-theme"] # It will load all .zsh and .zsh-theme files
```

No further manual setup is required for the theme itself, provided Sheldon is installed and Zsh is started. The theme file (`.zsh/steeef.zsh-theme`) is already included in this repository.

## Other Configurations

This section can be expanded to detail setup for:
*   **Ghostty**: Configuration is at `~/dotfiles/ghostty/`. The `setup.sh` script symlinks `ghostty.conf` and a theme file.
*   **VSCode**: (Describe how VSCode settings are managed, e.g., Settings Sync, or if configs are in `vscode/` or `.vscode/`)
*   **iTerm2**: (Describe how iTerm2 settings are managed, if applicable, e.g., dynamic profiles, or if configs are in `iterm/`)
*   **Raycast**: (Describe how Raycast settings are managed, if configs are in `raycast/`)

## Secrets Management
The `setup.sh` script will create an empty `~/dotfiles/.secrets` file if one doesn\'t exist. This file is intended for storing sensitive information (API keys, tokens, etc.) and is ignored by Git (ensure `.secrets` is in your `.gitignore`).
You can source this file in your `.zshrc` or other configuration files to load secrets into your environment.
Example:
```zsh
# In .zshrc or similar
if [ -f ~/dotfiles/.secrets ]; then
  source ~/dotfiles/.secrets
fi
```

## Makefile
This repository includes a `Makefile` primarily for development and testing purposes (e.g., testing Zsh functions). It is not typically used for the initial setup process. Run `make help` to see available commands.

## Contributing

(If you plan to accept contributions, outline the process here.)

## License

(Specify a license if you wish, e.g., MIT License. If not, you can remove this section or state that it\'s for personal use.) 