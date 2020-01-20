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
