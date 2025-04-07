import sys
import os
import re
import io
import subprocess
from colorama import init as colorama_init # type: ignore
from colorama import Fore # type: ignore
from colorama import Style # type: ignore
import argparse
from stat import S_ISFIFO
import errno

def get_executable_path():
    if getattr(sys, 'frozen', False):
        return os.path.dirname(sys.executable)  # Returns path to the .exe
    else:
        return os.path.dirname(os.path.abspath(__file__))

def get_jqfiles():
    jjq_files = []
    for filename in os.listdir(scriptdir):
        if filename.endswith(".jq"):
            jjq_files.append(filename)
    return jjq_files

def fix_name(script):
    # if the user hasn't supplied ".jq", stick it on
    if script.endswith(".jq"):
        return script
    else:
        return script + ".jq"

def display_help(script):

    print (f"\n{Fore.LIGHTBLUE_EX}{script.replace('.\\', '').replace(".jq", "")}{Style.RESET_ALL}\n")
    
    f = open(scriptdir + "/" + script, "r")

    help_text = f.readline().strip("\n")
    while re.match("^#", help_text):
        # indent the help text
        print("  ", help_text.replace("#", ""))
        help_text = f.readline().strip("\n")

def process_command(script,target,input):
    if input:
        command = ["jq","-r","-f",script,"--arg","myvar",input,"-"]
    else:
        command = ["jq","-r","-f",script,"-"]

    data = target.read()
    target.close()
    subprocess.run(command, input=data, encoding="utf-8", shell=True)

def parse_arguments():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(
        prog='JJQ',
        description='A wrapper around JQ to serve complex scripts.',
        epilog='Written by James Bach and Michael Bolton',
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    # Create a mutually exclusive group for --list and --listall
    list_group = parser.add_mutually_exclusive_group()
    list_group.add_argument(
        "--list",
        nargs="?",
        const=True,  # Default value when --list is specified without an argument
        metavar="SCRIPT",
        help="List all available scripts, or get help on specific script"
    )
    list_group.add_argument(
        "--listall",
        action="store_true",
        help="List all available scripts with capsule descriptions"
    )
    
    # Add positional arguments that are only required if neither --list nor --listall is specified
    parser.add_argument(
        "script",
        nargs="?",  # Make it optional initially
        help="Script file to execute"
    )
    parser.add_argument(
        "input",
        nargs="?",  # Make it optional initially
        help="Optional parameter for script"
    )
    parser.add_argument(
        "json_file",
        nargs="?",  # Make it optional initially
        help="JSON file as target"
    )
    
    args = parser.parse_args()
    
    # Validate arguments
    if not args.list and not args.listall:
        # In normal mode, script and json_file are required
        if args.script is None:
            parser.error("Please specify a JQ script.")
        if S_ISFIFO(os.fstat(0).st_mode):
            args.json_file = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
        else:                
            if args.input is None:
                parser.error("Please specify a target JSON file.")
            else:
                if args.json_file is None:
                    args.json_file = open(args.input,"r",encoding="utf8")
                    args.input = None
                else:
                    args.json_file = open(args.json_file,"r",encoding="utf8")

    return args

colorama_init()
scriptdir = get_executable_path()
args = parse_arguments()


if args.list is not None or args.listall is not None:
    jjq_files = get_jqfiles()

if args.list is not None:
    if args.list is True:  # --list specified without an argument
        print("Available jjq commands:")
        for file in jjq_files:
            print(f"\t{file.replace(".jq","")}")
    else:  # --list specified with an argument
        display_help(fix_name(args.list))

elif args.listall:
    print("Listing all items with detailed information")
    for jq_file in jjq_files:
        display_help(jq_file)
else:
    process_command(fix_name(scriptdir + "/" + args.script),args.json_file,args.input)



