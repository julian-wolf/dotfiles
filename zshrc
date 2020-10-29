zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]}' '' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=12
zstyle ':completion:*' select-prompt %SSrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/julian/.zshrc'

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
autoload -Uz colors && colors

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory extendedglob nomatch
setopt autocd
bindkey -e

# config searching
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

NEWLINE=$'\n'
local return_status="%{$fg_bold[red]%}%(?..[%?])%{$reset_color%}"

setopt prompt_subst prompt_percent

PROMPT='${NEWLINE}%{$fg[green]%}${USER}@%M%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%}%{$fg[cyan]%} ${vcs_info_msg_0_}%{$reset_color%}${NEWLINE}%# '
PROMPT2='%# %{$fg[red]%}...%{$reset_color%} '
RPROMPT='${return_status} %T'

zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

alias ipy="ipython --pylab"
alias mt="make-pth-torrent"

# open things in Sublime directly
_sublime_path="/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
subl () { "$_sublime_path" $* }
alias st=subl

_pip_upgrade_all () {
    outdated2=$(pip2 list --outdated --format=freeze | cut -d = -f 1)
    if ! [ -z "$outdated2" ]; then
        pip2 list --outdated --format=columns
        echo "$outdated2" | xargs -t -n1 pip2 install -U
    else
        echo "pip2: Already up-to-date."
    fi

    outdated3=$(pip3 list --outdated --format=freeze | cut -d = -f 1)
    if ! [ -z "$outdated3" ]; then
        pip3 list --outdated --format=columns
        echo "$outdated3" | xargs -t -n1 pip3 install -U
    else
        echo "pip3: Already up-to-date."
    fi
}
alias pip-upgrade-all=_pip_upgrade_all

# search for a process
find_in_ps () { ps aux | head -1; ps aux | grep $1 | cut -c 1-$(($COLUMNS - 7)) }
alias psgrep=find_in_ps

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(stack --bash-completion-script stack)"

eval "$(hub alias -s)"
# pushd $(brew --prefix root6) > /dev/null; . libexec/thisroot.sh; popd > /dev/null
. /Users/julian/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval "$(thefuck --alias)"

. `brew --prefix`/etc/profile.d/z.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# added by travis gem
[ -f /Users/julian/.travis/travis.sh ] && source /Users/julian/.travis/travis.sh

export PROMPT_COMMAND="echo -ne '\033]0;${USER}@${HOST}\007';$PROMPT_COMMAND"
precmd() { eval "$PROMPT_COMMAND" }
