# For HAR files only.
# This script traverses a HAR file and scans it for a list of unique domains (distinct from unique urls)
# that were called. Each domain is followed by a list of numbers indicating the HAR file entry, 
# which can be retrieved using the har-get-res script.

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

# iterate through each of the unique domains
.[] as $key 
| 

# enclose in an array so that we can get the TSV, later
[ 

	# print the domain as the first column
	$key, 
	
	# collect all the entry numbers into a text list
	(
	
		# enclose in an array...
		[ 
			# now start from the top...
			$original[]
			| 
			
			# ...and search for any entry with the current domain...
			select(.[1] == $key) 
			| 
			
			# ...and grab that for our list.
			.[0]
		] 	
		| 
		
		# turn the collected list into a comma-separated list
		@csv
	)
] 
| 

# turn the final array into a tab-separated list
@tsv
