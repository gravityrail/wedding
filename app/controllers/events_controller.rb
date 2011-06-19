class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @email = params[:email]
    if(@email)
      @rsvp = Rsvp.for_email_at_event(@email, @event)
    end
  end
end
