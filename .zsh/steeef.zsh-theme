# Standalone Prezto steeef theme
# Based on: https://github.com/sorin-ionescu/prezto/blob/master/modules/prompt/functions/prompt_steeef_setup
#
# This theme mimics the original steeef prompt with its original colors.

# Disable virtualenv prompt modification by default
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Function to display virtualenv info
function virtualenv_info {
    [ "$VIRTUAL_ENV" ] && echo '(%F{cyan}'$(basename "$VIRTUAL_ENV")'%f) '
}

# Set flag for updating VCS info
PR_GIT_UPDATE=1

# Enable prompt substitution
setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Set colors using the original steeef color detection logic
# Use extended color palette if available; otherwise, fall back to basic colors.
if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    turquoise="%F{81}"  # Turquoise
    orange="%F{166}"    # Orange
    purple="%F{135}"    # Purple
    hotpink="%F{161}"   # Hotpink
    limegreen="%F{118}" # Limegreen
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi

# Enable VCS systems (git and svn)
zstyle ':vcs_info:*' enable git svn

# Enable check-for-changes
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# Define prompt formatting for vcs_info
PR_RST="%f"
FMT_BRANCH="(${turquoise}%b%u%c${PR_RST})"
FMT_ACTION="(${limegreen}%a${PR_RST})"
FMT_UNSTAGED="${orange}●"
FMT_STAGED="${limegreen}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "
zstyle ':vcs_info:*:prompt:*' nvcsformats ""

# Preexec hook: set VCS update flag when a command contains git, hub, or svn.
function steeef_preexec {
    case "$2" in
    *git* | *hub* | *svn*)
        PR_GIT_UPDATE=1
        ;;
    esac
}
add-zsh-hook preexec steeef_preexec

# Chpwd hook: update VCS info when changing directories.
function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

# Precmd hook: update vcs_info if flagged.
# Adjust branch format if untracked files are present.
function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]]; then
        if git ls-files --other --exclude-standard 2>/dev/null | grep -q "."; then
            FMT_BRANCH="(${turquoise}%b%u%c${hotpink}●${PR_RST})"
        else
            FMT_BRANCH="(${turquoise}%b%u%c${PR_RST})"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "
        vcs_info "prompt"
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

# Main prompt definition: displays username, hostname, current directory, vcs info, and virtualenv info.
PROMPT=$'
${purple}%n%f at ${orange}%m%f in ${limegreen}%~%f $vcs_info_msg_0_$(virtualenv_info)
$ '
