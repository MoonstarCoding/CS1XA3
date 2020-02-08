#!/bin/bash

# find the location of the bash source:
# Inspiration for parent_path variable: https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")/.." ; pwd -P )
# parent_path = /home/hutchm6/private/CS1XA3

# Functions

function fixme_log () {
  # If file already exists, delete it and replace it
  [[ -f "$parent_path/Project01/fixme.log" ]] && rm "$parent_path/Project01/fixme.log"
  # Make the file
  touch "$parent_path/Project01/fixme.log"
  # Find all files that contain the word '#FIXME'
  find "$parent_path/" -type f -print0 | while IFS= read -d '' file; do
    if tail -1 $file | grep -q "#FIXME"; then
        echo "$file" >> "$parent_path/Project01/fixme.log"
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
  elif [ $1 = "ls_size" ]; then
    if [ $# -gt 2 ]; then
      echo "Too many arguments given to ls_size feature"
      exit 1
    else
      # Human Readable Format Inspiration: https://stackoverflow.com/questions/64649/how-do-i-get-the-find-command-to-print-out-the-file-size-with-the-file-name

      if [ -z "$2" ]; then
        desired_path="$parent_path"
      else
        desired_path="$2"
      fi

      find "$desired_path" -type f -printf "%kKB %p\n" | sort -nr | column -t
    fi
  elif [ $1 = "count_type" ]; then
    if [ -z "$2" ]; then
      desired_path="$parent_path"
    else
      desired_path="$2"
    fi

    read -p 'File Extension: ' extension

    if [ ! -z "$extension" ]; then
      count=$(find "$desired_path" -type f -name "*.$extension" | wc -l)
      if [ $count -eq 1 ]; then
        echo "There is 1 file ending in $extension in $desired_path."
      else
        echo "There are $count files ending in $extension in $desired_path."
      fi
    else
      count=$(find "$desired_path" -type f | wc -l)
      echo "No extension given: there are $count files in $desired_path."
    fi
  else
    # input is not a valid option
    echo "This input is not a valid input for this script."
    exit 1
  fi
else
  # the script has not been given any inputs, exit with error
  echo "No argument given to file. All user input must be given through arguments."
  exit 1
fi

exit 0