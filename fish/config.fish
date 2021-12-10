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
	pacman -Ss $argv
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

