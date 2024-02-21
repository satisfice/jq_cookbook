# For HAR files only.
# This script retrieves all HTTP requests that have a URL that begins with the supplied string
# then it puts all the content that can be interpreted as JSON into one big JSON
#

# Take the variable from the command line and treat it as a URL.
[
.log.entries[] 
| 

select(

	.request.url 
	| 
	
	startswith($myvar)
)

|

.response.content.text
|

fromjson?

]