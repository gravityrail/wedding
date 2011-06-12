module ApplicationHelper
  def remove_link_unless_new_record(fields)
    unless fields.object.new_record?
      out = ''
      out << fields.hidden_field(:_destroy)
      out << link_to_function("remove", "$(this).parent('.#{fields.object.class.name.underscore}').hide(); $(this).prev().val('1')")
      raw out
    end
  end

  def add_guest_link(name, form, opts = {})
    link_to_function name, opts do |page|
      guest = render(:partial => 'rsvps/new_guest', :locals => { :form => form, :guest => User.new, :child_index => 1000 })
      page << %{var new_guest_id = "new_" + new Date().getTime(); $('#guests').append($("#{ escape_javascript guest }".replace(/new_\\d+/g, new_guest_id)));}
      #I wish this wasn't evil: $('#partners .partner:last-child input').first().focus();
    end
  end
end
