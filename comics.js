jQuery(document).ready(function($) {
                //document.title = "plutonicXreddit: /r/" + subReddit;
                //$("#loading").html('<img src="/reddit/spinner.gif" alt="Wait" />');
                myComics = $.getJSON("comics.json", function(json){
                        //$("#loading").html('');
                        $.each(json.comics, function(key, val) {
				$('#menu').append('<option class="option" value=' + val.id + '>' + val.title + '</option>');
                        }); // each()

			$('#menu').change(function() {
				$('#comicstrip').html('');
				$('#menu :selected').each(function(i, selected) {
					//var id = $('#menu').val()-1;
					var id = $(selected).val()-1;
					var cmx = json.comics[id];
					//$('#comicstrip').html('<h4><a href="' + cmx.url + '">' + cmx.title + '</a> by ' + cmx.author + '</h4><img height="' + cmx.height +'" width="' + cmx.width + '" src="' + cmx.image + '"/>');
					$('<h4><a href="' + cmx.url + '">' + cmx.title + '</a> by ' + cmx.author + '</h4><img height="' + cmx.height +'" width="' + cmx.width + '" src="' + cmx.image + '"/>').appendTo('#comicstrip');
				}); // .selected()
	                }); // .change()

			$('#rememberme').click(function() {
				//alert($('#menu').val());
				expirationDate = new Date(2038, 0, 1, 0, 0, 0);
				$.cookie("comics",$('#menu').val(), { expires: expirationDate });
			}); // .click()

			$('#clear').click(function() {
				$.cookie("comics","", { expires: -5 });
			}); // .click()

			if ($.cookie("comics") != null) {
				var arr = $.cookie("comics").split(',');
				$('#comicstrip').html('');
				$.each(arr, function(val) {
					//alert(arr[val]);
					var cmx = json.comics[arr[val]-1];
					$('<h4><a href="' + cmx.url + '">' + cmx.title + '</a> by ' + cmx.author + '</h4><img height="' + cmx.height +'" width="' + cmx.width + '" src="' + cmx.image + '"/>').appendTo('#comicstrip');
				}); // .each()
			};
		}); // .getJSON()

}); // ready()
