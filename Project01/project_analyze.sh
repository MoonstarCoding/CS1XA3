#!/bin/bash

# find the location of the bash source:
# Inspiration for parent_path variable: https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")/.." ; pwd -P )
# parent_path = /home/hutchm6/private/CS1XA3

# Functions

function fixme_log () {
  # If file already exists, delete it and replace it
  [[ -f "$parent_path/Project01/fixme.log" ]] && rm "$parent_path/Project01/fixme.log"

  touch "$parent_path/Project01/fixme.log"

  # Find all files that contain the word '#FIXME'
  find "$parent_path/" -type f -iname "*" -not -path "$parent_path/.git/*" -print0 | while IFS= read -d '' file; do
    if tail -1 "$file" | grep -q "#FIXME"; then
        echo "$file" >> "$parent_path/Project01/fixme.log"
    fi
  done
  echo "fixme_log has completed it's search."
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

function basic_arithmetic () {
  echo "scale=$scale; $num1 $op $num2" | bc -l
}

function sqrt () {
  echo "scale=$scale; sqrt($num1)" | bc -l
}

function mod () {
  remainder=$(echo "scale=0; $num1 / $num2" | bc)
  echo "scale=0; $num1 - ($remainder * $num2)" | bc -l
}

function quad () {
  deter=$(echo "$b^2 - (4 * $a * $c)" | bc -l)
  echo "$deter"
  if [ $deter -lt 0 ]; then
    echo "The discriminant is less than 0: There are no real roots."
    exit 1
  else
    x1=$(echo "scale=$scale; (-$b + sqrt($deter)) / (2 * $a)" | bc -l)
    x2=$(echo "scale=$scale; (-$b - sqrt($deter)) / (2 * $a)" | bc -l)
    echo "Your roots are $x1 and $x2."
  fi
}

function cubic () {
  if [ $a -eq 0 ]; then
    echo "If a is 0, it isn't cubic."
    exit 1
  else
    p=$(echo "$b / (3 * $a)" | bc -l)
    q=$(echo "((3 * $a * $c) - ($b ^ 2)) / (9 * ($a ^ 2))" | bc -l)
    r=$(echo "((9 * $a * $b * $c) - (27 * ($a ^ 2) * $d) - (2 * ($b ^ 3))) / (54 * ($a ^ 3))" | bc -l)

    discriminant=$(echo "($q ^ 3) + ($r ^ 2)" | bc -l)

    if [ $(echo "$discriminant <= 0 && $r == 0" | bc -l) ]; then
      s="0"
      t="0"
    else
      s=$(echo "e(l($r + sqrt($discriminant))/3)" | bc -l)
      t=$(echo "e(l($r - sqrt($discriminant))/3)" | bc -l)
    fi

    x1=$(echo "scale=$scale; $s + $t - $p" | bc -l)

    if [ $(echo "$s == 0 && $t == 0" | bc -l) ]; then
      echo "The root that could be solved was $x1."
      exit 0
    fi

    real=$(echo "scale=$scale; -(($s + $t) / 2) - $p" | bc -l)
    imag=$(echo "scale=$scale; ((sqrt(3) / 2) * ($s - $t))" | bc -l)

    echo "The root that could be solved was $x1. X2 and X3 involve complex numbers, $real +/- i$imag."
  fi
}

function frac_add () {
  re='^[+-]?[0-9]+$'
  if ! [[ $d1 =~ $re ]] ; then
    echo "error: $d1 is not an Integer" >&2; exit 1
  fi
  if ! [[ $d2 =~ $re ]] ; then
    echo "error: $d2 is not an Integer" >&2; exit 1
  fi
  if ! [[ $n1 =~ $re ]] ; then
    echo "error: $n1 is not an Integer" >&2; exit 1
  fi
  if ! [[ $n2 =~ $re ]] ; then
    echo "error: $n2 is not an Integer" >&2; exit 1
  fi

  if [ $d1 -eq $d2 ]; then
    numerator=$(($n1 + $n2))
    echo "Your answer is the fraction: $numerator / $d1"
  else
    n1=$(echo "$n1 * $d2" | bc -l)
    n2=$(echo "$n2 * $d1" | bc -l)
    d1=$(echo "$d1 * $d2" | bc -l)
    d2="$d1"
    frac_add
  fi
}

function frac_mult () {
  re='^[+-]?[0-9]+$'
  if ! [[ $d1 =~ $re ]] ; then
    echo "error: $d1 is not an Integer" >&2; exit 1
  fi
  if ! [[ $d2 =~ $re ]] ; then
    echo "error: $d2 is not an Integer" >&2; exit 1
  fi
  if ! [[ $n1 =~ $re ]] ; then
    echo "error: $n1 is not an Integer" >&2; exit 1
  fi
  if ! [[ $n2 =~ $re ]] ; then
    echo "error: $n2 is not an Integer" >&2; exit 1
  fi

  numerator=$(($n1 * $n2))
  denominator=$(($d1 * $d2))
  echo "Your answer is the fraction: $numerator / $denominator"
}

function frac_div () {
  re='^[+-]?[0-9]+$'
  if ! [[ $d1 =~ $re ]] ; then
    echo "error: $d1 is not an Integer" >&2; exit 1
  fi
  if ! [[ $d2 =~ $re ]] ; then
    echo "error: $d2 is not an Integer" >&2; exit 1
  fi
  if ! [[ $n1 =~ $re ]] ; then
    echo "error: $n1 is not an Integer" >&2; exit 1
  fi
  if ! [[ $n2 =~ $re ]] ; then
    echo "error: $n2 is not an Integer" >&2; exit 1
  fi

  numerator=$(($n1 * $d2))
  denominator=$(($d1 * $n2))
  echo "Your answer is the fraction: $numerator / $denominator"
}

function frac_simp () {
# Due to Bash not having good function input parameters, I used a python shell in Bash for this. If bash scripting could let you define parameters, then this would be easy to translate into a bash script.
PYOUT=$(
python - <<EOF
numerator = $numerator
denominator = $denominator
def GCD(num1, num2):
  if num2 == 0:
    return num1
  else:
    return GCD(num2, num1 % num2)
commonDivisor = GCD(denominator,numerator)
print("The simplified fraction is {} / {}.".format(numerator/commonDivisor, denominator/commonDivisor))
EOF
)
echo $PYOUT
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
    if [ $# -gt 3 ]; then
      echo "Too many arguments given to ls_size feature"
      exit 1
    else
      # Human Readable Format Inspiration: https://www.cyberciti.biz/faq/linux-unix-bsd-appleox-du-output-in-gbmbpbtb/

      if [ -z "$2" ]; then
        desired_path="$parent_path"
      else
        desired_path="$2"
      fi

      if ! [ -z "$3" ]; then
        if [ "$3" -eq 1 ]; then
          OLDPWD=$PWD
          cd "$desired_path"
          find . -type f -iname "*" -print0 | xargs -r0 du -h | sort -hr
          cd $OLDPWD
        else
          find "$desired_path" -type f -iname "*" -print0 | xargs -r0 du -h | sort -hr
        fi
      else
        find "$desired_path" -type f -iname "*" -print0 | xargs -r0 du -h | sort -hr
      fi
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
  elif [ $1 = "find_tag" ]; then
    if [ $# -gt 1 ]; then
      echo "Too many paramiters passed to feature." && exit 1
    fi
    read -p "What single word tag are you looking for? " tag
    if [ -f "$parent_path/Project01/Tag.log" ]; then
      rm "$parent_path/Project01/Tag.log" && touch "$parent_path/Project01/Tag.log"
    else
      touch "$parent_path/Project01/Tag.log"
    fi
    find -type f -name "*.py" -print0 | while IFS= read -d '' file; do
      if egrep -q "^#.*$tag.*" "$file"; then
          egrep "^#.*$tag.*" "$file" >> "$parent_path/Project01/Tag.log"
      fi
    done
    echo "Feature find_tag completed."
  elif [ $1 = "calc" ]; then
    if [ $# -gt 3 ]; then
      echo "Too many arguments passed to Calculator Feature. Please refer to documentation for correct use."; exit 1
    fi
    if ! [ -z "$3" ]; then
      scale="$3"
    else
      scale="2"
    fi
    if [ -z "$2" ]; then
      read -p "What operation would you like to perform? " oper
    else
      oper="$2"
    fi
    case "$oper" in
      '1' | 'add')
        echo "Addition: "
        read -p "What is the first number? " num1
        read -p "What is the second number? " num2
        op='+'
        basic_arithmetic
        ;;
      '2' | 'sub')
        echo "Subtraction: "
        op='-'
        read -p "What is the first number? " num1
        read -p "What is the second number? " num2
        basic_arithmetic
        ;;
      '3' | 'mult')
        echo "Multiplication: "
        op='*'
        read -p "What is the first number? " num1
        read -p "What is the second number? " num2
        basic_arithmetic
        ;;
      '4' | 'div')
        echo "Division: "
        op='/'
        read -p "What is the first number? " num1
        read -p "What is the second number? " num2
        basic_arithmetic
        ;;
      '5' | 'pow')
        echo "Power: "
        op='^'
        read -p "What is the first number? " num1
        read -p "What is the second number? " num2
        basic_arithmetic
        ;;
      '6' | 'sqrt')
        echo "Square Root: "
        read -p "What is the number? " num1
        sqrt
        ;;
      '7' | 'int_div')
        echo "Integer Division: "
        op='/'
        scale='0'
        read -p "What is the first number? " num1
        read -p "What is the second number? " num2
        basic_arithmetic
        ;;
      '8' | 'mod')
        echo "Modulus: "
        read -p "What is the first number? " num1
        read -p "What is the second number? " num2
        mod
        ;;
      '9' | 'quad')
        echo "Quadratic Equation: "
        read -p "What is the a value? " a
        read -p "What is the b value? " b
        read -p "What is the c value? " c
        quad
        ;;
      '10' | 'cubic')
        echo "Basic Cubic Equation: "
        read -p "What is the a value? " a
        read -p "What is the b value? " b
        read -p "What is the c value? " c
        read -p "What is the d value? " d
        cubic
        ;;
      '11' | 'frac_add')
        echo "Fraction Addition: "
        read -p "What is the first numerator? " n1
        read -p "What is the first denominator? " d1
        read -p "What is the second numerator? " n2
        read -p "What is the second denominator? " d2
        frac_add
        ;;
      '12' | 'frac_sub')
        echo "Fraction Subtraction: "
        # Information on String Slicing: https://stackoverflow.com/questions/10218474/how-to-obtain-the-first-letter-in-a-bash-variable
        read -p "What is the first numerator? " n1
        read -p "What is the first denominator? " d1
        read -p "What is the second numerator? " n2
        read -p "What is the second denominator? " d2
        if [ "${n2:0:1}" = "-" ]; then
          n2="${n2:1}"
        else
          n2="-$n2"
        fi
        frac_add
        ;;
      '13' | 'frac_mult')
        echo -p "Fraction Multiplication: "
        read -p "What is the first numerator? " n1
        read -p "What is the first denominator? " d1
        read -p "What is the second numerator? " n2
        read -p "What is the second denominator? " d2
        frac_mult
        ;;
      '14' | 'frac_div')
        echo "Fraction Division: "
        read -p "What is the first numerator? " n1
        read -p "What is the first denominator? " d1
        read -p "What is the second numerator? " n2
        read -p "What is the second denominator? " d2
        frac_div
        ;;
      '15' | 'frac_simp')
        echo "Fraction Simplification: "
        read -p "What is the numerator? " numerator
        read -p "What is the denominator? " denominator
        frac_simp $denominator $numerator
        ;;
      *)
        RED='\033[0;31m' # Red Colour
        NC='\033[0m'     # No Colour
        printf "${RED}WARNING: ${NC}Invalid Calculation Code Passed.\nPlease refer to documentation for information on inputs for this feature.\n" ; exit 1
        ;;
    esac
  elif [ $1 = "new_git" ]; then
    if [ $# -gt 4 ]; then
      echo "Too many arguments passed to feature." && exit 1
    fi
    if [ $# -lt 2 ]; then
      echo "Not enough arguments passed to feature." && exit 1
    fi
    if [ -z $3 ]; then
      branch="$2"
    else
      branch="$3"
    fi
    if [ -z $4 ]; then
      msg="Added new git_project - $2"
    else
      msg="$4"
    fi

    cd "$parent_path"
    git branch $branch
    git checkout $branch
    if [ -d "$2" ]; then
      echo "Directory already exists." && exit 1
    else
      mkdir "$2"
    fi
    printf "# Project - $2\n\n## Usage\nExecute this script from project root with:\n\nWith possible arguments\n\n## Feature 01\nDescription: this feature does ...\nExecution: execute this feature by ...\nReference: some code was taken from [https://someurl.com]" > "./$2/README.md"
    git add -A
    git commit -m "$msg"
    cd "./$2"
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