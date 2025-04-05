# This script looks for a particular key anywhere in the JSON and prints its path.
# You have to pass in the key to look for from the command line.
# EXAMPLE: jjq find-key "tag" input_file.json

# Turn the JSON into a list of arrays, each one representing a path
paths 
| 

# if the last entry in the path array matches the key we are looking for, print that. 
select(
	.[-1]==$myvar
	)
|

# make it look nice first by converting to CSV
@csv
|

# commas to colons...
gsub(","; ":")
|

# remove quotes
gsub("\"";"")