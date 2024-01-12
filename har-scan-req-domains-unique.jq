# This script traverses a HAR file and scans it for a list of unique domains (distinct from unique urls) that were called. Each domain is followed by a list of numbers indicating the HAR file entry.

# save the original HAR file to a variable; we'll need that later.
. as $original 
|

# get the original entries
.log.entries
|

# get all the index numbers for the entries
keys
|

#create an array 
[

	# for each entry, save the index number for later
	.[] as $index
	|

		#by going through the log and getting each entry
		$original.log.entries[$index]
		
		#and pulling the URL from each one
		.request.url
		
		#now we've got a list of URLs
		| 
		
		# hack off everything after the domain
		capture("(?<domain>^http[s]?://.*?)[/?]") 
		|
		
		#now we have a JSON object from which we can pull the domain
		[$index, .domain]
	
] 
|

# save where we are
. as $original 
| 

# make an array out of all the domains
[
	.[].[1]
] 
| 

# get rid of the duplicates
unique 
|

# unpack the array so that it is a clean list
.[]