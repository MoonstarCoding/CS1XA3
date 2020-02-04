#!/bin/bash

# User Input Checker

if [ $# -gt 0 ]; then

  # if user requested fixme_log function
  if [ $1 = "fixme_log" ]; then

    # Find all files that contain the word '#FIXME'
    find . -type f -print0 | xargs -0 -i grep -rlw '{}' -e '#FIXME' > CS1XA3/Project01/fixme.log

    exit 0

  else

    # input is not a valid option
    echo "This input is not a valid input for this script."
    exit 1

else

  # the script has not been given any inputs, exit with error
  echo "No argument given to file."
  exit 1

fi