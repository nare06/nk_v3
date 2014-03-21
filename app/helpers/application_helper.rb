module ApplicationHelper
def current_user?(user)
  user == current_user
end
     def pushed?(event)
     @user = current_user
     @push = Pushid.where(:user_id => @user.id, :event_id => event.id).first_or_initialize
     @push.gcpush_id.present? 
     end 
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end
end
