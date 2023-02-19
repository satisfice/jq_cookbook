# jq_cookbook
Here are my favorite JQ scripts for analysis and web-based testing.

To learn about jq go [here](https://stedolan.github.io/jq/manual/).

## Installation

Make sure you have installed JQ and that it is on the PATH.

For Windows, clone the repo and set the PATH environment variable to point to it. 

That way you can run the JJQ batch file from the command-line, wherever you happen to be.

I've also included bookmarklets (the JS files) that I use to create JSONs from web pages that I'm testing. To install each them, create a new bookmark, then copy the contents of the js file into the body of the bookmark. If you click on them after visiting a page, they will download files that can are full of data about that page. You can use JQ to sift through it.

## Usage

```jjq <jq file> <optional parameter> <json file>```

*jQ file:* A file with the extension JQ from this repo.

*Optional Parameter:* Some of the JQ files, here take a parameter.

*JSON file:* Any JSON file you want to process.

You can also get a list of the available jq files by doing:

```jjq --help```

Each file is commented.

Contact me with any questions.
