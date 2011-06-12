class RsvpsController < ApplicationController
  #load_and_authorize_resource

  #find an RSVP by email
  def complete
    email = params[:email]

    #gb = Gibbon::API.new(SITE['mc_api_key'])

#    @users = gb.lists()

    #@users = gb.list_member_info({:id => SITE['mc_list_id'], :email_address => [email]})   

    @event = Event.find(params[:event_id])
    @rsvp = Rsvp.for_email_at_event(email, @event)
  end

  def search
    email = params[:search_rsvp][:email]
    @event = Event.find(params[:search_rsvp][:event_id])
    @rsvp =  Rsvp.for_email_at_event(email, @event)
    if(@rsvp)
      redirect_to :action => 'complete', :event_id => @event.id, :email => email
    else
      flash[:notice] = "Email not found #{email}. Please email wedding@secretloveadventure.com if you think you're seeing this message in error."
      redirect_to :root
    end
  end

    # GET /people
  # GET /people.xml
  def index
    @people = Rsvp.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @rsvp = Rsvp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rsvp }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @rsvp = Rsvp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rsvp }
    end
  end

  # GET /people/1/edit
  def edit
    @rsvp = Rsvp.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @rsvp = Rsvp.new(params[:rsvp])

    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to(@rsvp, :notice => 'Rsvp was successfully created.') }
        format.xml  { render :xml => @rsvp, :status => :created, :location => @rsvp }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rsvp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @rsvp = Rsvp.find(params[:id])
    @event = Event.find(params[:event_id])

    respond_to do |format|
      if @rsvp.update_attributes(params[:rsvp])
        format.html { 
          #redirect_to(@rsvp, :notice => 'Rsvp was successfully updated.') 
          redirect_to(@event, :notice => 'Rsvp was successfully updated.') 
        }
        format.xml  { head :ok }
      else
        flash[:notice] = "Error saving: #{@rsvp.errors.to_a.join(', ')}"
        format.html { render :action => "complete", :id => @rsvp.guests.first.email }
        format.xml  { render :xml => @rsvp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @rsvp = Rsvp.find(params[:id])
    @rsvp.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end

end
