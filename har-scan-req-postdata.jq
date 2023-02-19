# For HAR files only.
# This script traverses a HAR file and tries to interpret the content of each POST request as a json.
# It outputs the URL of each request, with an index number and pretty-printed version of the json.
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

# check if the content type include "json" or "text"
# (the reason we check for text type is that in some webapps jsons are mislabeled as text type)

select(
	.request.postData.text != null and .request.postData.text != ""
	) 
| 

# now we are ready for output...

# this outputs the entry index 
(["Entry", $index]| join(": ")),

# url
.request.url,

# print the content
.request.postData.text,

# separator
"\n============================================="