export ZSH="/Users/ljcucc/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git)
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

setup_alias () {
  alias wksp="cd ~/Workspace; n"
  alias gs="git status"
  alias gl="git log --oneline"
  alias config="vim ~/.zshrc"
  alias gitcls="git reflog expire --expire-unreachable=now --all;git gc --prune=now"

  alias enable_gpg="git config --global commit.gpgsign true"
  alias disable_gpg="git config --global commit.gpgsign false"
  alias vopen="vim \$(ls | fzf)"
  alias wttr="curl https://wttr.in"
  alias wttrcur="curl https://wttr.in\?1"
}

setup_alias

# >>> flutter init
# export PATH="$PATH:/Users/ljcucc/opt/flutter/bin"
# <<< flutter init
#
# >>> processing-java setup
# export PATH="$PATH:/Users/ljcucc/opt/processing-java"
# <<< processing-java setup

if [[ $(neofetch | grep OS) == *"macOS"* ]]; then
  export PATH="$PATH:/usr/local/opt/docker-compose/bin/"
  export PATH="$PATH:/usr/local/opt/python@3.7/bin/"
  export PATH="/usr/local/sbin:$PATH"
  export PATH=$PATH:/Users/ljcucc/Desktop/Workspace/Personal/tagspaces-cli/
  export GPG_TTY=$(tty)
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  export PATH="$PATH:/opt/X11/bin"
  export PATH="$PATH:/Users/ljcucc/.npm-global/bin"
  export PATH="$PATH:/Users/ljcucc/Library/Python/3.8/bin"
  export PATH="$PATH:/usr/local/opt/docker-compose/bin/"
  export PATH="$PATH:/Users/ljcucc/go/bin"

# personal project
export PATH="$PATH:$HOME/Workspace/MPUtils/"
fi

n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
