// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  //$('.watermark').clearingInput();
  form = $('form.edit_rsvp');

  $.backstretch("/images/tahoe.jpg");

  form.find('#attending').buttonset();  
  $('.button').button();
  $('.add-button').button({icons: {primary: 'ui-icon-circle-plus'}});
  $('.save-button').button({icons: {primary: 'ui-icon-check'}});
  $('.back-button').button({icons: {primary: 'ui-icon-triangle-1-w'}});
  $('.logout-button').button({icons: {primary: 'ui-icon-power'}});
  $('.account-button').button({icons: {primary: 'ui-icon-person'}});
  $('.admin-button').button({icons: {primary: 'ui-icon-wrench'}});
  $('.print-button').button({icons: {primary: 'ui-icon-print'}});
  $('.remove-button').button({icons: {primary: 'ui-icon-circle-close'}});

  $('.big-button').css({ width: '300px', 'padding-top': '10px', 'padding-bottom': '10px', 'font-size': '200%' });

  form.find('.fields').each(decorateRsvp);


  //if no selected values, hide details and scroll down when selected
  if(typeof($('#attending :radio:checked').val()) == 'undefined') {
    form.find('#attending_details').hide();
    form.find('#attending :radio').click(function(){
      $('#attending_details').slideDown(2000);
    });
  }

  //update fields on adding new child
  form.bind('nested:fieldAdded', decorateRsvp);
});

function decorateRsvp() {
//  $(this).find('.watermark').watermark();
  $(this).find('#rsvp_submit').button();
  $(this).find('.button').button();
  $(this).find('.guest').accordion(); 
  $(this).find('#diet_preferences').buttonset();  
}
