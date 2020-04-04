# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ljak/.oh-my-zsh/custom/plugins/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ljak/.oh-my-zsh/custom/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ljak/.oh-my-zsh/custom/plugins/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ljak/.oh-my-zsh/custom/plugins/fzf/shell/key-bindings.zsh"
