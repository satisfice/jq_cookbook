# This script traverses a any JSON and finds all value of a particular key you supply on the command line
#

[
	paths as $path 
	| 
	
	select($path[-1]==$myvar) 
	| 
	
	getpath($path)] 
	| 
	
	unique 
	| 
	
	.[]