source $HOME/antigen.zsh

#################
# Plugins       #
#################
    
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
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
