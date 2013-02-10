jQuery(document).ready(function($) {
                //document.title = "plutonicXreddit: /r/" + subReddit;
                //$("#loading").html('<img src="/reddit/spinner.gif" alt="Wait" />');
                myComics = $.getJSON("comics.json", function(json){
                        //$("#loading").html('');
                        $.each(json.comics, function(key, val) {
				$('#menu').append('<option class="option" value=' + val.id + '>' + val.title + '</option>');
                        }); // each()

			$('#menu').change(function() {
				var id = $('#menu').val()-1;
				var cmx = json.comics[id];
				$('#comicstrip').html('<h4><a href="' + cmx.url + '">' + cmx.title + '</a> by ' + cmx.author + '</h4><img src="' + cmx.image + '"/>');
	                });
		}); // .getJSON()

}); // ready()
