# For HAR files only.
# This script retrieves all HTTP requests that have a URL that begins with the supplied string
#

# Take the variable from the command line and treat it as a URL.
[
.log.entries[].request 
| 

select(

	.url 
	| 
	
	startswith($myvar)
)
]