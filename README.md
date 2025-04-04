# jq_cookbook
Here are my favorite JQ scripts for analysis and web-based testing.

To learn about jq go [here](https://stedolan.github.io/jq/manual/).

## Installation

Make sure you have installed JQ and that it is on the PATH.

For Windows, clone the repo and set the PATH environment variable to point to it. 

JJQ is a Python program to conveniently serve these scripts and get help. I've included an EXE version. That way you can run the JJQ exe from the command-line, wherever you happen to be.

## Usage

```jjq <jq file> <optional parameter> <json file>```

*jQ file:* A file with the extension JQ from this repo.

*Optional Parameter:* Some of the JQ files, here, require a parameter.

*JSON file:* Any JSON file you want to process.

You can also get a list of the available jq files by doing:

```jjq --help```

Each file is commented.

Contact me with any questions.
