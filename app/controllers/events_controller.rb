class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @email = params[:email]
    if(@email)
      @rsvp = Rsvp.for_email_at_event(@email, @event)
    end
  end
  
  def badges
    @event = Event.find(params[:event_id])
    puts "Got event #{@event.title}"
  end
    
  def badges_pdf
        # generate PDFs of badges (and programmes?)
    require "prawn"

    prefix = 'tahoe_badges'

#    "LETTER" => [612.00, 792.00]

    f = Tempfile.new(prefix, "#{Rails.root}/tmp")

    Prawn::Document.generate(f.path, :page_size => "LETTER") do

      event = Event.find(1)

      count = 0
      top = 692
      User.attending(event).each do |guest|
        left = (count % 2) * 250
        bounding_box [left, top], :width => 250, :height => 100 do
          bounding_box [10, 90], :width => 230 do
            font("Times-Roman", :size => 18) do
              text guest.name
            end
          end
          if(guest.has_location?)
            bounding_box [10, 50], :width => 100 do
              font("Helvetica", :size => 20, :style => :bold) do
                text guest.distance_from(event).to_i.to_s
              end
              font("Helvetica", :size => 10) do 
                text "miles travelled"
              end
            end
          end
          if(guest.has_address?)
            bounding_box [10, 65], :width => 150 do
              font("Helvetica", :size => 10, :style => :bold) do
                text "#{guest.region}, #{guest.country}"
              end
            end
          end

          #text "#{left}, #{top}"
          #text "count: #{count}"
          stroke_bounds
          #stroke_circle [0, 0], 10
          #if(count > 0 && count % 2 == 0)
          #  move_down 150
          #end
        end
        count += 1
        if(count % 2 == 0)
          top -= 100
        end
        if((count % 14)==0)
          top = 692
          left = 0
          start_new_page
        end
      end
    end

    if(params[:download])
      disposition = 'attachment'
    else
      disposition = 'inline'
    end

    send_data f.read, :filename => 'hello.pdf', 
                          :type => "application/pdf", :disposition => disposition
    f.close
  end
end
