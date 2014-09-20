bindkey -e
autoload -U compinit
compinit -u
setopt  auto_cd

HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

alias rmi='rm -i'
alias la='ls -a'
alias ls='ls -F --color'
alias ll='ls -lF'
alias screen='screen -h 10000 -R'
alias gg='git grep'

if which lv > /dev/null 2>&1; then
    export PAGER=lv
fi

if [ -x `which vim` ]; then
    export SVN_EDITOR='vim'
fi

function google() {
  local str opt 
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done    
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&ie=euc-jp&oe=euc-jp&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}

alias ggl=google

function goo(){
  local str opt 
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done    
    str=`echo $str | sed 's/^\+//'`
    opt="search.php?MT=$str&search_history=&kind=&kwassist=0&mode=0"
  fi
  w3m http://dictionary.goo.ne.jp/$opt
}

function alc {
  if [ $# != 0 ]; then
      w3m -o confirm_qq=false "http://eow.alc.co.jp/$1/UTF-8/"
  fi
}

if [ "$TERM" = "screen" ]; then
    chpwd () { echo -n "_`dirs`\\" }
    preexec() {
    # see [zsh-workers:13180]
    # http://www.zsh.org/mla/workers/2000/msg03993.html
	emulate -L zsh
	local -a cmd; cmd=(${(z)2})
	case $cmd[1] in
	fg)
	    if (( $#cmd == 1 )); then
		cmd=(builtin jobs -l %+)
	    else
		cmd=(builtin jobs -l $cmd[2])
	    fi
		;;
	%*) 
	    cmd=(builtin jobs -l $cmd[1])
		;;
	cd)
	    if (( $#cmd == 2)); then
		cmd[1]=$cmd[2]
	    fi
		;&
	rlogin)
	    if (( $#cmd == 2)); then
		cmd[1]=$cmd[2]
	    fi
		;&
	ssh)
	    cmd[1]=$cmd[$#cmd]
		;&
	*)
	    echo -n "k$cmd[1]:t\\"
	    return
	    ;;
	esac
        local -A jt; jt=(${(kv)jobtexts})
        $cmd >>(read num rest
	cmd=(${(z)${(e):-\$jt$num}})
	echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi

export EDITOR=vim

ZSH_BASE_DIR=$HOME/$(dirname $(readlink $HOME/.zshrc))
if [ -r "$ZSH_BASE_DIR/zsh/$(hostname)" ]; then
    . $ZSH_BASE_DIR/zsh/$(hostname)
fi

source $HOME/.oh-my-zshrc

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-cd() {
    local dest
    BUFFER="cd $HOME/work/$(find $HOME/work -maxdepth 1 -mindepth 1 -type d | sed -e 's,'$HOME/work/',,' | peco --query "$LBUFFER")"
    CURSOR=$#BUFFER
    zle accept-line
}

zle -N peco-cd
bindkey '^]' peco-cd
