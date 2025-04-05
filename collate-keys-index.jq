# This script is like collate-keys, but creates an index of all the keys and displays a table of them.
# To obtain the values, use the collate-keys-get script.

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

# Prepare to create a nice output table
. as $original
|

# For each key get the length of the list of unique items in that category.
keys
|

length as $len 
| 

# Now, from the top...
$original 
| 

# ...iterate through the list of keys with an index number.
range($len) as $index 
| 

keys[$index] as $key 
| 

.[$key] 
| 

# Emit table row
[$index, $key, length] 
| 

@csv
