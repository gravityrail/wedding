module ApplicationHelper
  def tick(value)
    if(value == 1)
      "<span class='tick'>yes</span>"
    elsif(value == 0)
      "<span class='cross'>no</span>"
    elsif(value == 2)
      "<span class='na'>not applicable</span>"
    end
  end

  def tick_mixed(value)
    if(value == 1)
      "<span class='cross'>yes</span>"
    elsif(value == 0)
      "<span class='tick'>no</span>"
    elsif(value == 2)
      "<span class='na'>not applicable</span>"
    end
  end

  def dom_show(value)
    if(value == 1)
     "Yes"
    elsif(value == 0)
      "No"
    elsif(value == 2)
      "Not Applicable"
    end
  end
end
