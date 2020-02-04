#!/bin/bash

# find the location of the bash source:
# Idea from https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")/.." ; pwd -P )
# parent_path = /home/hutchm6/private/CS1XA3

# User Input Checker

if [ $# -gt 0 ]; then
  # if user requested fixme_log function
  if [ $1 = "fixme_log" ]; then
    # Attempt to remove the previous log file, or create it if you can't
    rm "$parent_path/Project01/fixme.log" || touch "$parent_path/Project01/fixme.log"
    # Fill it with nothing to be safe
    echo "" >> "$parent_path/Project01/fixme.log"
    # Find all files that contain the word '#FIXME'
    find "$parent_path/" -type f -print0 | while IFS= read -d '' file; do
      if tail -1 $file | grep -q "#FIXME"; then
          echo "$file" > "$parent_path/Project01/fixme.log"
      fi
    done
  else
    # input is not a valid option
    echo "This input is not a valid input for this script."
    exit 1
  fi
else
  # the script has not been given any inputs, exit with error
  echo "No argument given to file."
  exit 1
fi
exit 0