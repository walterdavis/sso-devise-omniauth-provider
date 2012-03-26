$(document).ready(function() {
	$('.hide_migration').click(function(){
		$(this).parent('.flash').slideUp();
		$.cookie('hide_migration','please', {expires: 365, path: '/'});
	});
});