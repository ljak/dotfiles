# Setup fzf
# ---------
if [[ ! "$PATH" == *~/.oh-my-zsh/custom/plugins/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}~/.oh-my-zsh/custom/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "~/.oh-my-zsh/custom/plugins/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "~/.oh-my-zsh/custom/plugins/fzf/shell/key-bindings.zsh"
