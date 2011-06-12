RailsAdmin.config do |config|
  config.excluded_models << RsvpGuest

  config.model Rsvp do 
#    parent Event
    edit do
      form_builder :nested_form_for
    end
    list do
      field :title do
        label 'Attendees'
      end
      field :event do
        formatted_value do
          value.title
        end
      end
    end
  end

  config.model Event do 
    object_label_method do
      :title
    end

    edit do
      field :description, :text do
        ckeditor true
      end
      field :accommodation, :text do
        ckeditor true
      end
      field :presents, :text do
        ckeditor true
      end

    end
    

    list do 
      field :title
      field :start_date
      field :end_date
    end
  end

  config.model User do
    list do
      field :first_name
      field :last_name
      field :email
      field :region
      field :country
    end
  end


  # config.model Rsvp do
  #   list do
  #     field :name do
  #       formatted_value do
  #         value.to_s.upcase
  #       end
  #     end
  #     field :created_at
  #   end
  # end
  
#  config.model Rsvp do
#    form_builder :nested_form_for
#  end
end

