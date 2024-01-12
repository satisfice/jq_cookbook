# This script traverses a HAR file and gets all the URLs visited.
# It outputs the URL of each request, with a timestamp and index number.
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

# for each entry, save the index number for later...
.[] as $index 
| 

# ...then go back to the original input and pick out the entry for that index number
$original.log.entries[$index] 
| 

# now we are ready for output...
# this outputs the entry index, time, and url 
[
	$index,
	.startedDateTime,
	.request.url
] 
| 

# output to a CSV so we can import it to Excel or something
@csv
