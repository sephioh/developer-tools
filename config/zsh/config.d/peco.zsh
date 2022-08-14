# ctrl+r -> find file
function peco_select_history() {
  local tac
  if which gtac >/dev/null 2>&1; then
    tac="gtac"
  elif which tac >/dev/null 2>&1; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER="$(fc -l -n 1 | eval "${tac}" | peco --query "$LBUFFER")"
  CURSOR=$#BUFFER # move cursor
  zle -R -c       # refresh
}

zle -N peco_select_history
bindkey "^R" peco_select_history
###################################


function peco_select_file() {
  ag -l | peco $peco_flags | read line
  if test $line; then
    vim $line
  fi
}

zle -N peco_select_file
bindkey "^F" peco_select_file
#

