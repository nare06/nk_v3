class Push2fbController < ApplicationController

before_filter :authenticate_user!
def push
@event = Event.find_by_id(params[:id])
@user = current_user
 Rails.logger.info @user 
@fauth = @user.authorizations.where(provider: 'facebook').last
   if !@fauth.present?
      redirect_to '/users/auth/facebook'
=begin 
    token = exchange_access_token_info(@fauth.token)
    @fauth.token = token
    @fauth.save!
=end
    else [ 

     if Time.now < @fauth.updated_at + 59.days
        graph = Koala::Facebook::GraphAPI.new(@fauth.token)
         blah = {
:name => @event.title, :description => @event.organizer, :start_time => @event.sdatetime.to_datetime, :end_time => @event.edatetime.to_datetime, :privacy => 'FRIENDS'
}

@dump=graph.put_object('me', 'events', blah) 
Rails.logger.info @dump
 @push = Pushid.where(:user_id => @user.id, :event_id => @event.id).first_or_initialize
    @push.user_id =@user.id
    @push.event_id = @event.id
    @push.fbpush_id = @dump["id"]
   #  @push.gcpush_htmllink = @result.data.htmlLink
    @push.save! 
redirect_to root_path, notice: "Event: #{@event.title}<-------> Successfully Pushed into Facebook" 
      else
      redirect_to '/users/auth/facebook'
      end  ]
end
end
def destroy
@event = Event.find_by_id(params[:id])
@user = current_user 
@fauth = @user.authorizations.where(provider: 'facebook').last 
@push = Pushid.where(:user_id => @user.id, :event_id => @event.id).first_or_initialize
     if Time.now < @fauth.updated_at + 59.days
        graph = Koala::Facebook::GraphAPI.new(@fauth.token)   
        @dump=graph.delete_object(@push.fbpush_id) 
      if @dump
      @push.destroy
      redirect_to root_path, notice: "Event: #{@event.title}<-------> Successfully deleted the event | Facebook"
      else
      redirect_to root_path, notice: 'Failed to delete. Try again'
      end  
else
 redirect_to '/users/auth/facebook'
end
end
end
