// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  //$('.watermark').clearingInput();
  form = $('form.edit_rsvp');

  $.backstretch("/images/melbourne.jpg");

  //make input buttons style-able with icons
  /*$('input:submit, input:reset').each(function(){
    $(this).replaceWith('<button class="'+$(this).attr('class')+'" type="' + $(this).attr('type') + '">' + $(this).val() + '</button>');
  });*/


  form.find('#attending').buttonset();  
	form.find('#attending_day').buttonset();  
	
  $('.button').button();
  $('.add-button').button({icons: {primary: 'ui-icon-circle-plus'}});
  $('.save-button').button({icons: {primary: 'ui-icon-check'}});
  $('.search-button').button({icons: {primary: 'ui-icon-search'}});
  $('.back-button').button({icons: {primary: 'ui-icon-triangle-1-w'}});
  $('.logout-button').button({icons: {primary: 'ui-icon-power'}});
  $('.account-button').button({icons: {primary: 'ui-icon-person'}});
  $('.admin-button').button({icons: {primary: 'ui-icon-wrench'}});
  $('.print-button').button({icons: {primary: 'ui-icon-print'}});
  $('.remove-button').button({icons: {primary: 'ui-icon-circle-close'}});

  $('.big-button').css({ width: '300px', 'padding-top': '10px', 'padding-bottom': '10px', 'font-size': '200%' });

  form.find('.fields').each(decorateRsvp);

	form.find('#not_attending_details').hide();
	form.find('#attending_details').hide();
	
	if(attendingValue('yes') || attendingValue('maybe')) {
		form.find('#attending_details').show();
	} else if(attendingValue('no')) {
		form.find('#not_attending_details').show();
	} else {
		
	}
	
	form.find('#attending :radio').click(function(){
		if($(this).val() != 'no') {
			$('#not_attending_details').hide();
    	$('#attending_details').slideDown(2000);
		} else {
			$('#attending_details').hide();
			$('#not_attending_details').slideDown(500);
		}
  });
	
  // //if no selected values, hide details and scroll down when selected
  //   if(typeof($('#attending :radio:checked').val()) == 'undefined') {
  //     
  //     
  //   } else if(attendingVal() == 'no') {
  // 		$('#not_attending_details')
  // 	}
// }

  //update fields on adding new child
  form.bind('nested:fieldAdded', decorateRsvp);
});

function attendingValue(queryVal) {
	var val = $('#attending :radio:checked').val();
	if(val == queryVal) {
		return true;
	}
	return false;
}

function decorateRsvp() {
//  $(this).find('.watermark').watermark();
  $(this).find('#rsvp_submit').button();
  $(this).find('.button').button();
  $(this).find('.guest').accordion(); 
  $(this).find('#diet_preferences').buttonset();  
}
