var geocoder = new google.maps.Geocoder();

function parseAddress(src_node, dest_node) {
	var address = document.getElementById(src_node).value;
	geocoder.geocode( { 'address': address}, function(results, status) {
	  if (status == google.maps.GeocoderStatus.OK) {
		//alert(results[0].geometry.location);
		document.getElementById(dest_node).value = results[0].geometry.location;
	  } else {
	    alert("Geocode was not successful for the following reason: " + status);
	  }
	});
}