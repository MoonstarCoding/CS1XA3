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
  '10')
    a="$3"
    b="$4"
    c="$5"
    d="$6"
    cubic
    ;;
  *)
    #CODE
    ;;
esac

exit 0