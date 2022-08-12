source $HOME/antigen.zsh

#################
# Configuration #
#################

export TERM="xterm-256color"
export EDITOR='vim'
export HISTFILE=~/.zsh_history # Where it gets saved
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL=ignoredups
setopt append_history # Don't overwrite, append!
setopt INC_APPEND_HISTORY # Write after each command
setopt hist_expire_dups_first # Expire duplicate entries first when trimming history.
setopt hist_fcntl_lock # use OS file locking
setopt hist_ignore_all_dups # Delete old recorded entry if new entry is a duplicate.
setopt hist_lex_words # better word splitting, but more CPU heavy
setopt hist_reduce_blanks # Remove superfluous blanks before recording entry.
setopt hist_save_no_dups # Don't write duplicate entries in the history file.
setopt share_history # share history between multiple shells
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.

export PATH="$PATH:/home/$USER/.dotnet/tools:/home/$USER/.local/share/gem/ruby/3.0.0/bin:/home/$USER/.npm-global/bin:/home/$USER/.local/bin:/home/$USER/.deta/bin/deta"

#################
# Plugins       #
#################
    
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle joshskidmore/zsh-fzf-history-search
antigen bundle BrandonRoehl/zsh-clean

antigen apply

#################
# Aliases       #
#################

alias vim='lvim'
alias pc='sudo pacman -Sy && sudo pacman -S --noconfirm'
alias up='sudo pacman -Syu --noconfirm'
alias s='yay -Ss'
alias pa='yay -S --noconfirm'
alias gc='git add . && git commit -m'

project() {
  PROJECT_DIR='~/Projects/project'
  SESSION_UUID='project'

  tmux new -d -s "$SESSION_UUID"
  tmux send -t"$SESSION_UUID:" "cd $PROJECT_DIR/app1 && npm run dev" Enter
  tmux splitw -t "$SESSION_UUID:" -dh
  tmux send -t"$SESSION_UUID:.1" "cd $PROJECT_DIR/app2 && npm run dev" Enter
  tmux splitw -t "$SESSION_UUID:.1" -dh
  tmux send -t"$SESSION_UUID:.2" "cd $PROJECT_DIR/app3 && npm run dev" Enter
  tmux splitw -t "$SESSION_UUID:.2" -dh
  tmux send -t"$SESSION_UUID:.3" "cd $PROJECT_DIR/app4 && yarn start" Enter
  tmux attach -t "$SESSION_UUID"
}
