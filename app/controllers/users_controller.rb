class UsersController < ApplicationController
#  load_and_authorize_resource
  
  # PUT /people/1
  # PUT /people/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { 
          #redirect_to(@rsvp, :notice => 'Rsvp was successfully updated.') 
          redirect_to user_addresses_path, :notice => 'User was successfully updated.'
        }
        format.xml  { head :ok }
        format.js { render :text => "Updated #{@user.name}" }
      else
        flash[:notice] = "Error saving: #{@user.errors.to_a.join(', ')}"
        format.html { redirect_to user_addresses_path }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.js  { render :json => @user.errors, :status => :unprocessable_entity }        
      end
    end
  end
  
  def photos
    
  end
  
end
