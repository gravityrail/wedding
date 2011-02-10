jQuery.noConflict();
click_id = '';

// Document on load
jQuery(document).ready(function() 
{
    form_input_classes();
    form_labelize();

//    jQuery('#updates').tabs({ selected: 2 });
//    jQuery('#res-tabs-wrapp').tabs();
//    jQuery('#cloud-content').tabs();

    /*
jQuery('#hero-cycle').cycle({
        timeout: 5000,
        prev:   '#hero-prev', 
        next:   '#hero-next'
    });
*/

    /*
jQuery('#hero-pause').toggle(
        function() { 
            jQuery('#hero-cycle').cycle('pause');
        },
        function() {
            jQuery('#hero-cycle').cycle('resume');
        }
    );
*/

    var path = location.pathname.substring(1);
    if (path != '') {
      jQuery('#header-nav li a[href$="' + path + '"]').addClass('selected'); // check path as typed exactly
      jQuery('#header-nav li a[href$="' + path + '/"]').addClass('selected'); // check path with an extra trailing slash added
    }
    else {
       jQuery('#header-nav li:eq(0) a').addClass('selected'); // check home menu
    }
/*

    jQuery('ul.sf-menu').superfish({
        pathClass: 'selected',
        autoArrows: false,
        dropShadows: false
    });
*/

    if (click_id != undefined) setTimeout("jQuery('#"+click_id+"').trigger('click');",500);
});

function form_input_classes()
{
    jQuery('input[type="text"]').addClass('text');
    jQuery('input[type="password"]').addClass('text');
    jQuery('input[type="checkbox"]').addClass('checkbox');
    jQuery('input[type="radio"]').addClass('radiobutton');
    jQuery('input[type="submit"]').addClass('submit');
    jQuery('input[type="image"]').addClass('buttonImage');
}

function form_labelize(){  jQuery(".labelize input:text").clearingInput(); }   

function automatic_overlay(cid) { if (jQuery.cookie("overlay_"+cid) != '1') click_id = cid; } 

// Donate form remake
var donateTable = {
    table1: 'contribtable1',
    table2: 'contribtable2',
    remake: function() {    
       if (jQuery("input#processbutton").length ==  0) { jQuery('a#details').hide(); jQuery('#campaign-lead').hide(); } // on thank you page hide "your deails are secure..." and also hide lead text on second step
       else 
       {   
       var table = jQuery('form#contribution table').eq(0);
       var tr = table.find('tr').eq(0);
       var tds = tr.find('td.contribcolumn');

        // make it one column
        var table1 = tds.eq(0).find('table').eq(0);
        table1.addClass(this.table1);
        var table2 = tds.eq(2).find('table').eq(0);
        table2.addClass(this.table2);
  
        // insert new submit button
        table.before(table1).before(table2).before('<input type="image" id="submit-btn" src="/page/-/img/btn_donate.png">');
  
        // delete old table
        table.remove();
   
        // move last name field bellow first name
        var input_ln = jQuery("input[name='lastname']");
        var tr_ls = jQuery(document.createElement('tr'));
        input_ln.parents('tr').eq(0).after(tr_ls);
        tr_ls.html(input_ln.parent());

        // add nbsp in label before address2 input
        var input_addr2 = jQuery("input[name='addr2']");
        input_addr2.parent().find('label').html('&nbsp;'); 

        // state/region/province
        jQuery("[name='state_cd']").parent().find("label").html(jQuery("[name='state_cd']").parent().find("label").html().replace("/p","/ p"));

        // tick default 
        if ( ! jQuery("input[name='amount']").is(':checked') ) jQuery('#amt_preset_3').attr('checked', true);

        // remove err spans
        jQuery('span.error').next().remove();
        jQuery('span.error').remove();
        }
    }
}

// Signup form remake
var signupTable = {
    remake: function() {
        if (jQuery("input[name='submit-btn']").length ==  0) {jQuery('a#details').hide();} // on thank you page hide "your deails are secure..."
        jQuery("input[name='firstname']").parent().parent().parent().parent().parent().parent().parent().parent().after('<tr id="clonetr"></tr>');
        jQuery("input[name='lastname']").parent().parent().parent().clone().appendTo('#clonetr');
        jQuery("input[name='lastname']:first").parent().parent().parent().remove();
        //jQuery("input[name='addr2']").before('<label></label>');
        //jQuery("[name='state_cd']").parent().parent().find("label").html(jQuery("[name='state_cd']").parent().parent().find("label").html().replace("/R","/ R"));
        jQuery("input[name='submit-btn']").replaceWith('<input type="image" id="submit-btn" src="/page/-/img/contact_btn_send.png">');
        jQuery("span.signuperror").html('Please fill in the required fields below');
        if (gup('email') != '') setTimeout('jQuery("input#email").val(decodeURIComponent(gup("email")))',500); // read get parameter - email
        if (gup('country') != '') setTimeout('jQuery("select#country").val(gup("country"))',500); // read get parameter - country
    }
}

// Contact form remake
var contactTable = {
    remake: function() {              
        if (jQuery("input[name='submit-btn']").length ==  0) { jQuery('a#details').hide(); jQuery('#quote-link').html(''); } // on thank you page hide "your deails are secure..." and delete "We want to hear from you"
        jQuery("input[name='submit-btn']").replaceWith('<input type="image" id="submit-btn" src="/page/-/img/contact_btn_send.png">');
    }
}  

// Campaign form remake
var campaignTable = {
    remake: function(button) {              
        if (button == 'Vote Now') button = 'btn_vote_now.png'; 
        else if (button == 'Send') button = 'btn_send.png'; 
        else button = 'btn_sign.png';        
        if (jQuery("input[name='submit-btn']").length ==  0) {jQuery('a#details').hide();} // on thank you page hide "your deails are secure..."
        jQuery("input[name='firstname']").parent().parent().parent().parent().parent().parent().parent().parent().after('<tr id="clonetr"></tr>');
        jQuery("input[name='lastname']").parent().parent().parent().clone().appendTo('#clonetr');
        jQuery("input[name='lastname']:first").parent().parent().parent().remove();
        //jQuery("[name='state_cd']").parent().parent().find("label").html(jQuery("[name='state_cd']").parent().parent().find("label").html().replace("/R","/ R"));        
        jQuery("input[name='submit-btn']").replaceWith('<input type="image" id="submit-btn" src="/page/-/img/'+button+'">');
        jQuery('#tab-campaign').click();    
    }
}  

// Invite form remake
var inviteTable = {
    remake: function() {              
        if (jQuery("input[name='submit_button']").length ==  0) { jQuery('a#details').hide(); jQuery('#campaign-lead').hide(); } // on thank you page hide "your deails are secure..." and campaign lead
        jQuery("input[name='submit_button']").replaceWith('<input type="image" id="submit-btn-invite" src="/page/-/img/contact_btn_send.png">');
        if (gup('no_ty') == 1) {jQuery(".thank-you").hide();}
        jQuery('td.field:eq(4)').css('padding-top','18px');
        jQuery('td.field:eq(5)').css('padding-top','18px');
        jQuery('.bsd-shareButtons-wrap').parent().parent().find('td').css('padding','0');
        jQuery('#campaign-content .Apple-style-span:first').hide();
    }
}  

// Overlay signup form remake
var overlaySignupTable = {
    remake: function() {
        if (jQuery("input[name='submit-btn']").length ==  0) {jQuery('a#details').hide();} // on thank you page hide "your deails are secure..."
        jQuery("input[name='firstname']").parent().parent().parent().parent().parent().parent().parent().parent().after('<tr id="clonetr"></tr>');
        jQuery("input[name='lastname']").parent().parent().parent().clone().appendTo('#clonetr');
        jQuery("input[name='lastname']:first").parent().parent().parent().remove();
        //jQuery("input[name='addr2']").before('<label></label>');
        //jQuery("[name='state_cd']").parent().parent().find("label").html(jQuery("[name='state_cd']").parent().parent().find("label").html().replace("/R","/ R"));
        jQuery("input[name='submit-btn']").replaceWith('<input type="image" id="submit-btn" src="/page/-/img/btn_send.png">');
        jQuery("span.signuperror").html('Please fill in the required fields below');
        if (gup('email') != '') setTimeout('jQuery("input#email").val(decodeURIComponent(gup("email")))',500); // read get parameter - email
        if (gup('country') != '') setTimeout('jQuery("select#country").val(gup("country"))',500); // read get parameter - country
    }
}

// This function formats numbers by adding commas
function numberFormat(nStr){
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1))
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    return x1 + x2;
}

// Retrieve signup counter
function count_signups(form_id, goal)
{
    if (form_id == undefined) form_id = jQuery("input[name='form_id']").val();
    if (goal == undefined) goal = jQuery("input[name='goal']").val();

    function load_counter(data){
        jQuery('.members-white-txt').css('display','block');
        jQuery('.members-black-txt').css('display','block');
        jQuery('#campaign-meter').show();
        jQuery('#signup_counter').html(numberFormat(data));
        //jQuery('#campaign-meter-background').css('width',count_percent(data,goal)+'%');
        jQuery("#campaign-meter-background").animate({width:count_percent(data,goal)+"%"}, 3000, 'swing');
    }

    function count_percent(count,goal) {
        percent = Math.round(100/parseInt(goal)*parseInt(count));
        return percent > 100 ? 100 : percent;
    }

    jQuery('#singup_goal').html(numberFormat(goal));       
    jQuery.get("/utils/cons_counter/signup_counter.ajax.php?signup_form_id="+form_id, load_counter); 
}

// Get URL parameter
function gup( name )
{
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]"); 
    var regexS = "[\\?&]"+name+"=([^&#]*)";  
    var regex = new RegExp( regexS );  
    var results = regex.exec( window.location.href );  
    if( results == null ) return "";  
    else return results[1];
}