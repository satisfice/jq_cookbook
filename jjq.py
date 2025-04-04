#  TODO:
#  - mjq --walkthrough
#      for each filter in a .jq file, the preceding comment(s), displays the filter string,
#      and then runs that filter (including all prior filters)

# assumes that all query files will have the .jq extension
# assumes that documentation will end by the 75th column

import sys
import os
import re
import subprocess
from colorama import init as colorama_init
from colorama import Fore
from colorama import Style

colorama_init()

def get_jqfiles():
    jjq_files = []
    for filename in os.listdir():
        # no need to display the extension in the list of available commands
        if filename.endswith(".jq"):
            jjq_files.append(filename.replace(".jq", ""))
    return jjq_files

def display_help(jq_file):
    # if the user hasn't supplied ".jq", stick it on
    if jq_file.endswith(".jq"):
        f = open(jq_file, "r")
    else:
        f = open(jq_file + '.jq.', "r")

    # No need to have the .jq on the command name.
    jjq_command = jq_file.replace('.\\', '').replace(".jq", "")
    print (f"\n{Fore.LIGHTBLUE_EX}{jjq_command}{Style.RESET_ALL}\n")

    help_text = f.readline().strip("\n")
    while re.match("^#", help_text):
        # indent the help text
        print("  ", help_text.replace("#", ""))
        help_text = f.readline().strip("\n")

def process_command():
    if len(sys.argv) == 4:
        command = f"jq -r -f {sys.argv[1] + '.jq'} --arg myvar {sys.argv[2]} {sys.argv[3]}"
    else:
        command = f"jq -r -f {sys.argv[1] + '.jq'} {sys.argv[2]}"
    print(command)

    subprocess.run(command, shell=True)

# If there are no parameters at all, print the general help
if len(sys.argv) == 1:
    print("mjq - a caller for files that contain complex jq queries")
    print("Usage: ")
    print("     mjq.py")
    print("         displays this message\n")
    print("     mjq.py --list  (or --help, with no other parameters)")
    print("         displays a list of available jq query files\n")
    print("     mjq.py --help [jq_file]")
    print("         provides help for the specified .jq file\n")
    print("     mjq.py --walkthrough [jq_file]")
    print("         provides help for the specified .jq file\n")
    print("     mjq.py [jq_file] [parameters]")
    print("         runs the specified jq files, passing the required parameters")
    print("         example: mjq.py har-scan-get-json . my_harfile.har")
    print("         example: mjq.py har-get-req 3 my_harfile.har")
    print("         example: mjq.py collate-keys my_jsonfile.json")

# One argument  --help or --list produces a list of .jq scripts
if len(sys.argv) == 2:
    jjq_files = get_jqfiles()
    if sys.argv[1] == "--list" or sys.argv[1] == "--help":
        print("Available jjq commands:")
        for file in jjq_files:
            print(f"\t{file}")

    elif sys.argv[1] == "--listall" or sys.argv[1] == "--helpall":
        for jq_file in jjq_files:
            display_help(jq_file)

if len(sys.argv) >= 3:
    if sys.argv[1] == "--list" or sys.argv[1] == "--help":
        display_help(sys.argv[2])

    elif sys.argv[1] == "--walkthrough":
        #TBD
        pass
    else:
        process_command()

exit()
4:56 PM

