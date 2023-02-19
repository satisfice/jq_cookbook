# For HAR files only.
# This script retrieves a specific HTTP POST request based on an index passed in from the command line.
# It outputs a pretty-printed version of the json, if it is one. Otherwise, just prints it plain.
#

# Take the variable from the command line and treat it as a number.
# Then use it as the index to the array of entries in the HAR file.
.log.entries[$myvar | tonumber] 
| 

# get the content
.request.postData.text 
| 
 
# try to interpret the text content as a json
# I use a try/catch here because often post requests are not jsons
try(fromjson) catch (.)
