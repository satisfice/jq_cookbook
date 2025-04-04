# jq_cookbook
Here are my favorite JQ scripts for analysis and web-based testing.

To learn about jq go [here](https://stedolan.github.io/jq/manual/).

## Installation

Make sure you have installed JQ and that it is on the PATH.

For Windows, clone the repo and set the PATH environment variable to point to it. 

JJQ is a Python program to conveniently serve these scripts and get help. I've included an EXE version. That way you can run the JJQ exe from the command-line, wherever you happen to be.

## Usage

```
usage: JJQ [-h] [--list [SCRIPT] | --listall] [script] [input] [json_file]

A wrapper around JQ to serve complex scripts.

positional arguments:
  script           Script file to execute
  input            Optional parameter for script
  json_file        JSON file as target

options:
  -h, --help       show this help message and exit
  --list [SCRIPT]  List all available scripts, or get help on specific script
  --listall        List all available scripts with capsule descriptions

Written by James Bach and Michael Bolton
```

Each file is commented.

Contact me with any questions.
