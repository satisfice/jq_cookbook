# This script traverses a HAR file and finds each response that contains json or text mime type.
# It outputs the URL of each request, with an index number and pretty-printed version of the 
# content interpreted as a json.
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
	.response 
	| select(.headers[] 
		| select(.name | test("content-type";"i")) 
		| select(
				(.value | contains("json"))
				or
				(.value | contains("text"))
			)
		)
	) 
| 

# now we are ready for output...

# this outputs the entry index 
(["Entry", $index]| join(": ")),

# url
.request.url,

# this tries to interpret the text content as a json
(.response.content.text | try(fromjson) catch ("<not JSON>")),

# separator
"\n============================================="