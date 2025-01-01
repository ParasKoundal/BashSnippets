emoji() {
    local emojis=("😀" "👍" "🌟" "🔥" "💻" "🚀" "👨‍💻" "👩‍💻" "📈" "📚" "💡" "🤔" "👀" "🤩" "🥳" "🎉" "🌈" "🦄" "🐬" "🍕" "🍔" "🍩" "🍺" "🍷" "🎨" "🎸" "🎤" "🎬" "🎮" "🚲" "🏖️" "🏙️" "🛫" "🏆" "🎓" "💰" "💼" "🗝️" "🌅" "🌌" "🌺" "🌸" "🌻")
    echo -n "${emojis[$RANDOM % ${#emojis[@]}]} "
}
# Show Emoji. Example Output : user@hostname ~/folder$ 🎉
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$\[\033[00m\] \$(emoji)\$"