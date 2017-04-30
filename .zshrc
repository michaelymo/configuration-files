# Created by newuser for 5.0.5
autoload -U compinit; compinit

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

if [ ! -e ~/.zplug/init.zsh ]; then
	curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh
fi

source ~/.zplug/init.zsh

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting'

if ! zplug check --verbose; then
	printf 'Install? [y/N] '
	if read -q; then
		echo; zplug install
	fi
fi

zplug load --verbose
