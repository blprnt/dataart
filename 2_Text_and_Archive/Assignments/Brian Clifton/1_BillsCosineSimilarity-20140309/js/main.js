$(document).ready(function(){

	d3.text('assets/cosine.csv', function(text) {
		var data = d3.csv.parseRows(text).map(function(row) {
			return row.map(function(value) {
				return +value;
			});
		});



		var visibleRows = 30;



		tempData = [];
		for (var i = 0; i < visibleRows; i++) {
			tempData.push(data[i]);
		}
		// console.log(tempData);

		var width = $(window).width();
		var height = $(window).height();
		var arrayLength = tempData[0].length;
		var cellWidth = width / arrayLength;
		var cellHeight = 10;
		var rowHeight = cellHeight;

		var colorScale = d3.scale.linear()
			.domain([0, 1])
			.range([255, 0]);

	    var grid = d3.select('body')
	    	.append("svg")
	        .attr("width", width)
	        .attr("height", height)
	        .attr("class", "chart");

	    var row = grid.selectAll(".row")
	        .data(tempData)
	        .enter()
	        .append("g")
	        .attr("class", function(d) {
	        	return "row";
	        });

	    var temp_i;
	    var col = row.selectAll(".cell")
	        .data(function(d) {return d; })
	        .enter()
	        .append("rect")
	        .attr("class", "cell")
	        .attr("x", function(d, i) { 
	        	return cellWidth * i; 
	        })
	        .attr("y", function(d, i) { 
	        	if (i === 0) {
	        		rowHeight = rowHeight + cellHeight;
	        	} else {
	        		return rowHeight; 
	        	}
	        })
	        .attr("width", function(d) { return cellWidth; })
	        .attr("height", function(d) { return cellHeight; })
	        .style('fill', function(d) {
	        	if (d === 0.0) {
	        		return 'rgb(0, 0, 0)';
	        	} else if (d > 0.9) {
	        		return 'rgb(0, 0, 0)';
	        	} else {
	        		var c = Math.floor(colorScale(d));
	        		return 'rgb(' + c + ', 0, 0)';	
	        	}                	
	        });
	});
});
