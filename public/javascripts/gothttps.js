
jQuery(document).ready(function() 
{
  //alert($('#domains tr:odd'));
  jQuery('tr.detail').hide();
  //$('#domains tr:first-child').show();
  jQuery('tr.summary').click(function(){
      jQuery(this).next('tr').toggle();
      jQuery(this).find('.arrow').toggleClass('up');
  }); 
  
  //add helper popups
  
  jQuery('.bubblehelp').each(function(e){
    var element = jQuery(this);
    var help_id = element.attr('id')+'_info';
    var popup = jQuery('#'+help_id)
    popup.addClass('bubble');
  });
  
  jQuery('.bubble').hide();
  
  jQuery('.bubblehelp')
    .append('<img src="/images/help-icon.png"/>')
    .click(function(e){
    
    var element = jQuery(this);
    var help_id = element.attr('id')+'_info';
    var popup = jQuery('#'+help_id);
    
    //hide other bubbles
//    jQuery('.bubble').hide();
    
    popup.slideToggle();
    
    var popup_height = popup.height();
    
    var pos = element.position();
    
    popup.css({ position: "absolute",
            marginLeft: 0, marginTop: 0,
            top: pos.top+60, left: pos.left });
    
    popup.click(function(e){
      jQuery(this).hide();
    });
  });
});

