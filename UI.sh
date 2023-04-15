#!/bin/bash

# Define the path to the 'panel' folder
PANEL_FOLDER="./panel"

# Create the 'panel' folder if it does not exist
if [ ! -d "$PANEL_FOLDER" ]; then
  mkdir "$PANEL_FOLDER"
fi

# Get the list of .sh files in the 'panel' folder
FILES=$(ls "$PANEL_FOLDER"/*.sh 2>/dev/null)

# If no .sh files are found, display an error message
if [ -z "$FILES" ]; then
  zenity --error --text="No panel files found in '$PANEL_FOLDER' folder!"
  exit 1
fi

# Create an array to store the list items
LIST_ITEMS=()

# Loop through each .sh file and add its name to the list items
for FILE in $FILES; do
  FILENAME=$(basename "$FILE" .sh)
  LIST_ITEMS+=("$FILENAME")
done

# Function to execute the selected .sh file
function execute_panel() {
  selected_panel="$1"
  bash "$PANEL_FOLDER/$selected_panel.sh"
}

# Use Zenity to create a list dialog with the list items
selected_panel=$(zenity --list --title="Panel List" --text="Select a panel:" --column="Panel" "${LIST_ITEMS[@]}")

# Check if a panel is selected and call the function to execute it
if [ -n "$selected_panel" ]; then
  execute_panel "$selected_panel"
fi
