class Add2gcalendarController < ApplicationController
before_filter :authenticate_user!
def push  
      @evnt = Event.find_by_id(params[:id])
      event = {'summary' => @evnt.title,'location' => @evnt.location,'start' => {'dateTime' => @evnt.sdatetime.to_datetime.rfc3339},'end' => {'dateTime' => @evnt.edatetime.to_datetime.rfc3339}}
      @user = current_user
      @gauth = @user.authorizations.where(provider: 'google_oauth2').first_or_initialize
 
      if @gauth.present? 
           
       client = Google::APIClient.new
       client.authorization.client_id = ENV['GOOGLE_KEY']
      client.authorization.client_secret = ENV['GOOGLE_SECRET']      
      if Time.now < @gauth.updated_at + 3600
        client.authorization.access_token = @gauth.token
      else
      
      client.authorization.access_token = @gauth.token
      client.authorization.refresh_token = @gauth.secret
       client.authorization.fetch_access_token!
        @gauth.token = client.authorization.access_token
        @gauth.save!
      end
      service = client.discovered_api('calendar', 'v3')                        
      @result = client.execute(
    :api_method => service.events.insert,
    :parameters => {'calendarId' => 'primary'},
    :body => event.to_json, 
    :headers => {'Content-Type' => 'application/json'}) 
   # Rails.logger.info @result
    @push = Pushid.where(:user_id => @user.id, :event_id => @evnt.id).first_or_initialize
    @push.gcpush_id = @result.data.id
     @push.gcpush_htmllink = @result.data.htmlLink
    @push.save!   
    redirect_to root_path, notice: "Event:#{@evnt.title}<-------> Successfully pushed into Google Calendar"
        #render "new"   
else 
    redirect_to '/users/auth/google_oauth2'
end 
end
def edit
 event = Event.find_by_id(params[:id])
     @user = current_user 
   @push = Pushid.where(:event_id => event.id, :user_id => @user.id).first 
   redirect_to @push.gcpush_htmllink

end
def destroy
     event = Event.find_by_id(params[:id])
     @user = current_user
      @gauth = @user.authorizations.where(provider: 'google_oauth2').first_or_initialize
      @push = Pushid.where(:event_id => event.id, :user_id => @user.id).first 
           
       client = Google::APIClient.new
       client.authorization.client_id = ENV['GOOGLE_KEY']
      client.authorization.client_secret = ENV['GOOGLE_SECRET']      
      if Time.now < @gauth.updated_at + 3600
        client.authorization.access_token = @gauth.token
      else
      
      client.authorization.access_token = @gauth.token
      client.authorization.refresh_token = @gauth.secret
       client.authorization.fetch_access_token!
        @gauth.token = client.authorization.access_token
        @gauth.save!
      end
      service = client.discovered_api('calendar', 'v3')                        
      @result = client.execute(
    :api_method => service.events.delete,
    :parameters => {'calendarId' => 'primary','eventId' => @push.gcpush_id}) 
   # Rails.logger.info @result
    @push.destroy
    @push.save!
    redirect_to root_path, notice: "Event: #{event.title}<----> Successfully deleted from Google Calendar"  
    
  
end
end
