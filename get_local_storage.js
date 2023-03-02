javascript: 
(
	()=>
	{
		function download(text, name, type) 
		{  
			var a = document.createElement("a"); 
			var file = new Blob([text], {type: type});  
			a.href = URL.createObjectURL(file);  
			a.download = name;  
			a.click()
		}
		const result = {};
		for (var i = 0; i < localStorage.length; i++)
		{
			result[localStorage.key(i)] = localStorage.getItem(localStorage.key(i));
		}
		download(JSON.stringify(result,null,2),"LocalStorage","application/json")
	}
)();