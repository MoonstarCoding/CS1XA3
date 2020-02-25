# CS 1XA3 Project01 - hutchm6

## Usage

User Input for this script is done through arguments. Any feature that requires additional prompts to function will prompt you when the feature is run.
Execute the script from root using the following command:

```bash
chmod +x CS1XA3/Project01/project_analyze.sh
./CS1XA3/Project01/project_analyze.sh feature arg1 ...
```

With the following possible arguments:

> Note: Bolded Arguments are required.

- **feature** - Feature Argument: This argument will let you specify the feature you desire out of the features below. Refer to feature documentation for more information.
- _arg1_: Depending on the feature, additionally arguments may be called for. Refer to feature documentation for more information.


## CHECKOUT LATEST MERGE

- Description: The purpose of this feature is to find the last git commit that contains the word `merge` in its commit message. After that commit is found, the commit will be checked out and put the user in a detached head state.
- Arguments:
  - **`checkout_merge`**: The required feature name for calling the feature.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh checkout_merge
```

- External Resources:
  - Parsing first word from string line: <https://stackoverflow.com/questions/2440414/how-to-retrieve-the-first-word-of-the-output-of-a-command-in-bash>
  - Checking if variable is set: <https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash>

## FILE SIZE LIST

- Description: List the file size and relative filename of **every** file, hidden and contents of .git folder if included, with in a directory and sub directories in human readable format.
- Arguments:
  - **`ls_size`**: The required feature name for calling the feature.
  - `directory`: This argument will allow you to specify what directory the feature starts at. The default value is the `Git Root` directory.
  - `relative`: If this value is set to 1, this will shorten the absolute file directories to be relative to the specified directory. If you are in the CS1XA3 folder, simply put a `.` for relative file names.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh ls_size <directory> <relative: 1>
```

- External Resources:
  - Human Readable Format via `du` command: <https://www.cyberciti.biz/faq/linux-unix-bsd-appleox-du-output-in-gbmbpbtb/>

## FILE TYPE COUNT

- Description: Count how many files in a directory end in a user specified extension. If no extension is given, it will count how many files there are.
- Arguments:
  - **`count_type`**: The required feature name for calling the feature.
  - `directory`: This argument will allow you to specify what directory the feature starts at. The default value is the `Git Root` directory.
  - `extension`: Once the script is run, you will be prompted to input a file extension. Failure to do so will result in a count of all files in a directory.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh count_type <directory>
```

## CUSTOM - GIT PROJECT SETUP

- Description: Running this command will setup a brand new folder in your repository, (./CS1XA3/), branch, and automatically switch to the new created branch. This will also create a README.md file with sample text inside it, and make the first commit with a message.
- Arguments:
  - **`new_git`**: The required feature name for calling the feature.
  - **`folder_name`**: This argument specifies the name of the folder you will be creating in your repo.
  - `branch_name`: This allows you to specify the working branch you develop in. Leaving this argument blank will just default to master.
  - `commit_message`: This allows the user to change the custom commit message during the creation process.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh new_git repo_name <branch_name> <"commit_message">
```

## CUSTOM - CALCULATOR MULTI-TOOL

- Description: Using the `bc` command, this feature will let you do a variety of mathematical operations. Each operation will require different inputs, so this will be done with user prompts in the script.
- Arguments:

  - **`calc`**: The required feature name for calling the feature.
  - `operation`: This allows you to specify the operation by an **integer** if you already know which operation you would like.
    - If left blank, the script will ask you to choose from a series of operations you would like to pick from, listed below.
      1. Addition
      2. Subtraction
      3. Multiplication
      4. Division
      5. Power
      6. Square Root
      7. Integer Division
      8. Modulus
      9. Quadratic Solver
      10. Cubic Solver
      11. Fraction Addition
      12. Fraction Subtraction
      13. Fraction Multiplication
      14. Fraction Division
      15. Fraction Simplification
  - `scale`: This allows you to specify the how many decimal points you would like from 0-6. The default is 2.

- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh calc <operation> <scale>
```

- External Resources:
  - Inspiration for the idea: <https://stackoverflow.com/questions/14350556/creating-a-calculator-script>

## FIXME LOG

- Description: The purpose of this feature is to search the CS1XA3 directory for all files with the word `#FIXME` in the last line. Those files will then be written to `CS1XA3/Project01/fixme.log`. Any files in the `.git` folder will be ignored.
- Arguments:
  - **`fixme_log`**: The required feature name for calling the feature.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh fixme_log
```

- External Resources:
  - Inspiration for the parent_path variable: <https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory>

## FIND TAG

- Description: When called, this feature will prompt the user for a word. Once given the word, it will search all Python files (ending in .py) within the CS1XA3 directory. It will take all lines that contain the tag word and put them in `./CS1XA3/Project01/Tag.log`.
- Arguments:
  - **`find_tag`**: The required feature name for calling the feature.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh find_tag
```
