#!/bin/bash

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

scale="$2"
num1="$3"
case $1 in
  '1' | 'add')
    op='+'
    num2="$4"
    basic_arithmetic
    ;;
  '2' | 'sub')
    op='-'
    num2="$4"
    basic_arithmetic
    ;;
  '3' | 'mult')
    op='*'
    num2="$4"
    basic_arithmetic
    ;;
  '4' | 'div')
    op='/'
    num2="$4"
    basic_arithmetic
    ;;
  '5' | 'pow')
    op='^'
    num2="$4"
    basic_arithmetic
    ;;
  '6' | 'sqrt')
    sqrt
    ;;
  '7' | 'int_div')
    op='/'
    scale='0'
    num2="$4"
    basic_arithmetic
    ;;
  '8' | 'mod')
    num2="$4"
    mod
    ;;
  '9' | 'quad')
    a="$3"
    b="$4"
    c="$5"
    quad
    ;;
  '10' | 'cubic')
    a="$3"
    b="$4"
    c="$5"
    d="$6"
    cubic
    ;;
  '11' | 'frac_add')
    n1="$3"
    n2="$5"
    d1="$4"
    d2="$6"
    frac_add
    ;;
  '12' | 'frac_sub')
    # Information on String Slicing: https://stackoverflow.com/questions/10218474/how-to-obtain-the-first-letter-in-a-bash-variable
    if [ "${5:0:1}" = "-" ]; then
      RED='\033[0;31m' # Red Colour
      NC='\033[0m'     # No Colour
      printf "Double negative detected:\nPlease remove negative and call ${RED}11) Fraction Addition${NC}\n"
      exit 1
    else
      n2="-$5"
    fi
    n1="$3"
    d1="$4"
    d2="$6"

    frac_add
    ;;
  '13' | 'frac_mult')
    n1="$3"
    n2="$5"
    d1="$4"
    d2="$6"

    frac_mult
    ;;
  '14' | 'frac_div')
    n1="$3"
    n2="$6"
    d1="$4"
    d2="$5"

    frac_mult
    ;;
  '15' | 'frac_simp')
    numerator="$3"
    denominator="$4"

    frac_simp $denominator $numerator
    ;;
  *)
    RED='\033[0;31m' # Red Colour
    NC='\033[0m'     # No Colour
    printf "${RED}WARNING: ${NC}Invalid Calculation Code Passed.\nPlease double check inputs and try again.\n" ; exit 1
    ;;
esac

exit 0