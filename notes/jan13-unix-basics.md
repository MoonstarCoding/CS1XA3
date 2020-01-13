# SSH and Basic Un\*x Commands

## Mark Hutchison - January 13th, 2019

First thing you will need to do is learn how to open a command prompt terminal.

## For Windows

Press Windows Key + R and type `cmd`.

## For Un\*x

Search for the `Terminal` application.

I will be using the application Terminus for this course.

Begin by doing doing the following:

```powershell
  ssh username@domain.com
  # enter password prompt
  # do something
  exit
```

For the McMaster Computer Science 1XA3 course, we have been given a server to SSH into. For security, this SSH server will not be made available on my GitHub.

Typically, using `CTRL + L`, you will clear a terminal screen. However, on Terminus, this opens a local terminal. I will be using the `clear` command instead.

### SCP Command

The `scp` command allows you to transfer files from Point A to Point B. For example, if I wanted to move this file to a server, I would do:

```powershell
  scp file_directory username@domain.ca:~
```

### Find

The `find` command gets you the directory to a file you are attempting to find.

### LS

The `ls` command shows you all files and folders in a directory

### CD

The `cd` command moves you from directory to directory.

## Flags

After a command, if you put `-` and some letter, you modify the parameters of a command.

For example, `uname -a` gathers all information about the server or device you are using.

## File Paths

File Paths are used with the `cd` command. For example:

```powershell
  cd /    # Root Directory
  cd `    # Home Directory
  cd .    # Current Directory
  cd ..   # Previous Directory
  pwd     # Shows the Parent Directory Name
```

### Absolute File Paths

File paths beginning with a `/` are considered to be absolute file paths as they start at the root directory. The root directory is the absolute furthest back you can go in a computer system.

```powershell
  cd /home/username/    # Goes from the Root Directory to my home directory
```

### Relative File Paths

If a file path doesn't start with the `/`, it will be relative to the directory that it is contained in.

> Note: Most operating systems don't need extensions to be specified and can tell when something is a file or a folder.

### File Directory Manipulation

This includes:

- Creation
- Deleting
- Manipulation
- And more

### Creation

Both `touch` and `mkdir` can create files. However, you will use `mkdir` more and probably will just use `scp` to transfer files to a server.

```powershell
  touch filename.extension  # Creates file in directory

  mkdir name                # Makes folder in directory
```

### Deleting

The `rm` command is designed to destroy a file or folder. When paired with `-r`, it recursively deletes the contents of a directory, and then the directory itself.

```powershell
  rm filename  # Destroys file (or files) in directory
  rm -r directory        # Destroys file (or files) in directory
```

> Warning: There is no recovering from this. This is permanent.

### Copying a File

The `cp` command will take an existing file and will copy it. Once again, using `-r` will allow you to copy a directory recursively.

```powershell
  cp filename destination       # Copy a file to a new destination
  cp -r directory destination   # Copy a directory to a new destination
```

> Note: If the destination doesn't exist, it will simply create it and make it the exact same as the source

### Moving a File

The `mv` command will take an existing file and will copy it. However, you do not need to use the `-r` flag on directories.

```powershell
  mv filename destination       # Move a file to a new destination
  mv directory destination      # Move a directory to a new destination
```

> Note: You can use `mv` to rename a file or directory.

## Terminal Based Code Editors

Some pure terminal code editors include:

- Emacs
- Vi/Vim
- Nano

> Note: Most desktop editors have some method of remote editing, so using terminal-based editors isn't required.

By using `nano filename`, you will be brought to an editor within the server itself.

> Note: `emacs filename` and `vim filename` both work as well. Personally, I prefer `vim` over `nano` because of how simple it is to navigate with it's navigation and editing modes being kept separate.

## Manuals

If you ever get confused, you can use `man command_name` on the bulk majority of commands to learn everything about it.

When in the manual, use `\` to search for what you are looking for. You can use `n` to go to the next occurrence of that search term.

When you're done, press `q` to quit.

> Note: Even the most simple commands will have pages of flags and features for you to view.

## Standard Streams (IO)

There are three standard streams to be aware of:

- `stdin` - Standard Input
- `stdout` - Standard Output
- `stderr` - Error Output

More than these exist, but these are our focuses.

### Commands to Work with Standard Streams

#### Outputs

The command `echo` allows you to print an output, and the command `cat` dumps the contents of a file as `stdout` instead of an editor format.

> Note: Editor format is a non-standard stream.

#### Inputs

The command `read` allows you to input something to a variable, where the variables are called with a `$`.

```powershell
  read name    # Takes input and assigns it to name variable
  echo $name   # Outputs the name variable
```

### IO Redirection

The following code uses the `>` symbole to redirect `stdout` to create **/ overwrite** a file.

```powershell
  touch file               # Make a file
  echo Hello World > file  # Overwrite file with message
  cat file                 # print file contents

  # Output: Hello World
```

The following code uses the `>>` symbole to redirect `stdout` to create **/ append** to a file.

```powershell
  touch file                  # Make a file
  echo Hello World > file     # Overwrite file with message
  echo Goodbye World >> file  # Append file with message
  cat file                    # print file contents

  # Output:
  # Hello World
  # Goodbye World
```

> Note: You can generally use this method to create files, but only when in Bash, and not ZSH. In our case, this actually only does the bolded text when called.

The `2>` symbol allows you to push `stderr` to a file, but doesn't impact the `stdout`. With python, we will be doing this a lot.

```powershell
  python3 script.py > output.txt  # Outputs are overwritten into output.txt
  python3 script.py 2> log.txt    # Errors are overwritten into log.txt
```

The `&>` symbol allows you to push `stdout` **and** `stderr` to a file.

```powershell
  python3 script.py &> log.txt  # Outputs and Errors are overwritten into log.txt
```

#### Piping

The **Pipe Operator** lets you pipe a `stdout` into an `stdin`.

```powershell
  cat log.txt | read var  # Take the output and make it an input
  echo $var               # Outputs the file contents

  ps aux | grep ssh       # find all processes that use ssh
```
