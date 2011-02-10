
jQuery(document).ready(function() 
{
  //alert($('#domains tr:odd'));
  jQuery('tr.detail').hide();
  //$('#domains tr:first-child').show();
  jQuery('tr.summary').click(function(){
      jQuery(this).next('tr').toggle();
      jQuery(this).find('.arrow').toggleClass('up');
  }); 
});