#!/bin/bash

function basic_arithmetic () {
  echo "scale=$scale; $num1 $op $num2" | bc
}

function sqrt () {
  echo "scale=$scale; sqrt($num1)" | bc
}

function mod () {
  remainder=$(echo "scale=0; $num1 / $num2" | bc)
  echo "scale=0; $num1 - ($remainder * $num2)" | bc
}

function quad () {
  deter=$(echo "$b^2 - (4 * $a * $c)" | bc)
  echo "$deter"
  if [ $deter -lt 0 ]; then
    echo "The discriminant is less than 0: There are no real roots."
    exit 1
  else
    x1=$(echo "scale=$scale; (-$b + sqrt($deter)) / (2 * $a)" | bc)
    x2=$(echo "scale=$scale; (-$b - sqrt($deter)) / (2 * $a)" | bc)
    echo "Your roots are $x1 and $x2"
  fi
}

scale="$2"
num1="$3"
case $1 in
  '1')
    op='+'
    num2="$4"
    basic_arithmetic
    ;;
  '2')
    op='-'
    num2="$4"
    basic_arithmetic
    ;;
  '3')
    op='*'
    num2="$4"
    basic_arithmetic
    ;;
  '4')
    op='/'
    num2="$4"
    basic_arithmetic
    ;;
  '5')
    op='^'
    num2="$4"
    basic_arithmetic
    ;;
  '6')
    sqrt
    ;;
  '7')
    op='/'
    scale='0'
    num2="$4"
    basic_arithmetic
    ;;
  '8')
    num2="$4"
    mod
    ;;
  '9')
    a="$3"
    b="$4"
    c="$5"
    quad
    ;;
  *)
    #CODE
    ;;
esac

exit 0