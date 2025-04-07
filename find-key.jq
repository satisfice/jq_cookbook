# This script looks for a particular key anywhere in the JSON and prints its path.
# You have to pass in the key to look for from the command line.
# EXAMPLE: jjq find-key "tag" input_file.json

# Turn the JSON into a list of arrays, each one representing a path
. as $original
|

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

# prepend some commas to make the rest of this work...
"," + .
| 

# put brackets around numbers to indicate array indices
gsub("(?<=[\b,])(?<x>[0-9]+)(?=[\b,])";"[\(.x)]")
|

# If there are any keys that are pure numbers, put them in single quotes
gsub("\"(?<x>[0-9]+)\"";"'\(.x)'")
|

# commas to colons...
gsub(","; ".")
|

# remove quotes
gsub("\"";"")
|

# bring back the double quotes for keys that are numbers
gsub("'(?<x>[0-9]+)'";"\"\(.x)\"")
