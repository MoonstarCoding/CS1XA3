# Bash Scripting

## Creating Your Scripts

To begin, start by doing `echo "#!/bin/bash" >> <filename>.sh` to create the file with a link to your system's bash script runner. After this, edit the file to have the code you want to run. Follow the example below.

```bash
  echo "#!/bin/bash" >> test1.sh # Create File and Specify Interpreter
  nano test1.sh                  # Open file
  # In file
    echo "Hello World!"
    # CTRL + O, CTRL + X
  chmod +x test1.sh              # Make File Executable
  ./test1.sh                     # Run Script
```

or

```bash
  echo "#!/usr/bin/python" >> test1.py # Create File and Specify Interpreter
  nano test1.py                        # Open file
  # In file
    print("Hello World!")
    # CTRL + O, CTRL + X
  chmod +x test1.py                    # Make File Executable
  ./test1.py                           # Run Script
```

## Variables in Bash

You set the variable in python syntax, but you call the variable in php syntax. So in your file, you can do:

```bash
# In File
var="Content of Var"        # This requires quotes because there is whitespace
var2=Hello                  # This is a valid string due to lack of whitespace
var3=This\ is\ also\ valid. # This is valid because I escaped the spaces

echo $var && echo $var2
```

> Note: You **DO NOT** have whitespace in bash scripting because whitespace actually matters in bash.

What happens is anything after that calls `$var` will search the previous file for what it should be replaced with. Variables can also call other variables within them, exactly like other languages.

### Double vs Single Quotes

Single Quotes are literal, meaning everything inside them will be interpreted exactly as typed, no substitution. Double Quotes allow you to have variables within strings by using the `$`. It is safer to just use Double Quotes since if you don't have variables, nothing changes anyways.

So you can think of Double Quotes as being removed during interpretation. And if you wrap `"$var"` as so, it will put the quotes back around them.

### Input Variables

Special Variables:

- $1-$9: Specify the first n elements
- \$@: All arguments supplied at once
- \$#: The number of arguments passed

```bash
if [ $# -eq 2 ]; then
  echo $1
  echo $2
else
  echo "Incorrect Inputs"
fi
```

> Note: Bash has no type system. Everything is just text. Text can be joined by literally just joining things.
> So `$path1$path2` is that same as `path1 + path2` in python.

## Command Substitution

If you want to assign a variable to the output of a command, you use Command Substitution.

```bash
#!/bin/bash

count=$(ls -l | grep -v total | wc -l)
echo "Number of files in directory is $count"
```

### SubShells

When using command substitution, the evaluate code is executing in a SubShell. This allows variable assignment to be hidden from the parent shell, unless the export command is used.

```bash
#!/bin/bash

PATH="/dir1/dir2:$PATH"
export PATH
```

## Integer Arithmetic

Alright, this is going to be interesting.

When you want to do Arithmetic in Bash Scripting, you need to use the `$((<expression>))` notation. We can assign variables and treat them as numbers in this double parenthesis environment.

The Double Parenthesis Environment is just another way of using the `expr` command. So `$((<expression>))` is the same as `$(expr <expression>)`

## If Statements

Earlier, we saw an example of an if statement that forced the user to have 2 inputs for a function.

Notice how if statements in bash scripting use the square brackets. This is actually similar to Double Parenthesis notation, but for a different command. `if [ <expression> ]; then` is the same as typing `if test <expression>; then`.

String Tests:

- ! `<expr>`: Not Expression
- -n `<str>`: length of String > 0
- s1 = s2: The same as ==

Integer Tests:

- i1 -eq i2: The same as ==
- i1 -gt i2: The same as >
- i1 -lt i2: The same as <

File Tests:

- -e ITEM: ITEM exists
- -f FILE: FILE exists and is Regular File
- -d DIR: DIR exists and is Directory
- -x FILE: FILE exists and has executable permission.

Boolean Operations:

- &&: AND
- ||: OR

> Note: Do not use this in the same square brackets as another expression. Each must be tested uniquely, thus only `if [ <expr 1> ] || [ <expr 2> ];then` is a valid syntax

## Loops

To wrap it up, let's define our basic for and while loops. For all references in this section, the start of the file is what is below.

```bash
#!/bin/bash

INPUT="one two three"
```

### For Loops

There are two types of For Loops. The ForEach loop and the C Style For Loop.

For Each:

```bash
for item in $INPUT ; do
  echo $item
done
```

C Style For:

```bash
for ((i=0 ; i < 10 ; i++))  ; do
  echo "Counter: $i"
done
```

### While Loops

```bash
COUNT=0
while [ "COUNT" -lt 10 ] ; do
  echo "$COUNT"
  COUNT=$(( $COUNT + 1 ))
done
```

> Note: The spacing of the loops is important as well as how you increment each loop. Note that while loops require integer operations to be done manually.

## The Case Statement

Finally, the case statement. This is a just an over-glorified `if elif else` chain.

```bash
case  $variable  in
  pattern1|pattern2|pattern3)
    command1
    ...
    ....
    commandN
    ;;
  pattern4|pattern5|pattern6)
    command1
    ...
    ....
    commandN
    ;;
  pattern7|pattern8|patternN)
    command1
    ...
    ....
    commandN
    ;;
  *)
esac
```

## The Internal Field Separator

Bash uses a Field Separator to separate commands. You can define this yourself using the IFS variable.

```bash
#!/bin/bash

IFS=$":"
INPUT="a:b:c:d"
for field in $INPUT; do
    echo $field
done
unset IFS

INPUT="a b c d"
for field in $INPUT; do
    echo $field
done
```
