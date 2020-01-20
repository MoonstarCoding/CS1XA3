# Version Control With Git

Version control is the act of committing different versions of a program to cloud storage, thus allowing you to back up at any time.

A central server will keep all increments of a piece of software for you to pull if you need.

## Centralized Version Control

Centralized Version Control allows a single Person to back up files to a central server, but files from Person A and Person B would remain separate until uploaded. Also, uploads will overwrite instead of syncing and mutating.

## Distributed Version Control

Distributed Version Control allows you to take the whole server's database and allow multiple people to synchronize pieces to the server, or the entire thing. This allows large groups to work on a single project.

## Git Commands

These are some commands you will need to set up Git on a computer and control your repository. Make sure you are in a folder you don't mind downloading your repository to.

It will be up to you to find out how to configure Git before attempting this.

```bash
git clone <repo url>             # This will initialize the repo
ls                               # Use this to see what files exist in your directory
cd <repo name>                   # Navigate to your repo

# The following commands are the native GitHub commands for initializing a repo

echo "<text>" >> README.md       # Create your README.md file
git init                         # Initialize the repository
git add README.md                # Add that file to your commit package
git commit -m "<commit message>" # Give the commit a message and pack it
git remote add origin <repo url> # Create the remote access point
git push -u origin master        # Push the package
```

## Local Repo Workflow

There are 3 main development areas to Git workflow.

- Working Directory
- Staging Area
- The Git Server

The `Working Directory` is where you do all the editing, the `Staging Area` is where you put everything and prepare it for shipping, and a commit will save and ship to the `Git Server`.

> The command `git status` will tell you if a file exists in the `Working Directory` which hasn't been `staged`, or if a `stage` exists in the `Staging Area` and a `commit` hasn't been made. it will not tell you to `push` your `stage`, but it will tell you how many `commits` ahead of the `Git Server` you are.

## More Commands

These are just a but ton of git commands and short explanations:

```bash
git add <file/-A>               # Add file to Staging Area
git rm <file/dir>               # Remove a file/dir from Git Server
git status                      # Check current Git status
git reset <optional: file>      # Reset Staging Area
git log <--online/--graph>      # Check the history of the repo <one commit only/check branches>
git diff <commit id> <file>     # Check the differences between files
```

## Git Repo Workflow

After you have edited the local database, you can transfer and sync that database to a `Git Server`. You go from `Local Workspace` to `Staging Area`, `Staging Area` to `Local Repo`, and `Local Repo` to `Server Repo`. To go between them, you will have to either `push` or `pull`... or use the `fetch`, `check`, `merge` method, but that isn't very beginner friendly.

> The command `git remote -v` shows you the remote repo url you are using.

```bash
git pull origin           # Pull files from Git Server in 1 step
git push origin <branch>  # Push commit to Git Server in 1 step
```

### Merge Conflicts

If the server and the local have differences in the same area of a file, it will have a `Merge Conflict`. You will have to manually fix the conflicts between the files and then pull as you intended. To help minimize this, always `pull` from a `Git Server` before working and double check you are the only editor at the moment.

To fix it **manually**, open the file and look for something like the following:

```bash
<<<<<<< HEAD
  print("This is the Local/Current Change")
=======
  print("This is the Server/Incoming Change")
>>>>>>>
```

> Note: In Visual Studio Code, it recognizes this format and adds easy buttons to troubleshoot on your behalf. I will show you how to fix it yourself.

To fix it **automatically** using Git, you can do the following:

```bash
git checkout --ours <file>    # Merge file to match my changes
git checkout --theirs <file>  # Merge files to match their changes
git merge --abort             # Ignore it and fix it later
git merge --continue          # Continue with the merging
# OR you can do git add and git commit
```

## Fixing Your Screw-Ups

### Step 1 - Prevent It

- Make frequent commits.
- Work from a testing branch and only merge working code to `master` branch.
- Always do a `git pull` before doing any work.

### Step 2 - You've Already Screwed Up

- Retrieve a file from an earlier commit with `git checkout`
- Undo a previous commit with `git revert`

> #### Restoring a File using git checkout
>
> The command `git checkout <commit id> <file/dir>` will save you in so many moments. You can go back to the last commit made and pull specific items from it - thus checking the out from that commit into your current `Workspace`. Using `git log --graph` will make it easier to check all the commits and find the best commit and it's id. This is also why frequent commits are extremely useful.
>
> #### Undoing Whole Commits
>
> Using `git revert <HEAD/commit id>` will let you essentially `ctrl-z` your way through your file history back to a commit point.
>
> #### Remove Local Changes Before Commit
>
> Using `git stash` will take all changes that aren't deleting a file, and kind of stash them away. We use this instead of `git checkout` because we can undo this without making a commit. Using `git stash pop`, you can bring back all the changes you stashed away.
