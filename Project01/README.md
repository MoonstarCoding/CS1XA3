# CS 1XA3 Project01 - hutchm6

## Usage

Execute the script from root using the following command:

```bash
chmod +x CS1XA3/Project01/project_analyze.sh
./CS1XA3/Project01/project_analyze.sh feature arg1 ...
```

With the following possible arguments:

> Note: Bolded Arguments are required, while italics are optional.

- **feature** - Feature Argument: This argument will let you specify the feature you desire out of the features below. Refer to feature documentation for more information.
- _arg1_: Depending on the feature, additionally arguments may be called for. Refer to feature documentation for more information.

## FIXME LOG

- Description: The purpose of this feature is to search the CS1XA3 directory for all files with the word `#FIXME` in the last line. Those files will then be written to `CS1XA3/Project01/fixme.log`.
- Arguments: The only argument to this function is the feature name: `fixme_log`
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh fixme_log
```

- External Resources:
  - Inspiration for the parent_path variable: <https://stackoverflow.com/questions/24112727/relative-paths-based-on-file-location-instead-of-current-working-directory>

## CHECKOUT LATEST MERGE

- Description: The purpose of this feature is to find the last git commit that contains the word `merge` in its commit message. After that commit is found, the commit will be checked out and put the user in a detached head state.
- Arguments: The only argument to this function is the feature name: `checkout_merge`
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh checkout_merge
```

- External Resources:
  - Parsing first word from string line: <https://stackoverflow.com/questions/2440414/how-to-retrieve-the-first-word-of-the-output-of-a-command-in-bash>
  - Checking if variable is set: <https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash>

## FILE SIZE LIST

- Description: List the file size and filename of every file with in a directory and sub directories in human readable format.
- Arguments:
  - `ls_size`: The required feature name for calling
  - `directory`: This argument will allow you to specify what directory the feature starts at. The default value is the `Git Root` directory.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh ls_size <directory>
```

- External Resources:
  - Human Readable Format via `printf`: <https://stackoverflow.com/questions/64649/how-do-i-get-the-find-command-to-print-out-the-file-size-with-the-file-name>

## FILE TYPE COUNT

- Description: Count how many files in a directory end in a user specified extension. If no extension is given, it will count how many files there are.
- Arguments:
  - `count_type`: The required feature name for calling
  - `directory`: This argument will allow you to specify what directory the feature starts at. The default value is the `Git Root` directory.
  - `extension`: Once the script is run, you will be prompted to input a file extension. Failure to do so will result in a count of all files in a directory.
- Execution:

This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh count_type <directory>
```
