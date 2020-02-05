#!/bin/bash

# find the location of the bash source:
# Inspiration for parent_path variable: https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")/.." ; pwd -P )
# parent_path = /home/hutchm6/private/CS1XA3

# Functions

function fixme_log () {
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
}

function checkout_merge () {
  # Help on parsing first word from string line: https://stackoverflow.com/questions/2440414/how-to-retrieve-the-first-word-of-the-output-of-a-command-in-bash
  # Checking if variable is set: https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash

  key_word="merge"
  commit=$(git log -i --grep="$key_word" -1 --oneline | head)
  set - $commit

  if [ -z ${1+x} ]; then
    echo "No commit found with keyword \"$key_word\""
  else
    git checkout $1
  fi
}

function file_size_list () {
  ls -psRh | grep -v / | while read line; do
    if [[ $line =~ ^[0-9] ]]; then
      echo $line
    fi
  done
}

# User Input Checker

if [ $# -gt 0 ]; then
  # if user requested fixme_log function
  if [ $1 = "fixme_log" ]; then
    if [ $# -gt 1 ]; then
      echo "Too many arguments given to fixme_log feature"
      exit 1
    else
      fixme_log
    fi
  elif [ $1 = "checkout_merge" ]; then
    if [ $# -gt 1 ]; then
      echo "Too many arguments given to checkout_merge feature"
      exit 1
    else
      checkout_merge
    fi
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