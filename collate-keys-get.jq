# This script allows you to dump the values for a specific key listed in 
# the output from collate-keys-index.jq. Specify the index number of the
# key that you want. EXAMPLE "jjq collate-keys-get 5 inputfile.json"

# This function gets an element if it is a leaf node
def grab(d): 
	d 
	|
	
	to_entries? 
	| 
	
	.[] 
	| 
	
	select(
		.value 
		| 
		
		type != "array" and type != "object"
	); 

# Make an array
[

# Crawl through the JSON
	recurse 
	| 

# Find all the leaf nodes	
	grab(.) 
	| 

# Ignore scalars that are in arrays (we are only focusing on key value pairs in the JSON)	
	select(.key | type == "string")
] 
| 

# Now take the array and collate it by key
group_by(.key)
| 
[
# for each different key...
	.[] 
	|

# make an object...	
	{
# that has the key name as the key...
		(.[0].key): 
			(
# and all the unique values in an array attached to that key.
				[
					.[] 
					| 
					
					.value
				] 
				| 
				
				unique
			)
	}
]
|

# Put it all into one JSON
add
|

# Target the category the user wants
keys[$myvar | tonumber] as $key
|

{($key):(.[$key])}