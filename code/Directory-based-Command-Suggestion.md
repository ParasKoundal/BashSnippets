# Suggest commands based on the current directory
LAST_SUGGESTION_DIR=""
suggest_commands() {
    local current_dir=$(pwd) # TODO : Solve MAC issue by making it dynamic
    
    # Check if we are in a new directory
    if [[ "$LAST_SUGGESTION_DIR" != "$current_dir" ]]; then
        if [[ "$current_dir" == *"/analysis/code/"* ]]; then
            echo "You can run: python run.py"
        elif [[ "$current_dir" == *"/analysis/trainModel"* ]]; then
            echo "You can run: python models/train.py"
        fi
        # Update the last suggestion directory
        LAST_SUGGESTION_DIR="$current_dir"
    fi
}
PROMPT_COMMAND="suggest_commands; $PROMPT_COMMAND"