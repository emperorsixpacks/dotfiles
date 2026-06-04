# ── Zsh: Terminal-first Workstation ──────────────────────────────

# ── History ──
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY

# ── Completion ──
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ── Options ──
bindkey -e               # emacs key bindings (no vi mode)
setopt AUTO_CD
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt PUSHD_IGNORE_DUPS
SPROMPT='zsh: correct %R → %r [yes/no/edit/abort]? '

# ── atuin (shell history) ──
if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

# ── zoxide (smarter cd) ──
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# ── fzf (fuzzy finder) ──
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# ── Starship prompt ──
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# ── Aliases ──
alias ls='eza --icons=auto'
alias ll='eza -l --icons=auto --git'
alias la='eza -la --icons=auto --git'
alias lt='eza -T --icons=auto'
alias lta='eza -Ta --icons=auto --git-ignore'
alias cat='bat --theme=Catppuccin-mocha'
alias grep='rg'
alias find='fd'
alias top='btm'
alias vim='nvim'
alias vi='nvim'
alias lg='lazygit'
alias ld='lazydocker'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'

# ── Env ──
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='firefox'
export PAGER='bat'
export BAT_THEME='Catppuccin-mocha'
export GIT_PAGER='bat --theme=Catppuccin-mocha'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# ── Yazi: cd on exit ──
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
