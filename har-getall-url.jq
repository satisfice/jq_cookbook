# For HAR files only.
# This script retrieves all HTTP requests/responses that have a URL that begins with the supplied string
# and then saves that in a format compatible with further processing from JJQ HAR scripts.

# Take the variable from the command line and treat it as a URL.
{log:{entries:[
.log.entries[]
|
	select(

		.request.url 
		| 
	
			startswith($myvar)
)
]}}