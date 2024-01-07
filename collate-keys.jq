# This script take a JSON and walks through it to find all key value pairs where the value is a scalar or null. 
# It then makes a dictionary of all the unique values in the JSON for each of those keys.

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

# Make another array for the output, then...
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

