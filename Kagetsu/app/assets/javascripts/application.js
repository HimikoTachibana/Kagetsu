//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.turbolinks
//= require turbolinks
//= require polling
//= require_tree .

$(document).on('turbolinks:load', function() {
	$("#toggle-button").click(function(e){
		e.preventDefault();
		$("#wrapper").toggleClass("toggled");
	});
	
	$("#physical-slider").change(function () {                    
		var newValue = $('#physical-slider').val();
		$("#physical-output").html(newValue);
	});
	
	$("#magical-slider").change(function () {                    
		var newValue = $('#magical-slider').val();
		$("#magical-output").html(newValue);
	});
	
	$("#special-slider").change(function () {                    
		var newValue = $('#special-slider').val();
		$("#special-output").html(newValue);
	});

	$('#friend-lookup-form').on('ajax:before', function(event, data, status){
		show_spinner();
	});

	$('#friend-lookup-form').on('ajax:after', function(event, data, status){
		hide_spinner();
	});

	$('#friend-lookup-form').on('ajax:success', function(event, data, status){
		$('#friend-lookup').replaceWith(data);
		init_friend_lookup();
	});

	$('#friend-lookup-form').on('ajax:error', function(event, xhr, status, error){
		hide_spinner();
		$('#friend-lookup-results').replaceWith('');
		$('#friend-lookup-errors').replaceWith('Person was not found');	
	});
});

function hide_spinner() {
	$('#spinner').hide();
}

function show_spinner() {
	$('#spinner').show();
}

