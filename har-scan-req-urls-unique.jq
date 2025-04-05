# For HAR files only.
# This script traverses a HAR file and gets all the URLs visited.
# It outputs a list of each unique URL.
#

# Save the original input, because we will need it, below...
. as $original
| 

# get all the entries
.log.entries 
| 

# get all the index numbers for the entries
keys 
| 

[
# for each entry, save the index number for later...
.[] as $index 
| 

# ...then go back to the original input and pick out the entry for that index number

$original.log.entries[$index] 
| 

# now we are ready for output...
# we put this into a list so that we can run the next filter on it... 

	.request.url
] 
| 

# list each URL only once
unique
|

# print as a bare list
.[]
