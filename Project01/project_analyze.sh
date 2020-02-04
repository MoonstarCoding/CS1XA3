#!/bin/bash

# find the location of the bash source:
# Idea from https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# parent_path = /home/hutchm6/private/CS1XA3/Project01

# User Input Checker

if [ $# -gt 0 ]; then

  # if user requested fixme_log function
  if [ $1 = "fixme_log" ]; then

    touch "$parent_path/fixme.log"

    # clear log file
    echo "" >> "$parent_path/fixme.log"

    # Find all files that contain the word '#FIXME'
    find "$parent_path/../" -type f -print0 | xargs -0 -i grep -rlw '{}' -e '#FIXME' | while IFS= read -d '' file
    do
      echo cat $file | tail -1 |  xargs -i grep -rlw '{}' -e '#FIXME' > "$parent_path/fixme.log"
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
