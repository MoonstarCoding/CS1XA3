#!/bin/bash

# User Input Checker

if [ $# -gt 0 ]; then

  # if user requested fixme_log function
  if [ $1 = "fixme_log" ]; then

    tocuh ./fixme.log

    # clear log file
    echo "" >> ./fixme.log

    # Find all files that contain the word '#FIXME'
    find .. -type f -print0 | xargs -0 -i grep -rlw '{}' -e '#FIXME' | while IFS= read -d '' file
    do
      echo cat $file | tail -1 |  xargs -i grep -rlw '{}' -e '#FIXME' > ./fixme.log
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