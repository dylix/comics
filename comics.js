jQuery(document).ready(function($) {
                myComics = $.getJSON("comics.json", function(json){
                        $.each(json.comics, function(key, val) {
				$('#menu').append('<option class="option" value=' + val.id + '>' + val.title + '</option>');
                        }); // each()

			$('#menu').change(function() {
				$('#comicstrip').html('');
				$('#menu :selected').each(function(i, selected) {
					var id = $(selected).val()-1;
					var cmx = json.comics[id];
					// since custom json is created, not all entries have width/height // $('<h4><a href="' + cmx.url + '">' + cmx.title + '</a> by ' + cmx.author + '</h4><img height="' + cmx.height +'" width="' + cmx.width + '" src="' + cmx.image + '"/>').appendTo('#comicstrip');
					$('<h4><a href="' + cmx.url + '">' + cmx.title + '</a> by ' + cmx.author + '</h4><img src="' + cmx.image + '"/>').appendTo('#comicstrip');
				}); // .selected()
	                }); // .change()

			$('#rememberme').click(function() {
				expirationDate = new Date(2038, 0, 1, 0, 0, 0);
				$.cookie("comics",$('#menu').val(), { expires: expirationDate });
			}); // .click()

			$('#clear').click(function() {
				$.cookie("comics","", { expires: -5 });
				location.reload();
			}); // .click()

			if ($.cookie("comics") != null) {
				var arr = $.cookie("comics").split(',');
				$('#comicstrip').html('');
				$.each(arr, function(val) {
					var cmx = json.comics[arr[val]-1];
					$('<h4><a href="' + cmx.url + '">' + cmx.title + '</a> by ' + cmx.author + '</h4><img height="' + cmx.height +'" width="' + cmx.width + '" src="' + cmx.image + '"/>').appendTo('#comicstrip');
				}); // .each()
			};
		}); // .getJSON()

}); // ready()
