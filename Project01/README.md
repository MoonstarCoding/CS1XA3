# CS 1XA3 Project01 - hutchm6

## Usage

Execute the script from root using the following command:

```bash
chmod +x CS1XA3/Project01/project_analyze.sh feature arg1 ...
```

With the following possible arguments:

> Note: Bolded Arguments are required, while italics are optional.

- **feature** - Feature Argument: This argument will let you specify the feature you desire out of the features below. Refer to feature documentation for more information.
- _arg1_: Depending on the feature, additionally arguments may be called for. Refer to feature documentation for more information.

## FIXME LOG

- Description: The purpose of this feature is to search the CS1XA3 directory for all files with the word `#FIXME` in the last line. Those files will then be written to `CS1XA3/Project01/fixme.log`.
- Arguments: The only argument to this function is the feature name: `fixme_log`
- Execution: This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh fixme_log
```

## CHECKOUT MERGE

- Description: The purpose of this feature is to find the last git commit that contains the word `merge` in its commit message. After that commit is found, the commit will be checked out and put the user in a detached head state.
- Arguments: The only argument to this function is the feature name: `checkout_merge`
- Execution: This feature is to be called as so:

```bash
CS1XA3/Project01/project_analyze.sh checkout_merge
```

