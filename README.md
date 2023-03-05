# Welcome to Shell Scripting 101 (under development)

## Index

1. [What is a command-line interpreter](#what-is-a-command-line-interpreter)
2. [Scripts](#scripts)
    1. [Shell scripts structure](#shell-script-structure)
    2. [Shebang](#shebang)
        1. [Examples](#examples)
3. [Executable files](#executable-files)
    1. [*nix permissions](#nix-permissions)
        1. [Letter permissions representation](#letter-permissions-representation)
        2. [Octal permissions representation](#octal-permissions-representation)
    2. [Setting permissions](#setting-permissions)
4. [Variables](#variables)
    1. [Variable types](#variable-types)



## What is a command-line interpreter

It's just like it sounds: an interpreter of commands 🙃. It's responsible of handling and process text commands to interact with a program, in our case with the Operating System.

Basically, all command line interpreters works the same way, it receives text through a command-line interface using a command prompt, then it translates it into a function, so the OS can understand. Finally, the OS returns an output.

We are going to talk about an specific group of command-line interpreters, most common known as Shells.

## Scripts

It's a file containing a series of commands that the interpreter will execute. All commands that you send to your shell can be included into your script.

Scripts are commonly used to automate tasks, such an administrative tasks to update multiple servers, installing complex systems, or as simple as copy a file from one place to another.

Commonly, the script file extension is `.sh` but it can be any extension or even without it, it just needs to have executable <sup>[1](#letter-modes-representation)</sup> <sup>[2](#setting-permissions)</sup>. It can also have [shebang](#shebang) directive to set the default interpreter.

### Shell script structure

```bash
#!interpreter [optional-args]
# Shebang 👆  <- This is a comment
# This is a comment

# Commands 👇   <- This is also a comment
echo "Hello, World!"

# functions
sayHello() {
    return "Hello, $1!"
}
echo $(sayHello "World")
```

#### Shebang

It's an interpreter directive where we can set the command-line interpreter to use (e.g. sh, bash, zsh).

It's name comes from the first two characters `#!` sharp and exclamation, in English Slang known as **bang**, sharp-bang became sha-bang to finally finishing as shebang, as a result of a wrong contraction.

Another option to explain the name it's that at the begining the default shell was Bourne shell or sh.

##### Examples

`#!/bin/bash`

`#!/bin/zsh`

`#!/usr/bin/env bash`

`#!/usr/bin/env nix-shell`

## Executable files

Before reviewing how to set execute flag permissions to a file, we need to barely explain how *nix permissions works.

### *nix permissions

When you list files with `ls -la` in a *nix based systems, the permissions are displayed like follows:

```
Permissions L  User      Group  Size Date Modified Name
drwxr-xr-x  10 abralami  staff   320 Feb 28 15:39  .git/
-rw-r--r--   1 abralami  staff  2314 Feb 28 15:48  README.md
```

| Position       | Meaning           |
| -------------- | ------------------|
| 1    - d       | resource type.    |
| 2-4  - rwx     | owner permissions |
| 5-7  - r-x     | group permissions |
| 8-10 - r-x     | other permissions |

#### File class types

We have the following classes to denote each permission segements:

| Letter | Class | Description                                                            |
|--------|-------|------------------------------------------------------------------------|
| u      | user  | Owner of the file                                                      |
| g      | group | Users who are members of the file's group                              |
| o      | other | Users who are not the owner of the file or members of the file's group |
| a      | all   | All of the above (equivalent to "ugo")                                 |

#### Operators

We have some operators to modify the modes of any resource under the file system:

| Operator | Description                                                             |
|----------|-------------------------------------------------------------------------|
| +        | Add the specified modes to the specified classes.                       |
| -        | Remove the specified modes from the specified classes.                  |
| =        | The specified modes are made the exact modes for the specified classes. |

#### Letter modes representation

Modes can be represented by letters

| Value | Meaning |
|-------|---------|
| -     | Flag is not set. |
| r     | File is readable.|
| w     | File is writable. For directories, files may be created or removed.|
| x     | File is executable. For directories, files may be listed. |
| s     | Set group ID (sgid). For directories, files created therein will be associated with the same group as the directory, rather than default group of the user. Subdirectories created therein will not only have the same group, but will also inherit the sgid setting. |

#### Octal modes representation

We can also set mode with an octal value. The octal values have the following meaning:

| Octal Digit | Binary Representation (rwx) | Permission |
|-------------|-----------------------------|------------|
| 0           | 000                         | none |
| 1           | 001                         | execute only  |
| 2           | 010                         | write only  |
| 3           | 011                         | write and execute |
| 4           | 100                         | read only |
| 5           | 101                         | read and execute |
| 6           | 110                         | read and write  |
| 7           | 111                         | read, write, and execute (full permissions) |

### Setting permissions

To set mode flags we will use `chmod` (change mode) command, which receives the class, operator and flags as letters or only octal modes.

```shell
# set write flag to the group
chmod g+w script.sh

# set read flag to the world
chmod o-r script.sh

# set full control to the owner, read and execute flags to the group
chmod 750 script.sh
```

## First script

Let's write our first script, as always we'll start with `Hello, Wordl!`

[first.sh](src/first.sh)
```bash
#!/bin/bash

echo "Hello, World!"
```

### Tasks

1. Run the script `./src/first.sh`
2. Review output error message
3. Review file permissions `ls -la src`
4. Change permissions `chmod u+x src/first.sh`
5. Run again
6. Eureka! 🙌🏽

## Variables

As in every programming language we need to store temporary values, in shell script we also have variables, by convention they might be in uppercase and names are case sensitive.

```bash
#!/bin/bash
MY_VARIABLE="Value"
#         👆🏽👆🏽
# Spaces should be avoided before and after equal sign

echo "My variable value is: $MY_VARIABLE"   # This works
echo "My variable value is: $my_variable"   # This not works
```

### Variable types

Every value is stored as string, but it will be threated with specific type based on the operation.

```bash
#!/bin/bash
MY_NAME="Abraham"
MY_AGE=35
MY_NAME_INC=$((MY_NAME + 1))
MY_AGE_INC=$((MY_AGE + 1))
MY_AGE_INC_2=$((++MY_AGE))

echo "Hello, my name is $MY_NAME"
echo "Hello, my name is $MY_NAME_INC"
echo "This year I will be $MY_AGE"
echo "This year I will be $MY_AGE_INC"
echo "This year I will be $MY_AGE_INC_2"
```
