# For HAR files only.
# This script retrieves a specific HTTP response based on an index passed in from the command line.
#

# Take the variable from the command line and treat it as a number.
# Then use it as the index to the array of entries in the HAR file.
.log.entries[$myvar | tonumber] 
| 

# get the content
.response

