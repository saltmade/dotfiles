# ~/.bashrc
##

# use liquidprompt, customize in ~/.liquidpromptrc
if [ -f /usr/local/share/liquidprompt ]; then
    . /usr/local/share/liquidprompt
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

complete -C /usr/local/bin/vault vault

# change my prompt
PS1="\n\[\e[34m\]λ\[\e[m\] \W → "

# turn on autocd into files
shopt -q -s cdspell
shopt -s autocd

###############
#  aliases
######
# use a bare repo to track dotfiles
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias bashrc="vi ~/.bashrc"
alias play="cd ~/playground"
alias vi="nvim"
alias vimrc="vi ~/.config/nvim/init.vim"
# colorful list view
alias ll="ls -lGhA"
# in columns with slashes after directory
alias ls="ls -CFG"
# spelling error
alias sl="ls"
# pipe long directory to less so they can be scrolled easily
alias lsl="ls -lhFA | less"
alias la="ls -a"
alias lt="tree && echo 'using 🌳 tree 🌳'"
# create intermediate directories and tell us about it
alias mkdir="mkdir -pv"
alias top="vtop"
alias src="source ~/.bashrc"
alias docs="cd ~/Documents"

## Git Aliases
alias gA="git add ."
alias gaN="echo 'git add . --intent-to-add' && git add -N ."
alias gb="git branch"
alias gc="git clone"
alias gck="git checkout"
alias gf="git fetch"
alias gm="git merge"
alias gp="git pull"
alias gpu="git push"
alias gpf="git push -f"
alias gs="git status"
alias master="git checkout master"
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
# From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
# Add uncommitted and unstaged changes to the last commit
alias gcaa="git commit -a --amend -C HEAD"
alias ggui="git gui"
alias ggs="gg --stat"

## Python Aliases
alias pip="echo 'Remember to use pipenv' && pip3"
alias python="python3"
alias mng="./manage.py"

############
# Volantio Aliases
####
alias ctl="./appctl"
alias vol="cd ~/Volantio"
export VAULT_ADDR="https://secrets.volantio.com:8200/"

############
# bash functions
####

mcd () {
  mkdir -p $1
  cd $1
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
