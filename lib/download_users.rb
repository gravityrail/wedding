class DownloadUsers

  FIELDS = [
      "id" ,
      "email",
      "first_name",
      "last_name",
      "opt_in",
      "created_at",
      "updated_at",
      "fb_id"
    ]

  # additionally you could pass in arguments
  # to help initialize a specific scope
  def initialize
    @generated     = false
    @test_response = false
  end
  
  # this method is used in the CSV Responder
  # you could dynamically produce a filename here
  def to_filename
    "users.csv"
  end
  
  # our testing showed that this method is called on 3 separate occasions
  # we could not determine why this happens, so we introduced guard clauses
  def each(&block)
    
    # first time each() is called
    if (@test_response == false)
      @test_response = true
      return
    end
    
    # if we have already generated content, return, otherwise generate
    return if @generated
    
    # generate a CSV header
    yield generate_header()
    
    # generate the CSV content
    # in our production code, we have this method being called in a X.times {} cycle
    # where the block passes the iteration number into the method, calculates and returns data
    # X.times { |t| generate_content(t) }
    yield generate_content()
    
    # generate a CSV footer
    yield generate_footer()
    
    # this lets the renderer know we are done
    yield "\r\n"
    
    @generated = true
  end
  
  # without this method, yielding a string
  # Cache-Control is not sent as specified in our custom responder
  def all?
    yield "generated-string"
  end
  
  private
  
  def generate_header

    return FasterCSV.generate_line(FIELDS)
  end
  
  def generate_content
    # do something here, returning the output
    # this method could be called inside of an iterative loop
    # producing calculated results each time it is called
    users = User.where({}, :order => 'id')
    lines = []
    
    users.each do |user|
      data = FIELDS.collect{|item| user.send(item)}
      lines << FasterCSV.generate_line(data)
    end
    
    lines
  end
  
  def generate_footer
    #csv_footer = ["end", "end", "end", "end"]
    
    #return FasterCSV.generate_line(csv_footer)
    ""
  end

end