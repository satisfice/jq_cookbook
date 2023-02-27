# This script traverses a HAR file and finds each URL and referrer pair.
# It outputs a list of all unique pairs

.log.entries[] 
| 

# create an array
[

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

unique
| 

# dump it as tab-separated table
@tsv
