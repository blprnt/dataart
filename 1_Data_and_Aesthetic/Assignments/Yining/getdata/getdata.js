/* To run - 
1. cd into the folder and `python -m SimpleHTTPServer`
2. for testing on localhost:8000 quit chrome and restart it from the terminal 
   with web-security disabled - `open -a Google\ Chrome --args --disable-web-security`
3. goto http://localhost:8000 and open console
4. save console to a file. link below.
*/


var api_key = 'abcdef';
var r = 20, 
i=j=0;

var best_seller_lists = "http://api.nytimes.com/svc/books/v3/lists/names.json?api-key=" + api_key;

var books_in_a_list = "http://api.nytimes.com/svc/books/v3/lists/"; //+ ".json?&api-key=" + api_key;

var allBooks = [];

window.onload = function(){
	//get all the lists
	$.get(best_seller_lists, function(data){
		var timeout = 0;
		var total = 0;
		var lists = data.results;

		//get all the books in each list and save in allBooks[]
		for(var k = 0; k < lists.length; k++){
			
			var item = lists[k];

			//set timeout to not scare NYTimes API
			setTimeout(function(){
				$.get(books_in_a_list + lists[total].list_name_encoded + ".json?&api-key=" + api_key, function(books){
					allBooks.push(books);

					//check if all lists are finished.
					if(total === lists.length-1) {
						createJSON();
					}
					total++;

					console.log("getting data " + total + "...");

				});
			}, timeout);

			timeout+=1000;
		}
	});

}

function createJSON() {
	var allImages = [];
	console.log(allBooks);
	for(var i = 0; i < allBooks.length; i++){
		for(var j = 0; j < allBooks[i].results.books.length; j++){
			var IMG = {
				title: allBooks[i].results.books[j].title,
				author: allBooks[i].results.books[j].author,
				image: allBooks[i].results.books[j].book_image,
				list: allBooks[i].results.display_name
			};
			allImages.push(IMG);
		}
	}
	//log the JSON of allImages to console and then save console to console.json using
	//http://stackoverflow.com/questions/11849562/how-to-save-the-output-of-a-console-logobject-to-a-file
	console.log(allImages);
}





