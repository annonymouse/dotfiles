
# Thanks Christfo!
################################################################################

function hbar()
{
    eval printf '%.0s$2' {1..$1}
}
function prompt_command()
{
    local sv=$?
    local cols=`tput cols`
    hbar $[ $cols - 5 ] "_"
    printf "% 3d" $sv
}

# Don't run this twice.  Double check we don't run bashrc twice anyway.
[[ $PS1 = '$(prompt_command)\n'* ]] || export PS1='$(prompt_command)\n'$PS1

################################################################################

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
alias tatum=less
alias channing=grep
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$HOME/arc/arcanist/bin:$HOME/code/go_appengine
export GOPATH=$HOME/code/go
echo "Checking dotfiles..."
homeshick refresh -f 7
