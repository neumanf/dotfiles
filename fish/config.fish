set fish_greeting

function vi
	nvim $argv
end

function vim
	nvim $argv
end

function pc
	sudo pacman -Sy && sudo pacman -S --noconfirm $argv
end

function up
	sudo pacman -Syu --noconfirm
end

function s
	yay -Ss $argv
end

function pa
	yay -S --noconfirm $argv
end

function gc
	git add . && git commit -m $argv
end

function gcp
	git add . && git commit -m $argv && git push
end

function project
  set project_dir ~/Projects
  set session_uuid project

  tmux new -d -s "$session_uuid"
  tmux send -t"$session_uuid:" "cd $project_dir/app1 && npm run dev" Enter
  tmux splitw -t "$session_uuid:" -dh
  tmux send -t"$session_uuid:.1" "cd $project_dir/app2 && npm run dev" Enter
  tmux splitw -t "$session_uuid:.1" -dh
  tmux send -t"$session_uuid:.2" "cd $project_dir/app3 && npm run dev" Enter
  tmux splitw -t "$session_uuid:.2" -dh
  tmux send -t"$session_uuid:.3" "cd $project_dir/app4 && yarn start" Enter
  tmux attach -t "$session_uuid"
end
