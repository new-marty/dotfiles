#!/usr/bin/env zsh

# *** mkcd ***
mkcd() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: mkcd <directory-name>"
        return 1
    fi

    mkdir "$1" && cd "$1"
}

# *** cdf ***
function cdf() {
    if [[ "$(pwd)" =~ "$HOME/.*" ]]; then
        target=$(fd -t d | fzf --height 50% --layout=reverse --border --inline-info --preview 'ls -F -1 {}')
        if [[ -n "$target" ]]; then
            cd $target
        fi
    else
        echo -e "\e[33mThe directory must be under your home directory to be able to run this.\e[m"
        return 1
    fi
}

# *** brew ***
brew() {
    # Run the original brew command
    command brew "$@"

    # If the command was an install or upgrade, update the Brewfile
    if [[ "$1" == "install" || "$1" == "upgrade" || "$1" == "uninstall" ]]; then
        echo "Updating Brewfile..."
        command brew bundle dump --force --file=~/dotfiles/Brewfile
    fi
}

# *** fcat ***
fcat() {
    # Parse options
    local ignore_gitignore=false
    local output_file=""
    local copy_to_clipboard=false
    local dirs=()

    # Show usage if no arguments
    if [ $# -eq 0 ]; then
        echo "Usage: fcat [options] <directory/file> [directory/file...]"
        echo ""
        echo "Options:"
        echo "  -i, --ignore-gitignore   Don't respect .gitignore patterns"
        echo "  -o, --output FILE        Write output to FILE instead of stdout"
        echo "  -c, --clipboard          Copy output to clipboard"
        echo "  -h, --help               Display this help message"
        echo ""
        echo "Examples:"
        echo "  fcat src/                # Display all files in src directory"
        echo "  fcat -i config/ data/    # Display files in multiple directories, ignoring .gitignore"
        echo "  fcat -o output.txt lib/  # Save output to output.txt"
        echo "  fcat -c src/main.js      # Copy file content to clipboard"
        return 0
    fi

    # Process arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
        -i | --ignore-gitignore)
            ignore_gitignore=true
            shift
            ;;
        -o | --output)
            if [[ -z "$2" || "$2" == -* ]]; then
                echo "Error: --output requires a filename argument"
                return 1
            fi
            output_file="$2"
            shift 2
            ;;
        -c | --clipboard)
            # Check if we have a clipboard command available
            if ! command -v pbcopy >/dev/null 2>&1 && ! command -v xclip >/dev/null 2>&1 && ! command -v clip.exe >/dev/null 2>&1; then
                echo "Error: No clipboard command found (pbcopy, xclip, or clip.exe required)"
                return 1
            fi
            copy_to_clipboard=true
            shift
            ;;
        -h | --help)
            echo "Usage: fcat [options] <directory/file> [directory/file...]"
            echo ""
            echo "Options:"
            echo "  -i, --ignore-gitignore   Don't respect .gitignore patterns"
            echo "  -o, --output FILE        Write output to FILE instead of stdout"
            echo "  -c, --clipboard          Copy output to clipboard"
            echo "  -h, --help               Display this help message"
            echo ""
            echo "Examples:"
            echo "  fcat src/                # Display all files in src directory"
            echo "  fcat -i config/ data/    # Display files in multiple directories, ignoring .gitignore"
            echo "  fcat -o output.txt lib/  # Save output to output.txt"
            echo "  fcat -c src/main.js      # Copy file content to clipboard"
            return 0
            ;;
        *)
            dirs+=("$1")
            shift
            ;;
        esac
    done

    # Check if we have directories/files to process
    if [ ${#dirs[@]} -eq 0 ]; then
        echo "Error: No directories or files specified"
        return 1
    fi

    # Process each directory/file
    local output=""
    for dir in "${dirs[@]}"; do
        if [ ! -e "$dir" ]; then
            echo "Warning: $dir does not exist, skipping" >&2
            continue
        fi

        if [ -d "$dir" ]; then
            # It's a directory, find files inside
            local files=()

            if command -v fd >/dev/null 2>&1; then
                # Use fd if available (respects .gitignore by default)
                if [ "$ignore_gitignore" = true ]; then
                    # Get files with fd, respecting spaces in filenames
                    while IFS= read -r file; do
                        files+=("$file")
                    done < <(fd --type f --no-ignore . "$dir")
                else
                    while IFS= read -r file; do
                        files+=("$file")
                    done < <(fd --type f . "$dir")
                fi
            else
                # Fall back to find
                if [ "$ignore_gitignore" = false ] && [ -f .gitignore ]; then
                    # Create a temporary file with find exclusions
                    local tmp_exclude=$(mktemp)
                    while IFS= read -r pattern; do
                        # Skip comments and empty lines
                        [[ "$pattern" =~ ^# || -z "$pattern" ]] && continue
                        echo "$pattern" >>"$tmp_exclude"
                    done <.gitignore

                    # Use find with exclusions
                    while IFS= read -r file; do
                        files+=("$file")
                    done < <(find "$dir" -type f -not -path "*/\.*" | grep -v -f "$tmp_exclude")
                    rm "$tmp_exclude"
                else
                    while IFS= read -r file; do
                        files+=("$file")
                    done < <(find "$dir" -type f -not -path "*/\.*")
                fi
            fi

            # Process each file
            for file in "${files[@]}"; do
                if [ -f "$file" ]; then
                    output+="File: $file\n"
                    output+="$(cat "$file" 2>/dev/null)\n"
                    output+="==================================================\n"
                fi
            done
        elif [ -f "$dir" ]; then
            # It's a single file
            output+="File: $dir\n"
            output+="$(cat "$dir" 2>/dev/null)\n"
            output+="==================================================\n"
        fi
    done

    # Handle the output based on options
    if [ "$copy_to_clipboard" = true ]; then
        # Copy to clipboard using the appropriate command for the platform
        if command -v pbcopy >/dev/null 2>&1; then
            # macOS
            echo -e "$output" | pbcopy
            echo "Output copied to clipboard"
        elif command -v xclip >/dev/null 2>&1; then
            # Linux with xclip
            echo -e "$output" | xclip -selection clipboard
            echo "Output copied to clipboard"
        elif command -v clip.exe >/dev/null 2>&1; then
            # Windows WSL
            echo -e "$output" | clip.exe
            echo "Output copied to clipboard"
        fi
    fi

    if [ -n "$output_file" ]; then
        echo -e "$output" >"$output_file"
        echo "Output written to $output_file"
    fi

    # If not copying to clipboard or writing to file, print to stdout
    if [ "$copy_to_clipboard" = false ] && [ -z "$output_file" ]; then
        echo -e "$output"
    fi
}
