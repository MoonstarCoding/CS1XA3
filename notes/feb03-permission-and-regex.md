# More on Shell Scripting

## File Permissions

Un\*x systems specify permissions by three categories:

- User
- Group
- Others

Each with different combinations of read, write, and execute permissions - abbreviated as rwx permissions.

Every file has a File Type flag - simply stating whether the item is a file or a directory, an Owner - the User, a Group in which the item belongs to, and the permissions for all Others who don't fall into the previous categories.

So `-rwxrwxr-x` means that it is a file with User rwx, Group rwx, and Others rx permissions.

### Changing File Permissions

You can change permissions with the `chmod` command.

```bash
chmod u+x <file>
  # add executable for User level
chmod o+rw file
  # add read and write for the Others level
chmod -w file
  # remove the write permissions from all levels
```

This is a general `chmod` syntax guide.

```bash
chmod [{u,g,o}] (+ | -) {r,w,x}
  # the first list is optional, and if left out, it assumes all 3 categories.
```

You can also assign to all 3 groups at the same time through binary assignment.

```bash
chmod 760 <file>
  # gives rwx permission to User, rw to Group, while 0 permissions to Others
```

### Groups

Unix groups are a way of specifying permission to a group of users. By default, each user has their own group if the same name.

You can manually create groups - if you have the authority - with the `groupadd <groupname>` command.

Once created, you use `useradd -g <username> <groupname>` to add a user to the group.

### Changing Owners

Every file has an an owner and a group. You can manually change thes by calling `chown 'owner:group' <file>`. If you leave the owner keyword empty, you still must specify the group by using a colon.

## File Glob Patterns

Every file has global patterns and characters that can be searched for using a variety of search characters.

- The Asterisk (\*):

```bash
cp *.hs /newdir
  # copy all Haskell files to /newdir
```

- The Question Mark (?):

```bash
rm -r dev?
  # delete any directory with devX where X is a single character.
```

- The Square Brackets ([]):

```bash
rm sd[a,b,c]
  # delete files sda, sdb, sdc
```

- The Escape Character (\\ or /):

```bash
rm /*.hs
  # literally removes *.hs
```

> Note: We have different escape characters on Windows and Un\*x.
>
> Windows - The Backslash: \\
>
> Un\*x - The Forward Slash: /

Glob patterns expand to a list of delimiter separated files. So `cp *.txt /tmp` will expand to `cp 1.txt 2.txt ... /tmp`. This means you have to be cautious about what you type.

```bash
cp file.txt /dir*
  # This will copy a file and all directories before the last to the last directory
```

### Brace Expansion

Acting similar to square brackets, it allows you to generate ranges.

```bash
echo file.{txt,pdf,sh}
  # file.txt file.pdf file.sh

echo {a..e}
  # a b c d e

echo {2..-2}
  # 2 1 0 -1 -2
```

## Searching Lines of Text with GREP

The `grep <pattern> <input>` command is a regex - _regular experesion_ - style searching command that will look for regex patterns in inputs.

```bash
cat file | grep 'Mark is God'
  # will only print the lines containing my pattern.
```

Flags for `grep` include:

- Recursive - Files and Subdirectories: `grep -r pattern /dir`
- Recursive - Only Files: `grep -R pattern /dir`
- Reverse Grep: `grep -v pattern input`
- Ignore Case: `grep -i pattern input`

## Search and Mutate with SED

The `sed -flag pattern input` command won't return, but rather mutate the string. We only care about the `-i` flag for now, meaning **in-place**.

Regex is very important to being able to use this command, so please look into it or use a cheat-sheet like [this](https://medium.com/factory-mind/regex-tutorial-a-simple-cheatsheet-by-examples-649dc1c3f285).

To replace every instance of old to new in file.txt, we use `sed -i 's/old/new/d' file.txt`.

To delete every line containing new in file.txt, we use `sed -i '/new/d' file.txt`

> Note: This is powerful, so only use this when you need to, like in scripts.

## Find Stuff with FIND

The `find startdir [-flags] -name pattern` command will recursively find items starting from a directory of your choice. You can limit the depth of the search using the `-maxdepth` flag.

```bash
find . -maxdepth 1 -name dummy.pdf
  # searches current directory only for dummy.pdf
```

> Note: Find supports Glob Patterns, but not Regex Patterns. Also, quote your Glob Pattern to prevent expansion.

### Flags

Limiters:

- Find only files: `find . -type f -name "*.py"`
- Find only directories: `find . -type d`

Binary Operators:

- Logical and: `find . -name "*.txt" -name "p*"`
- Inclusive or: `find . -name "*.py" -or -name "*.sh"`
- Not: `find . -not -name "b*"`

## Piping Into XARGS

When you pipe stdout into a command, the entire output is put into stdin as one input.

```bash
ls | rm
  # tries to remove the entire utput of ls

ls | xargs rm
  # removes one by one
```

xargs is a command that takes one input and splits it by the delimiter; it breaks the stdout stream into multiple segments and pass it one at a time.

### Using XARGS Input in Place

Imagine we want to copy files found with find into a directory called `/tmp`.

In order to get the arguments to cp in the correct order, we need to use the `-i` flag.

```bash
find . name *txt | xargs -i cp '{}' /tmp
```

Now, we are piping into the `'{}'` special character instead of at the end like piping normally does.

> Note: Don't confuse this with **brace expansion**, it just is the default special character.

You can use `xargs -I 'char'` to specify the special character you prefer instead of `'{}'`.

### Living Dangerously

When you break things up with `xargs`, you have to be careful. Files or Directories with spaces can screw things up, so you have to account for that.

We tell find to replace the delimiter character using the flag `-print0` and inform xargs that it has changed as well.

```bash
find . -name *.txt -print0 | xargs -0 -i cp '{}' /tmp
```
