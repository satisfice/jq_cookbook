# This script traverses a HAR file and finds each URL and referrer pair.
# It outputs a TSV with index numbers and timestamps

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
	# output the index number and timestamp
	$index,
	.startedDateTime,
	
	# output URL
	.request.url,

	# output referrer if possible
	(
		# go through headers
		.request.headers[] 
		| 
		
		# if the header name is "referer" (case insensitive)...
		select( 
				.name 
				| 
				test("referer";"i")
			) 
			| 
			
			# ...then output the referer
			.value 
	) 
	
	# otherwise, just say N/A if there is no referrer
	// 
	"N/A"

]
| 

# dump it as tab-separated table
@tsv
