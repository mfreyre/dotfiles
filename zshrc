# general settings
stty -ixon
[[ ":$PATH:" != *":$HOME/.bin:"* ]] && export PATH="$PATH:$HOME/.bin"
export PAGER="less"
export LESS="-R"
export EDITOR="vim"
export KEYTIMEOUT=1

# aliases
alias ll="ls -lh"
alias lla="ls -lAh"
alias cdr='cd $(git rev-parse --show-toplevel 2>/dev/null)'
alias pbcopy='xclip -sel clip'

# git aliases
alias gcm="git commit -m"
alias gap="git add -p"
alias gists="git diff --staged | gist -t diff"
alias gcan="git commit --amend --no-edit"
alias gca="git commit --amend"
alias gco="git checkout"
alias vsql="/opt/vertica/bin/vsql -h vertica-prod -U mfreyre"
alias notebook="jupyter notebook --ip=0.0.0.0 --port=5678 --no-browser"

# key-bindings
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    ind="${${KEYMAP/vicmd/𝙑𝙄}/(main|viins)/❯❯}"
    zle reset-prompt
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  function zle-keymap-select() {
    ind="${${KEYMAP/vicmd/𝙑𝙄}/(main|viins)/❯❯}"
    zle reset-prompt
  }
  zle -N zle-line-init
  zle -N zle-line-finish
  zle -N zle-keymap-select
fi

bindkey -v
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char

if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# history
[[ -z "$HISTFILE" ]] && export HISTFILE=$HOME/.zsh_history
export HISTSIZE=20000
export SAVEHIST=$HISTSIZE

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# third-party files
if [[ $- == *i* ]] ; then
  source "$HOME/.zsh/oh-my-zsh/completion.zsh"
  source "$HOME/.zsh/oh-my-zsh/git.zsh"
  source "$HOME/.zsh/oh-my-zsh/themes-and-appearance.zsh"

  # must be sourced at the end
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# theme old
# ind="❯❯"
# rtc="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"
# PROMPT=' %{$fg_bold[cyan]%}%c $(git_prompt_info)${rtc}${ind}%{$reset_color%} '
#
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}✗ "
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "
#

#new theme
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

autoload -U compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#Anaconda time
export PATH="/home/mfreyre/anaconda3:bin$PATH"
