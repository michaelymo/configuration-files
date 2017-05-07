# Created by newuser for 5.0.5
autoload -U compinit; compinit

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
#setopt hist_ignore_dups

HISTFILE=~/.zsh_history
HISTSIZE=2000000
SAVEHIST=2000000
PROMPT="%F{green}%d%f
[%n@%m]%# "


if [ ! -e ~/.zplug/init.zsh ]; then
	curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
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

zplug load --verbose > /dev/null

bindkey '^f' forward-word 	#move cursor per each word
bindkey '^g' forward-char	#move cursor at the end of the command sequence
