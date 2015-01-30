
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

export PS1='$(prompt_command)\n'$PS1

################################################################################

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

