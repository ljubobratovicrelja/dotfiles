# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish
set fish_greeting ""

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme 'robbyrussell'
Plugin 'theme'

alias tmux='tmux -2'

source /usr/local/lib/python2.7/dist-packages/powerline/bindings/fish/powerline-setup.fish


function code_review
	git difftool
end

function edit_fish
	vim ~/.config/fish/config.fish
end

function count_lines
	find . -name $argv | xargs wc -l
end

function reload_fish
	source ~/.config/fish/config.fish
end

function new_desktop_launcher
	gnome-desktop-item-edit --create-new ~/Desktop
end

function update
	sudo apt-get update
end

function upgrade
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist-upgrade
end

function install 
	sudo apt-get install $argv
end
