class Domain < ActiveRecord::Base

  def self.find_latest
    # yuck, but there is no other way. 
    Domain.find_by_sql "select * from domains where id in (select max(id) from domains group by name)"
  end

end
