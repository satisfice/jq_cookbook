# For HAR files only.
# This script traverses a HAR file and finds each response that can be interpreted as a JSON.
# It outputs the URL of each request, with an index number
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

# create an array
[

# try to parse it as a json
	(.response.content.text 
		| 
		try(
			fromjson 
			|
			
# if that worked, output the index and URL of the lucky entry			
			$index,
			$original.log.entries[$index].request.url
			)
	)
]
|

# delete any entries that are empty (because they failed the try)
select ( length > 0 )
|

# output as a TSV
@tsv
